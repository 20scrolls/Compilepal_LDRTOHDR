   M S B A M L   `   `   `  ����T  PMahApps.Metro, Version=1.4.3.0, Culture=neutral, PublicKeyToken=f4fb5a3c4d1e5b4ffCclr-namespace:MahApps.Metro.Controls.Dialogs;assembly=MahApps.MetroMahApps.Metro.Controls.Dialogs  5   	    CompilePalX9   3CompilePalX.Compilers.UtilityProcess.ConflictWindow   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   ;controls,http://metro.mahapps.com/winfx/xaml/controls   5   	   QdialogsCclr-namespace:MahApps.Metro.Controls.Dialogs;assembly=MahApps.Metro   5   	   -   5          � Title$   Particle Manifest Conflict��5   	   (   "MahApps.Metro.Controls.MetroWindow   IconEdgeMode$ Aliased=�5         ShowIconOnTitleBar .  $	��450��5	      $	��800��6$   $	��450��5
      $	��800��6'      AccentColorBrush#���   5      $��1q�6H   .��5      �  � RowDefinitions 5   
   �� 5      $��50 �6   �� 5      $��40 �6   �� 5      $	��225 �6   �� 5      $��50 �6   �� 5      $��* �6   .+�5   
   ��  �� Padding$ 10, 10, 10, 10q�6   $��25(�6-   Conflicting Particle Names6W   �� 5   
   $��1��6   $��10, 0, 10, 0q�6#   $��0q�6:    �� 
IsReadOnly . . �5      /� .T�5      J�  �� Margin$ 0q�6   
�������.*�69   xvCompile Pal was unable to determine which file was being used due to multiple files containing the same particle names6�   J� 5      $ 0q�6   
�������.*�69   ;9Please select one or multiple PCFs to add to the manifest6t   5      5      �� 5   
   -   5         ��Name$ fileBox��5      $��2��6    �� SelectionMode$ Extended=�60   $��60��6I   $	��200��6X   $��10, 10, 10, 10q�6e   #���   6}   $��1q�6�   6�   � 5   
   $��3��6   .+�5       �� -   5        $��10, 10, 10, 10q�5    ,   $	��100��6D   $��Right=�6P   .��6l   Select6t   �� 5"      -   5        $��10, 10, 115, 10q�5"   *   $	��100��6C   $��Right=�6O   .��6k   Select None6x   d� 5$      -   5        	 d�Name$	 advancedButton��5$   ~   
�������$��0q�6/   $��30��6C   $	��250��6O   
 d� 	IsChecked$
 FalseY�6l   .��6�   Show Advanced Information��5&      �� 5'       �� 
TargetType" d�6   .�5(      ��  �� Property � �� �� Value
 �����6F   �� 5)       � �� 5*      �� 5+   "    �� 
TargetType" d�62   .R�5,   &   �� #��z��6-   ._�5-   *   �� $��Center=�6;   $��Center=�6X   5.   '   5/   #   51       �� Triggers 53      P� 54       P� Property �@J�IsMouseOver P� Value . . �55   "   ��  � ��
 �<��6Q   56      58      5:      5;      �� 5=   
   -   5         ��Name$ advancedInfo��5=   ;   $��4��6   $y�	Collapsed=�6$   
������� � 	Resources 5>      ��%}   '��       �� 5?      " ��6   .�5@      ��  � ��$ 25��6.   6;   �� 5A       � ��
 �����6C   5B      5C      .��5E      �� -   5         ��Name$ 
AdvancedSP��5E   4    �� CanVerticallyScroll . 5G      5H      5I      5J      