using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Documents;
using System.Windows.Media;
using System.Windows.Threading;
using CompilePalX.Compilers;
using CompilePalX.Compiling;
using System.Runtime.InteropServices;
using CompilePalX.Annotations;
using CompilePalX.Configuration;

namespace CompilePalX
{
    internal delegate void CompileCleared();
    internal delegate void CompileStarted();
    internal delegate void CompileFinished();

    class Map : INotifyPropertyChanged
    {
        private string file;

        public string File
        {
            get => file;
            set { file = value; OnPropertyChanged(nameof(File));  }
        }

        private bool compile;
        public bool Compile 
        {
            get => compile;
            set { compile = value; OnPropertyChanged(nameof(Compile));  }
        }

        public Map(string file, bool compile = true)
        {
            File = file;
            Compile = compile;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    static class CompilingManager
    {
        static CompilingManager()
        {
            CompilePalLogger.OnErrorFound += CompilePalLogger_OnErrorFound;
        }
            
        private static void CompilePalLogger_OnErrorFound(Error e)
        {
            currentCompileProcess.CompileErrors.Add(e);

            if (e.Severity == 5 && IsCompiling)
            {
                //We're currently in the thread we would like to kill, so make sure we invoke from the window thread to do this.
                MainWindow.ActiveDispatcher.Invoke(() =>
                {
                    CompilePalLogger.LogLineColor("An error cancelled the compile.", Error.GetSeverityBrush(5));
                    CancelCompile();
                    ProgressManager.ErrorProgress();
                });
            }
        }

        public static event CompileCleared OnClear;
        public static event CompileFinished OnStart;
        public static event CompileFinished OnFinish;

        public static TrulyObservableCollection<Map> MapFiles = new TrulyObservableCollection<Map>();

        private static Thread compileThread;
        private static Stopwatch compileTimeStopwatch = new Stopwatch();

        public static bool IsCompiling { get; private set; }

        public static void ToggleCompileState(int index)
        {
            if (IsCompiling)
                CancelCompile();
            else
                StartCompile(index);
        }

        public static void StartCompile(int index)
        {
            if(index == 4)
            {
                
                if (CompilingManager.MapFiles.Count > 0)
                {
                    if(!CompilingManager.MapFiles[0].File.Contains(".vmf"))
                    {
                        string bspsrcpath = "\"./bspsrc/bspsrc.jar\"";
                        string test = System.IO.Path.GetFileNameWithoutExtension(CompilingManager.MapFiles[0].File);
                        string csgopath = GameConfigurationManager.GameConfiguration.GameFolder + "/Decompiled_Maps";
                        string targetpath = "\"" + csgopath + "/" + test + "_d.vmf\"";
                        string bsppath = "\"" + System.IO.Path.GetFullPath(CompilingManager.MapFiles[0].File) + "\"";
                        if (!Directory.Exists(csgopath))
                        {
                            Directory.CreateDirectory(csgopath);
                        }
                        System.Diagnostics.Process process = new System.Diagnostics.Process();
                        System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
                        startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                        startInfo.FileName = "cmd.exe";
                        string param = "/C java -jar " + bspsrcpath + " -unpack_embedded -o " + targetpath + " " + bsppath;
                        startInfo.Arguments = param;

                        //Console.WriteLine(param);
                        process.StartInfo = startInfo;
                        process.Start();
                        process.WaitForExit();

                        string vmfdir = csgopath + "/" + test + "_d.vmf";
                        CompilingManager.MapFiles.RemoveAt(0);
                        CompilingManager.MapFiles.Add(new Map(vmfdir));
                        CopyFilesRecursively(csgopath + "/" + test + "_d", GameConfigurationManager.GameConfiguration.GameFolder);
                    }
                }
            }
            OnStart();

            // Tells windows to not go to sleep during compile
            NativeMethods.SetThreadExecutionState(NativeMethods.ES_CONTINUOUS | NativeMethods.ES_SYSTEM_REQUIRED);

            AnalyticsManager.Compile();

            IsCompiling = true;

            compileTimeStopwatch.Start();

            OnClear();

            CompilePalLogger.LogLine($"Starting a '{ConfigurationManager.CurrentPreset}' compile.");

            compileThread = new Thread(CompileThreaded);
            compileThread.Start();
        }

        private static CompileProcess currentCompileProcess;

        private static void CompileThreaded()
        {
            try
            {
                ProgressManager.SetProgress(0);

                var mapErrors = new List<MapErrors>();


                foreach (Map map in MapFiles)
                {
                    if (!map.Compile)
                    {
                        CompilePalLogger.LogDebug($"Skipping {map.File}");
                        continue;
                    }

                    string mapFile = map.File; 
                    string cleanMapName = Path.GetFileNameWithoutExtension(mapFile);

                    var compileErrors = new List<Error>();
                    CompilePalLogger.LogLine($"Starting compilation of {cleanMapName}");

					//Update the grid so we have the most up to date order
	                OrderManager.UpdateOrder();

                    GameConfigurationManager.BackupCurrentContext();
					foreach (var compileProcess in OrderManager.CurrentOrder)
					{
                        currentCompileProcess = compileProcess;
                        compileProcess.Run(GameConfigurationManager.BuildContext(mapFile));

                        compileErrors.AddRange(currentCompileProcess.CompileErrors);

                        //Portal 2 cannot work with leaks, stop compiling if we do get a leak.
                        if (GameConfigurationManager.GameConfiguration.Name == "Portal 2")
                        {
                            if (currentCompileProcess.Name == "VBSP" && currentCompileProcess.CompileErrors.Count > 0)
                            {
                                //we have a VBSP error, aka a leak -> stop compiling;
                                break;
                            }
                        }

                        ProgressManager.Progress += (1d / ConfigurationManager.CompileProcesses.Count(c => c.Metadata.DoRun &&
                            c.PresetDictionary.ContainsKey(ConfigurationManager.CurrentPreset))) / MapFiles.Count;
                    }

                    mapErrors.Add(new MapErrors { MapName = cleanMapName, Errors = compileErrors });
                    
                    GameConfigurationManager.RestoreCurrentContext();
                }

                MainWindow.ActiveDispatcher.Invoke(() => postCompile(mapErrors));
            }
            catch (ThreadAbortException) { ProgressManager.ErrorProgress(); }
        }

        private static void postCompile(List<MapErrors> errors)
        {
            CompilePalLogger.LogLineColor(
	            $"\n'{ConfigurationManager.CurrentPreset}' compile finished in {compileTimeStopwatch.Elapsed.ToString(@"hh\:mm\:ss")}", Brushes.ForestGreen);

            if (errors != null && errors.Any())
            {
                int numErrors = errors.Sum(e => e.Errors.Count);
                int maxSeverity = errors.Max(e => e.Errors.Any() ? e.Errors.Max(e2 => e2.Severity) : 0);
                CompilePalLogger.LogLineColor("{0} errors/warnings logged:", Error.GetSeverityBrush(maxSeverity), numErrors);

                foreach (var map in errors)
                {
                    CompilePalLogger.Log("  ");

                    if (!map.Errors.Any())
                    {
                        CompilePalLogger.LogLineColor("No errors/warnings logged for {0}", Error.GetSeverityBrush(0), map.MapName);
                        continue;
                    }

                    int mapMaxSeverity = map.Errors.Max(e => e.Severity);
                    CompilePalLogger.LogLineColor("{0} errors/warnings logged for {1}:", Error.GetSeverityBrush(mapMaxSeverity), map.Errors.Count, map.MapName);

                    var distinctErrors = map.Errors.GroupBy(e => e.ID);
                    foreach (var errorList in distinctErrors)
                    {
                        var error = errorList.First();

                        string errorText = $"{errorList.Count()}x: {error.SeverityText}: {error.ShortDescription}";

                        CompilePalLogger.Log("    ● ");
                        CompilePalLogger.LogCompileError(errorText, error);
                        CompilePalLogger.LogLine();

                        if (error.Severity >= 3)
                            AnalyticsManager.CompileError();
                    }
                }
            }

            OnFinish();

            compileTimeStopwatch.Reset();

            IsCompiling = false;

            // Tells windows it's now okay to enter sleep
            NativeMethods.SetThreadExecutionState(NativeMethods.ES_CONTINUOUS);
        }

        public static void CancelCompile()
        {
            try
            {
                compileThread.Abort();
            }
            catch
            {
            }
            IsCompiling = false;

            foreach (var compileProcess in ConfigurationManager.CompileProcesses.Where(cP => cP.Process != null))
            {
                try
                {
                    compileProcess.Cancel();
                    compileProcess.Process.Kill();

                    CompilePalLogger.LogLineColor("Killed {0}.", Brushes.OrangeRed, compileProcess.Metadata.Name);
                }
                catch (InvalidOperationException) { }
                catch (Exception e) { ExceptionHandler.LogException(e); }
            }

            ProgressManager.SetProgress(0);

            CompilePalLogger.LogLineColor("Compile forcefully ended.", Brushes.OrangeRed);

            postCompile(null);
        }

        public static Stopwatch GetTime()
        {
            return compileTimeStopwatch;
        }

        class MapErrors
        {
            public string MapName { get; set; }
            public List<Error> Errors { get; set; }
        }

        internal static class NativeMethods
        {
            // Import SetThreadExecutionState Win32 API and necessary flags
            [DllImport("kernel32.dll")]
            public static extern uint SetThreadExecutionState(uint esFlags);
            public const uint ES_CONTINUOUS = 0x80000000;
            public const uint ES_SYSTEM_REQUIRED = 0x00000001;
        }
        private static void CopyFilesRecursively(string sourcePath, string targetPath)
        {
            //Now Create all of the directories
            foreach (string dirPath in Directory.GetDirectories(sourcePath, "*", SearchOption.AllDirectories))
            {
                Directory.CreateDirectory(dirPath.Replace(sourcePath, targetPath));
            }

            //Copy all the files & Replaces any files with the same name
            foreach (string newPath in Directory.GetFiles(sourcePath, "*.*", SearchOption.AllDirectories))
            {
                File.Copy(newPath, newPath.Replace(sourcePath, targetPath), true);
            }
        }
    }
}
