   M S B A M L   `   `   `  ���� T  PMahApps.Metro, Version=1.4.3.0, Culture=neutral, PublicKeyToken=f4fb5a3c4d1e5b4ffCclr-namespace:MahApps.Metro.Controls.Dialogs;assembly=MahApps.MetroMahApps.Metro.Controls.Dialogs  F BCompilePalX, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:CompilePalXCompilePalX E'clr-namespace:CompilePalX.ConfigurationCompilePalX.Configuration    CompilePalX.MainWindow   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     ;controls,http://metro.mahapps.com/winfx/xaml/controls   QdialogsCclr-namespace:MahApps.Metro.Controls.Dialogs;assembly=MahApps.Metro   %localclr-namespace:CompilePalX   4config'clr-namespace:CompilePalX.Configuration   R NMahApps.Metro.IconPacks, Version=2.3.0.4, Culture=neutral, PublicKeyToken=null=	iconPacks-http://metro.mahapps.com/winfx/xaml/iconpacks  :d2http://schemas.microsoft.com/expression/blend/2008  Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  -     � Title$  Compile Pal X��$	��550��$	��790��$	��550��$	��790��(   "MahApps.Metro.Controls.MetroWindow   IconEdgeMode$ Aliased=� � Icon$ CompilePalIcon.ico��   ShowIconOnTitleBar .  $��1q�   AccentColorBrush#���      LeftWindowCommands +   %MahApps.Metro.Controls.WindowCommands  .@��� -    ��Name$ ConfigSelectButton�� � ToolTip$ Open Game Selector����/  )MahApps.Metro.IconPacks.MaterialExtension  *Menu+   RightWindowCommands   .@��� -   $ BugReportButton��$ Report a bug����  *Bug+ � TaskbarItemInfo *  $System.Windows.Shell.TaskbarItemInfo  .��� 	 � RowDefinitions	 �� $��80 �$��80��$	��240���� $��5 ��� .+��� -   
 ��Name$
 
MapListBox��$��0��$��
10,10,95,0q�#���   $��1q����� .R�]� $��Stretch=�.+��� $��
0, 0, 5, 0q����� *File+�� $��Right=� d� 	IsChecked �� *	Compile+ �� Mode$ TwoWay=��� -   $ AddMapButton��$��0��$��
Add Map...��$��	0,10,10,0q�$	��Top=�$��Right=�$��75���� -   $ RemoveMapButton��$��0��$��Remove��$��	0,45,10,0q�$	��Top=�$��Right=�$��75���� $��1��$��2��$��Stretch=�$	��512��,   &MahApps.Metro.Controls.MetroTabControl  $��2��-   'MahApps.Metro.Controls.TabControlHelper   IsUnderlined .    
Transition$ LeftReplace=�$��10,10,10,40q�.@�)   #MahApps.Metro.Controls.MetroTabItem  $��CONFIG��.��� ���	#FFE5E5E5 � ColumnDefinitions �� $
��Auto �$	��100���� $
��Auto �$	��100���� $��* �.+�]� $��0��$��
10,10,0,10q�
�������.+��� -   $ RemovePresetButton��$��Remove��$��5,0,5,5q�$��Bottom=�$��Bottom=��� -   $ ClonePresetButton��$��Clone...��$��5,0,5,5q�$��Bottom=�$��Bottom=��� -	   $ AddPresetButton��$��Add...��$��5,0,5,5q�$��Bottom=�$��Bottom=��� -
   $
 PresetConfigListBox��$��0,0,0,5q�]� $��1��$��
10,10,0,10q�
�������.+��� -   $ RemoveProcessesButton��$��Remove��$��Bottom=�$��5,0,5,5q�$��1���� -   $ AddProcessesButton��$��Add...��$��Bottom=�$��5,0,5,5q�$��2���� -   $
 CompileProcessesListBox��$��0,0,0,5q�$��0������ .R�]� $��Stretch=�.+��� $��
0, 0, 5, 0q����� �� -   $��Right=� �� *DoRun+$ TwoWay=�� $��2��	 �� $	��91* ��� $	��60* ��� $
��36px �.+�&   System.Windows.Controls.DataGrid  -     Name$ ConfigDataGrid��$��0��$��10,10,10,10q�   AutoGenerateColumns .     CanUserAddRows .  $��2������    Columns 0	  *System.Windows.Controls.DataGridTextColumn	  ,
  &System.Windows.Controls.DataGridColumn 
  Header$
 Name�� 
  
IsReadOnly . 1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *Name+4  .System.Windows.Controls.DataGridTemplateColumn  $ Value��   CellTemplate �� .R�� .+��� -   ���� *Value+ �� UpdateSourceTrigger$ PropertyChanged=�.������  �� 
TargetType" ��.���  �� Property � �� �� Value$ Center=� �� Triggers ��  �� Binding �� *ValueIsFile+ �� Value True.a���  � y�$ Hidden=���  �� *ValueIsFolder+ True.a���  � y�$ Hidden=�.��  CompilePalX.FileInput     FileDialogTitle$ Choose File��    Config  �� !   IsFolder! �� *ValueIsFolder+���� "   ��  �� *ValueIsFile+	 False.a���  � y�$ Hidden=���  �� *ValueIsFolder+ True.a���  �@ Hint$ Choose Folder��" 
  	CellStyle" �� *  $System.Windows.Controls.DataGridCell"   ��  �� *CanHaveValue+	 False.a���  � y�$ Hidden=�	  $ Description�� .  �� *Description+	  $ Warnings�� .  �� *	Warning+  -   #  Name$# 
ProcessTab��$��0��$y�Hidden=� . {�.  $��2��.@�  -   $  Name$$ 
ProgramTab��$��PROGRAMS��$��
5, 0, 0, 0q�.��  -   $ ProcessDataGrid��{�.  $y�Visible=�$��10,10,10,10q� .   .  ����    $ Program Path��% 
  CanUserSort% .   �� .R�  $ Choose Program��  ��   $ Command Line Arguments��% .  & 
  Width5  /System.Windows.Controls.DataGridLengthConverter$& *  �� .R��� -   ���� *Value2+$ PropertyChanged=�4  .System.Windows.Controls.DataGridCheckBoxColumn  $ Read Output��  MetroDataGridCheckBox'   ElementStyle#' �  (   EditingElementStyle#( �  % .   �� *
ReadOutput+$ TwoWay=�$ PropertyChanged=�  $ Wait For Exit��#' �  #( �  % .   �� *WaitForExit+$ TwoWay=�$ PropertyChanged=�  -   $$ OrderTab��$��ORDER��$��
5, 0, 0, 0q�.��  -   $ 	OrderGrid��$��10,10,10,10q� .   .  )   SelectionMode$) Single=�  CompilePalX.RowDragHelper*   EnableRowDrag* . ���� , &CompilePalX.Configuration.OrderManager+   CurrentOrder, �� Source#, Z+ - � 	Resources- . �� Color��%�   (��       *1/SystemColors.InactiveSelectionHighlightBrushKey+)(��      *53SystemColors.InactiveSelectionHighlightTextBrushKey+)�� #. Z���� #. Z�� 	  $ Original Order�� . % .   �� *
Ordering+	  $
 Name�� . $& * % .   �� *Name+	  $ Description�� . $& * % .   �� *Description+/   	CellStyle/ �� "   ��  �� *IsDraggable+	 False.a���  � �� �	#FFE5E5E5��  � ��$ 0q���  �@�FocusVisualStyle Z� ��  � ��
 �   ���  �� *IsDraggable+ True.a���  � ��$ 0q���  �@�FocusVisualStyle Z� 0   RowStyle0 �� )  #System.Windows.Controls.DataGridRow"  .�-   � $��2��.+��� -   1 ��Name$1 ParametersTextBox��$��
10,0,180,0q�$	��Top=�{�.  �� -   $ AddParameterButton��$��Add...��$
��10,0q�$��1��$��80��$��Right=�$	��Top=��� -   $ RemoveParameterButton��$��Remove��$��0,0,95,0q�$��1��$��80��$��Right=�$	��Top=��� -   $��Button��$
��Left=�$��375,-58,0,0q�$	��Top=�$��75��{�.  $y�Hidden=�  -   $$ 	OutputTab��$��OUTPUT��.��� ���	#FFE5E5E5.+��� -   2 ��Name$2 CompileOutputTextbox��3 �� 
IsReadOnly3 . 4 �� AcceptsReturn4 . "5 �� VerticalScrollBarVisibility$
5 Auto=�$��0q�$��10,10,10,10q�$,��&Segoe UI, Lucida Sans Unicode, Verdana)�6 �� IsReadOnlyCaretVisible6 . 7 �� 
LineHeight$7 2��8 �� IsDocumentEnabled8 . . �/� .T�J� -   9 J�Name$9 OutputParagraph���� -   $ CompileStartStopButton��$��2��$��Compile��$��10,10,10,10q�$��Bottom=�$��Right=�$��75��� -    : �Name$: CompileProgressBar��$��	0,0,96,10q�$��2��$��25��$��Bottom=�$��Right=�$	��200���� -!   ; ��Name$; UpdateLabel��$y�	Collapsed=�$��2��$��Bottom=�$
��Left=�$��10q�.���� -"   < ��Name$< UpdateHyperLink��$:��4https://github.com/ruarai/CompilePal/releases/latest?��� -#   $; TimeElapsedLabel��$y�	Collapsed=�$��2��$��Bottom=�$
��Bold"�$
��Left=�$��10q�