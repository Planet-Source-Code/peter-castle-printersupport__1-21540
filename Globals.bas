Attribute VB_Name = "Globals"
Option Explicit

'-------------------------------------------------------------------------
' Global Variables
'-------------------------------------------------------------------------
'
' Variables to define the non-printable zone for the current printer
Global gsngOffsetX       As Single
Global gsngOffsetY       As Single

' Variables used to format the way text is displayed
Global gsngLineSpacing   As Single
Global glngJustification As Long
Global gsngTabSpacing    As Single
 
'-------------------------------------------------------------------------
' External Procedures
'-------------------------------------------------------------------------
'
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, _
                                                   ByVal nIndex As Long) As Long

