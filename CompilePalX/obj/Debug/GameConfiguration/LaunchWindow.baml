   M S B A M L   `   `   `  ����  CompilePalX    CompilePalX.LaunchWindow   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   T PMahApps.Metro, Version=1.4.3.0, Culture=neutral, PublicKeyToken=f4fb5a3c4d1e5b4f;controls,http://metro.mahapps.com/winfx/xaml/controls  5   	     � Title$  Game Selector��5   	   $	��444��6   $	��564��6,      AccentColorBrush#���   5      $��1q�6H   (  "MahApps.Metro.Controls.MetroWindow   IconEdgeMode$ Aliased=�5       � Icon$ ..\CompilePalIcon.ico��6.      ShowIconOnTitleBar .  .��5      � .+�5	   
   &   System.Windows.Controls.DataGrid  -   5          Name$ GameGrid��5	      $��10,10,10,40q�6%      AutoGenerateColumns .     CanUserAddRows .  ��6n   ��    Columns 5
      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$
 Name��6%   	   
IsReadOnly	 . 1  +System.Windows.Controls.DataGridBoundColumn
   Binding
 63   �� *Name+6M     5      $
 Path��6%   	 .    Width5  /System.Windows.Controls.DataGridLengthConverter$ * 6e   
 63   �� *
GameFolder+6e   5      �� 5   
   -   5        $��LaunchButton��5      $��Launch��6%   $��	0,0,10,10q�66   $��25��6I   $��Bottom=�6U   $��Right=�6p   $��75��6�   6�   �� 5   
   -   5        $��WarningLabel��5      $�� ��6$   $��	10,0,0,10q�6/   $
��Left=�6B   $��Bottom=�6_   5      5      