VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "MyPrinter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' Enumerations
'-------------------------------------------------------------------------
'
' Justification Types
Enum JustifyEnum
    JLeft = 0
    JRight = 1
    JCentre = 2
    JFull = 3
End Enum

' Paper Sizes
Enum PaperSizeEnum
    Letter = vbPRPSLetter                       ' Letter 8.5 x 11 in.
    SmallLetter = vbPRPSLetterSmall             ' Letter Small, 8.5 x 11 in.
    Tabloid = vbPRPSTabloid                     ' Tabloid, 11 x 17 in.
    Ledger = vbPRPSLedger                       ' Ledger, 17 x 11 in.
    Legal = vbPRPSLegal                         ' Legal, 8.5 x 14 in.
    Statement = vbPRPSStatement                 ' Statement, 5.5 x 8.5 in.
    Executive = vbPRPSExecutive                 ' Executive, 7.5 x 10.5 in.
    A3 = vbPRPSA3                               ' A3, 297 x 420 mm
    A4 = vbPRPSA4                               ' A4, 210 x 297 mm
    A4_Small = vbPRPSA4Small                    ' A4 Small, 210 x 297 mm
    A5 = vbPRPSA5                               ' A5, 148 x 210 mm
    B4 = vbPRPSB4                               ' B4, 250 x 354 mm
    B5 = vbPRPSB5                               ' B5, 182 x 257 mm
    Folio = vbPRPSFolio                         ' Folio, 8.5 x 13 in.
    Quarto = vbPRPSQuarto                       ' Quarto, 215 x 275 mm
    Note = vbPRPSNote                           ' Note, 8.5 x 11 in.
    'PRPSEnv9 = vbPRPSEnv9                       ' Envelope #9, 3.875 x 8.875 in.
    'PRPSEnv10 = vbPRPSEnv10                     ' Envelope #10, 4.125 x 9.5 in.
    'PRPSEnv11 = vbPRPSEnv11                     ' Envelope #11, 4.5 x 10.375 in.
    'PRPSEnv12 = vbPRPSEnv12                     ' Envelope #12, 4.5 x 11 in.
    'PRPSEnv14 = vbPRPSEnv14                     ' Envelope #14, 5 x 11.5 in.
    C_Sheet = vbPRPSCSheet                      ' C size sheet
    D_Sheet = vbPRPSDSheet                      ' D size sheet
    E_Sheet = vbPRPSESheet                      ' E size sheet
    'PRPSEnvDL = vbPRPSEnvDL                     ' Envelope DL, 110 x 220 mm
    'PRPSEnvC3 = vbPRPSEnvC3                     ' Envelope C3, 324 x 458 mm
    'PRPSEnvC4 = vbPRPSEnvC4                     ' Envelope C4, 229 x 324 mm
    'PRPSEnvC5 = vbPRPSEnvC5                     ' Envelope C5, 162 x 229 mm
    'PRPSEnvC6 = vbPRPSEnvC6                     ' Envelope C6, 114 x 162 mm
    'PRPSEnvC65 = vbPRPSEnvC65                   ' Envelope C65, 114 x 229 mm
    'PRPSEnvB4 = vbPRPSEnvB4                     ' Envelope B4, 250 x 353 mm
    'PRPSEnvB5 = vbPRPSEnvB5                     ' Envelope B5, 176 x 250 mm
    'PRPSEnvB6 = vbPRPSEnvB6                     ' Envelope B6, 176 x 125 mm
    'PRPSEnvItaly = vbPRPSEnvItaly               ' Envelope, 110 x 230 mm
    'PRPSEnvMonarch = vbPRPSEnvMonarch           ' Envelope Monarch, 3.875 x 7.5 in.
    'PRPSEnvPersonal = vbPRPSEnvPersonal         ' Envelope, 3.625 x 6.5 in.
    Fanfold_US = vbPRPSFanfoldUS                ' U.S. Standard Fanfold, 14.875 x 11 in.
    Fanfold_Std_German = vbPRPSFanfoldStdGerman ' German Standard Fanfold, 8.5 x 12 in.
    Fanfold_Lgl_German = vbPRPSFanfoldLglGerman ' German Legal Fanfold, 8.5 x 13 in.
    User = vbPRPSUser                           ' custom type
End Enum

' Paper Bin Options
Enum PaperBinEnum
    Upper = vbPRBNUpper                  ' Use the upper bin.
    Lower = vbPRBNLower                  ' Use the lower bin.
    Middle = vbPRBNMiddle                ' Use the middle bin.
    Manual = vbPRBNManual                ' Wait for manual insertion of each sheet.
    Envelope = vbPRBNEnvelope            ' Use envelopes from the envelope feeder.
    Envelope_Manual = vbPRBNEnvManual    ' Use envelopes from the envelope feeder,
                                         ' but wait for manual insertion.
    Auto = vbPRBNAuto                    ' (Default) Use current default bin.
    Tractor = vbPRBNTractor              ' Use paper fed from the tractor feeder.
    Small_Paper = vbPRBNSmallFmt         ' Use the small paper feeder.
    Large_Paper = vbPRBNLargeFmt         ' Use the large paper bin.
    Large_Capacity = vbPRBNLargeCapacity ' Use the large capacity feeder.
    Cassette = vbPRBNCassette            ' Use the attached cassette cartridge.
End Enum

Enum DrawStyleEnum
    Solid = vbSolid
    Dash = vbDash
    Dot = vbDot
    DashDot = vbDashDot
    DashDotDot = vbDashDotDot
    Invisible = vbInvisible
    InsideSolid = vbInsideSolid
End Enum

'-------------------------------------------------------------------------
' Constants
'-------------------------------------------------------------------------
'
' constants used for printing
Const mcGetPrintingOffset = 13
Const mcDefaultScaleMode = vbMillimeters ' force scale mode to mm for this class
Const mcDefaultLineSpacing = 1           ' mm
Const mcDefaultJustification = JLeft     ' left
Const mcDefaultTabSpacing = 5            ' space characters
Const mcPI = 3.14159265                  ' used to draw curved edges
Const mcThresholdFullJustify = 0.7       ' used to determine how full a line of text
                                         ' must be in order to receive full
                                         ' justification

' Set font name
Public Property Let FontName(strFontName As String)
    Printer.FontName = strFontName
End Property

' Get the current font name
Public Property Get FontName() As String
    FontName = Printer.FontName
End Property

' Set the font size property
Public Property Let FontSize(lngFontSize As Long)
    Printer.FontSize = lngFontSize
End Property

'Get the current font size
Public Property Get FontSize() As Long
    FontSize = Printer.FontSize
End Property

'This procedure sets the font bold property
Public Property Let FontBold(blnFontBold As Boolean)
    Printer.FontBold = blnFontBold
End Property

'Get the font bold status
Public Property Get FontBold() As Boolean
    FontBold = Printer.FontBold
End Property

'This procedure sets the font italic property
Public Property Let FontItalic(blnFontItalic As Boolean)
    Printer.FontItalic = blnFontItalic
End Property

'Get the font italic status
Public Property Get FontItalic() As Boolean
    FontItalic = Printer.FontItalic
End Property

'This procedure sets the font strikethrough property
Public Property Let FontStrikeThru(blnFontStrikethru As Boolean)
    Printer.FontStrikeThru = blnFontStrikethru
End Property

'Get the font strike through status
Public Property Get FontStrikeThru() As Boolean
    FontStrikeThru = Printer.FontStrikeThru
End Property

'This procedure sets the font underline property
Public Property Let FontUnderline(blnFontUnderline As Boolean)
    Printer.FontUnderline = blnFontUnderline
End Property

'Get the font underline status
Public Property Get FontUnderline() As Boolean
    FontUnderline = Printer.FontUnderline
End Property

'get the number of fonts available on the printer
Public Property Get FontCount() As Long
    FontCount = Printer.FontCount
End Property

'get the font name required
Public Property Get Fonts(intFont As Integer) As String
    Fonts = Printer.Fonts(intFont)
End Property

'set the amound of copies to be printed
Public Property Let Copies(lngCopies As Long)
    Printer.Copies = lngCopies
End Property

'get the number of copies to be printed
Public Property Get Copies() As Long
    Copies = Printer.Copies
End Property

'set the paper size type
Public Property Let PaperSize(lngPapersize As PaperSizeEnum)
    Printer.PaperSize = lngPapersize
End Property

'get the current paper size setting
Property Get PaperSize() As PaperSizeEnum
    PaperSize = Printer.PaperSize
End Property

'set the paper bin type
Public Property Let PaperBin(lngPaperBin As PaperBinEnum)
    Printer.PaperBin = lngPaperBin
End Property

'get the current paper bin setting
Property Get PaperBin() As PaperBinEnum
    PaperBin = Printer.PaperBin
End Property

'This procedure sets the line spacing between subsequent lines
Property Let LineSpacing(sngLineSpacing As Single)
    
    'make sure line spacing is valid
    If sngLineSpacing >= 0 Then
        gsngLineSpacing = sngLineSpacing
    Else
        gsngLineSpacing = mcDefaultLineSpacing
    End If
End Property

'This procedure returns the current line spacing
Property Get LineSpacing() As Single
    LineSpacing = gsngLineSpacing
End Property

'This procedure sets the tab spacing between characters
Public Property Let TabSpacing(sngTabSpacing As Single)
    
    'make sure line spacing is valid
    If sngTabSpacing >= 0 Then
        gsngTabSpacing = sngTabSpacing
    Else
        gsngTabSpacing = mcDefaultTabSpacing
    End If
End Property

' Set the justification
Public Property Let Justification(lngJustification As JustifyEnum)
    glngJustification = lngJustification
End Property

' Get the justification
Public Property Get Justification() As JustifyEnum
    Justification = glngJustification
End Property

' Set the draw width for text and diagrams
Public Property Let DrawWidth(lngDrawWidth As Long)
    Printer.DrawWidth = lngDrawWidth
End Property

Public Property Get DrawWidth() As Long
    DrawWidth = Printer.DrawWidth
End Property

Public Property Let DrawStyle(Style As DrawStyleEnum)
    Printer.DrawStyle = Style
End Property

Public Property Get DrawStyle() As Long
    DrawStyle = Printer.DrawStyle
End Property

Property Let CurrentX(sngCurrentX As Single)
    Printer.CurrentX = sngCurrentX + gsngOffsetX
End Property

'get the current x position in mm from the edge of paper
Property Get CurrentX() As Single
    CurrentX = Printer.CurrentX - gsngOffsetX
End Property

Property Let CurrentY(sngCurrentY As Single)
    Printer.CurrentY = sngCurrentY + gsngOffsetY
End Property

'get the currenty position in mm from the edge of paper
Property Get CurrentY() As Single
    CurrentY = Printer.CurrentY - gsngOffsetY
End Property

'get the scale width for the page, assumes left & right non printable areas are the same
Property Get PageWidth() As Single
    PageWidth = Printer.ScaleWidth - (gsngOffsetX * 2)
End Property

'get the scale height for the page, assumes left and right non-printable areas are the same
Property Get PageHeight() As Single
    PageHeight = Printer.ScaleHeight - (gsngOffsetY * 2)
End Property

'get the number of pages that have been created
Property Get Page() As Long
    Page = Printer.Page
End Property

'This procedure gets the x and y printing offsets for
'the current Preview. It assumes that gsngOffsetX and gsngOffsetY
'are globally defined.
Private Sub GetPrinterOffsets()
 
Const PHYSICALOFFSETX = 112  '  Physical Printable Area x margin
Const PHYSICALOFFSETY = 113  '  Physical Printable Area y margin
Const LOGPIXELSX = 88        '  Logical pixels/inch in X
Const LOGPIXELSY = 90        '  Logical pixels/inch in Y
 
gsngOffsetX = -25.4 * GetDeviceCaps(Printer.hdc, PHYSICALOFFSETX) / _
                      GetDeviceCaps(Printer.hdc, LOGPIXELSX)
gsngOffsetY = -25.4 * GetDeviceCaps(Printer.hdc, PHYSICALOFFSETY) / _
                      GetDeviceCaps(Printer.hdc, LOGPIXELSY)

End Sub

Property Get XOffset() As Single
    XOffset = gsngOffsetX
End Property

Property Get YOffset() As Single
    YOffset = gsngOffsetY
End Property

'This procedure is used to print text at a specific location from the left-hand side
Public Sub PrintLeft(sngXPos As Single, _
                     sngYPos As Single, _
                     txtString As String, _
                     Optional sngFirstLineIndent As Single = 0)
                     
    Dim lngCarrNo As Long
    Dim lngStart As Long
    Dim strTemp As String
    Dim sngTempXPos As Single
    
    'modify text incase of carriage returns
    lngCarrNo = CRCount(txtString)
    
    'initialise indent for text with carriage return line feeds in it as well
    sngTempXPos = sngXPos + sngFirstLineIndent
    
    'check if text has no carriage returns
    If lngCarrNo = 0 Then
        If sngXPos >= 0 Then Printer.CurrentX = gsngOffsetX + sngTempXPos
        If sngYPos >= 0 Then Printer.CurrentY = gsngOffsetY + sngYPos
        
        Printer.Print txtString
    Else
        'loop through and edit each line of text in string
        For lngStart = 0 To lngCarrNo
            
            'if not first line then reset to original x position
            If lngStart > 0 Then sngTempXPos = sngXPos
            
            'get line from string
            strTemp = GetLineFromString(txtString, lngStart)
        
            If sngXPos >= 0 Then Printer.CurrentX = gsngOffsetX + sngTempXPos
            If sngYPos >= 0 Then Printer.CurrentY = (gsngOffsetY + sngYPos) + (lngStart * Printer.TextHeight(strTemp) + lngStart * gsngLineSpacing)
            
            Printer.Print strTemp
        Next lngStart
    End If
End Sub

'This procedure is used to print text at a specific location from the right-hand side
Public Sub PrintRight(sngXPos As Single, _
                      sngYPos As Single, _
                      txtString As String, _
                      Optional sngFirstLineIndent As Single = 0)
                     
    Dim lngCarrNo As Long
    Dim lngStart As Long
    Dim strTemp As String
    Dim sngTempXPos As Single
    
    'modify text incase of carriage returns
    lngCarrNo = CRCount(txtString)
    
    'initialise indent for text with carriage return line feeds in it as well
    sngTempXPos = sngXPos + sngFirstLineIndent
    
    'check if text has no carriage returns
    If lngCarrNo = 0 Then
    
        'adjust alignment of x cordinate
        If sngXPos >= 0 Then Printer.CurrentX = (gsngOffsetX + sngTempXPos) - Printer.TextWidth(txtString)
        If sngYPos >= 0 Then Printer.CurrentY = gsngOffsetY + sngYPos
        
        Printer.Print txtString
    Else
        
        'loop through and edit each line of text in string
        For lngStart = 0 To lngCarrNo
        
            'if not first line then reset to original x position
            If lngStart > 0 Then sngTempXPos = sngXPos
            
            'get line from string
            strTemp = GetLineFromString(txtString, lngStart)
        
            If sngXPos >= 0 Then Printer.CurrentX = (gsngOffsetX + sngTempXPos) - Printer.TextWidth(strTemp)
            If sngYPos >= 0 Then Printer.CurrentY = (gsngOffsetY + sngYPos) + (lngStart * Printer.TextHeight(strTemp) + lngStart * gsngLineSpacing)
            
            Printer.Print strTemp
            
        Next lngStart
    End If
End Sub

'This procedure is used to print text centred at a specific location
Public Sub PrintCentre(sngXPos As Single, _
                       sngYPos As Single, _
                       txtString As String, _
                       Optional sngFirstLineIndent As Single = 0)
    
    Dim lngCarrNo As Long
    Dim lngStart As Long
    Dim strTemp As String
    Dim sngTempXPos As Single
    
    'modify text incase of carriage returns
    lngCarrNo = CRCount(txtString)
    
    'initialise indent for text with carriage return line feeds in it as well
    sngTempXPos = sngXPos + sngFirstLineIndent
    
    'check if text has no carriage returns
    If lngCarrNo = 0 Then
    
        'adjust alignment of x cordinate
        If sngXPos >= 0 Then Printer.CurrentX = (gsngOffsetX + sngTempXPos) - (Printer.TextWidth(txtString) / 2)
        If sngYPos >= 0 Then Printer.CurrentY = gsngOffsetY + sngYPos
        
        Printer.Print txtString
    Else
        
        'loop through and edit each line of text in string
        For lngStart = 0 To lngCarrNo
            
            'if not first line then reset to original x position
            If lngStart > 0 Then sngTempXPos = sngXPos
            
            'get line from string
            strTemp = GetLineFromString(txtString, lngStart)
        
            If sngXPos >= 0 Then Printer.CurrentX = (gsngOffsetX + sngTempXPos) - (Printer.TextWidth(strTemp) / 2)
            If sngYPos >= 0 Then Printer.CurrentY = (gsngOffsetY + sngYPos) + (lngStart * Printer.TextHeight(strTemp) + lngStart * gsngLineSpacing)
            
            Printer.Print strTemp
        Next lngStart
    End If
End Sub

'This procedure is used to fully justify a paragraph of text only
Public Sub PrintFull(sngXPos As Single, _
                     sngYPos As Single, _
                     txtString As String, _
                     Optional sngLineLength As Single = 0, _
                     Optional sngFirstLineIndent As Single = 0)
    
    Dim lngCarrNo As Long
    Dim sngMaxLineLength As Single
    Dim lngNumWords As Long
    Dim sngDifference As Single
    Dim sngSpacePerWord As Single
    Dim lngStart As Long
    Dim strTemp As String
    Dim strWord As String
    Dim sngSpaceAccumilated As Single
    Dim lngWordCounter As Long
    Dim sngCurrentX As Single
    Dim sngCurrentY As Single
    Dim sngTempXPos As Single
    
    'modify text in case of carriage returns
    lngCarrNo = CRCount(txtString)
    
    sngTempXPos = sngXPos + sngFirstLineIndent
    
    'check if text has no carriage returns
    If lngCarrNo = 0 Then

        'adjust alignment of x cordinate
        If sngXPos >= 0 Then Printer.CurrentX = (gsngOffsetX + sngTempXPos)
        If sngYPos >= 0 Then Printer.CurrentY = gsngOffsetY + sngYPos
        
        Printer.Print txtString
    Else

        'loop through and edit each line of text in string
        For lngStart = 0 To lngCarrNo
            
            'find the maximum line length
            If sngLineLength = 0 Then
                sngMaxLineLength = Printer.TextWidth(txtString)
            Else
                If lngStart = 0 Then
                    sngMaxLineLength = sngLineLength - sngFirstLineIndent
                Else
                    sngMaxLineLength = sngLineLength
                End If
            End If
            
            strTemp = ""
            
            'check if need to reset to original starting point
            If lngStart > 0 Then sngTempXPos = sngXPos
            
            'get line from string
            strTemp = GetLineFromString(txtString, lngStart)
            
            'reset counter for next line
            sngSpaceAccumilated = 0
            
            'determine if line of text meets threshold and is not last line of paragraph
            If (Printer.TextWidth(strTemp) / sngMaxLineLength) > mcThresholdFullJustify And _
                (lngStart <> lngCarrNo) Then
                
                'get number of words in line
                lngNumWords = GetNumWords(strTemp)
                
                'calculate difference and adjust space between each word
                sngDifference = sngMaxLineLength - Printer.TextWidth(strTemp)
                
                sngSpacePerWord = (sngDifference / lngNumWords) + Printer.TextWidth(" ")
                
                'use the same y-coordinate
                sngCurrentY = (gsngOffsetY + sngYPos) + (lngStart * Printer.TextHeight(strTemp) + lngStart * gsngLineSpacing)

                'set the x=cordinate for the first character in the line
                sngCurrentX = gsngOffsetX + sngTempXPos
                
                'print line out word by word
                Do Until Len(strTemp) = 0
                
                    If Left$(strTemp, 1) = " " Then
                        'increase the space accumilated
                        sngSpaceAccumilated = sngSpaceAccumilated + sngSpacePerWord
                        strTemp = Mid$(strTemp, 2)
                    Else
                        'get next word from line
                        strWord = GetFirstWordFromString(strTemp)
                        
                        'adjust character position for characters
                        Printer.CurrentX = sngCurrentX + sngSpaceAccumilated
                        Printer.CurrentY = sngCurrentY

                        Printer.Print strWord
                        
                        'increase the space accumilated
                        sngSpaceAccumilated = sngSpaceAccumilated + Printer.TextWidth(strWord)
                        
                        'remove word that was processed
                        strTemp = Mid$(strTemp, Len(strWord) + 1)
                    End If
                    
                Loop
                
            Else
                'calculate co-ordinates
                If sngXPos >= 0 Then Printer.CurrentX = (gsngOffsetX + sngTempXPos)
                If sngYPos >= 0 Then Printer.CurrentY = (gsngOffsetY + sngYPos) + (lngStart * Printer.TextHeight(strTemp) + lngStart * gsngLineSpacing)
            
                'print line
                Printer.Print strTemp
            End If
        Next lngStart
    End If
End Sub

'This procedure returns the number of words in a string
Private Function GetNumWords(strText As String) As Long
    Dim strTemp As String
    Dim lngCounter As Long
    
    strTemp = strText
    lngCounter = 0
    GetNumWords = 0
    
    'loop until all characters looked at
    Do Until lngCounter = Len(strTemp)
        
        'increment counter
        lngCounter = lngCounter + 1
        
        'check if character is a space
        If Mid(strTemp, lngCounter, 1) = " " Then
            GetNumWords = GetNumWords + 1
        End If
  
    Loop

End Function

'This procedure enables large amounts of text to be passed and formatted into paragraphs
Public Sub Paragraph(sngXPos As Single, _
                     sngYPos As Single, _
                     sngLineLength As Single, _
                     strText As String, _
                     Optional sngFirstLineIndent As Single = 0)
    
    Dim strTemp As String
    Dim strTempWord As String
    Dim strTempLine As String
    Dim strParagraph As String
    Dim lngCharCounter As Long
    Dim lngParaLength As Long
    Dim lngLineCounter As Long
    Dim sngTempLineLength As Long
    
    strTemp = strText

    'remove all existing carriage returns and line feeds from string
    strTemp = RemoveCR(strTemp)
    lngLineCounter = 0
    
    'loop through each character
    Do Until Len(strTemp) = 0
        
        'adjust variables
        lngParaLength = Len(strTemp)
        strTempLine = ""
        lngCharCounter = 0
        lngLineCounter = lngLineCounter + 1
        
        'adjust line length to cater for indentation
        If lngLineCounter = 1 Then
            sngTempLineLength = sngLineLength - sngFirstLineIndent
        Else
            sngTempLineLength = sngLineLength
        End If
        
        'loop to create a line
        Do Until (Printer.TextWidth(strTempLine) > sngTempLineLength) Or _
                 (lngCharCounter = lngParaLength)
            
            strTempWord = ""
            
            'get next word
            Do Until (Right(strTempWord, 1) = " ") Or _
                     (Right(strTempWord, 1) = "-") Or _
                     (Right(strTempWord, 1) = "/") Or _
                     (lngCharCounter = lngParaLength)
                
                lngCharCounter = lngCharCounter + 1
                strTempWord = strTempWord & Mid(strTemp, lngCharCounter, 1)
            Loop
            
            'add word to templine
            strTempLine = strTempLine & strTempWord
        Loop
        
        'adjust temp line to force wrap around of last word on line
        If Printer.TextWidth(strTempLine) > sngTempLineLength Then
            strTempLine = Left(strTempLine, Len(strTempLine) - Len(strTempWord))
        End If
        
        'add line to paragraph
        If strParagraph = "" Then
            strParagraph = Trim(strTempLine)
        Else
            strParagraph = strParagraph & vbCrLf & Trim(strTempLine)
        End If
        
        'adjust temp source and remove line that was processed
        strTemp = Right(strTemp, Len(strTemp) - Len(strTempLine))
    Loop

    'print paragraph according to justification setting
    Select Case glngJustification
        Case JLeft: PrintLeft sngXPos, sngYPos, strParagraph, sngFirstLineIndent
        Case JRight: PrintRight sngXPos, sngYPos, strParagraph, sngFirstLineIndent
        Case JCentre: PrintCentre sngXPos, sngYPos, strParagraph, sngFirstLineIndent
        Case JFull: PrintFull sngXPos, sngYPos, strParagraph, sngLineLength, sngFirstLineIndent
        Case Else: PrintLeft sngXPos, sngYPos, strParagraph, sngFirstLineIndent
    End Select
    
End Sub

' This method draws a rectangle with an optional curved corners
Public Sub DrawRectangle(sngStartX As Single, _
                         sngStartY As Single, _
                         sngWidth As Single, _
                         sngHeight As Single, _
                         Optional sngRadius As Single = 0)

    If sngRadius > 0 Then
        ' rounded corners
        Printer.CurrentX = sngStartX + gsngOffsetX + sngRadius
        Printer.CurrentY = sngStartY + gsngOffsetY
        ' draw top side
        Printer.Line Step(0, 0)-Step(sngWidth - 2 * sngRadius, 0)
        ' draw top right corner
        Printer.Circle Step(0, sngRadius), sngRadius, , 0, mcPI / 2
        ' draw right side
        Printer.Line Step(sngRadius, 0)-Step(0, sngHeight - 2 * sngRadius)
        ' draw bottom right corner
        Printer.Circle Step(-sngRadius, 0), sngRadius, , 3 * mcPI / 2, 0
        ' draw bottom side
        Printer.Line Step(0, sngRadius)-Step(-(sngWidth - 2 * sngRadius), 0)
        ' draw bottom left corner
        Printer.Circle Step(0, -sngRadius), sngRadius, , mcPI, 3 * mcPI / 2
        ' draw left side
        Printer.Line Step(-sngRadius, 0)-Step(0, -(sngHeight - 2 * sngRadius))
        ' draw top left corner
        Printer.Circle Step(sngRadius, 0), sngRadius, , mcPI / 2, mcPI
    Else
        ' square corners
        Printer.Line (sngStartX + gsngOffsetX, sngStartY + gsngOffsetY)-Step(sngWidth, sngHeight), , B
    End If
    Printer.CurrentX = sngStartX + gsngOffsetX + sngWidth
    Printer.CurrentY = sngStartY + gsngOffsetY + sngHeight

End Sub

' This method draws a picture from a specified picture file
Public Sub PaintPicture(sngStartX As Single, _
                        sngStartY As Single, _
                        objPicture As Object, _
                        Optional sngHeight As Single = 0, _
                        Optional sngWidth As Single = 0)
    
    If sngHeight > 0 And sngWidth > 0 Then
        
        'picture is stored in form picture property
        Printer.PaintPicture objPicture.Picture, _
                             sngStartX + gsngOffsetX, _
                             sngStartY + gsngOffsetY, sngWidth, sngHeight
    ElseIf sngHeight = 0 And sngWidth > 0 Then
    
        'picture is stored in form picture property
        Printer.PaintPicture objPicture.Picture, _
                             sngStartX + gsngOffsetX, _
                             sngStartY + gsngOffsetY, sngWidth
    ElseIf sngHeight > 0 And sngWidth = 0 Then
        
        'picture is stored in form picture property
        Printer.PaintPicture objPicture.Picture, _
                             sngStartX + gsngOffsetX, _
                             sngStartY + gsngOffsetY, , sngHeight
    Else
        
        'picture is stored in form picture property
        Printer.PaintPicture objPicture.Picture, _
                             sngStartX + gsngOffsetX, _
                             sngStartY + gsngOffsetY
    End If

End Sub

' End document
Public Sub EndDoc()
    Printer.EndDoc
End Sub

' Create a new page
Public Sub NewPage()
    Printer.NewPage
    
    'adjust to correct starting position
    Printer.CurrentX = gsngOffsetX
    Printer.CurrentY = gsngOffsetY

End Sub

'kill a document
Public Sub KillDoc()
    Printer.KillDoc
End Sub

'this procedure returns the text width in mm
Public Function TextWidth(strText As String) As Single
    TextWidth = Printer.TextWidth(strText)
End Function

'this procedure returns the text height in mm
Public Function TextHeight(strText As String) As Single
    TextHeight = Printer.TextHeight(strText)
End Function

Private Sub Class_Initialize()

    ' find out the non printable area
    GetPrinterOffsets

    ' set scale mode to millimeters
    Printer.ScaleMode = vbMillimeters
    
    ' set starting point to top left corner of paper
    Printer.CurrentX = gsngOffsetX
    Printer.CurrentY = gsngOffsetY

End Sub

'This procedure counts the number of carriage returns in a string
Private Function CRCount(strText As String) As Long
    
    Dim lngCounter As Long, _
        lngPointer As Long
    
    ' Initialise variables
    lngCounter = 0
    lngPointer = InStr(strText, vbCr)
    ' Count CRs
    Do Until lngPointer = 0
        lngCounter = lngCounter + 1
        lngPointer = InStr(lngPointer + 1, strText, vbCr)
    Loop
    ' Return the result
    CRCount = lngCounter

End Function

'This procedure removes all carriage return line feeds from a string
Private Function RemoveCR(strText As String) As String
    Dim strTemp As String
    Dim lngCharIndex As Long
    Dim strChar As String
    Dim blnCrLf As Boolean
    
    strTemp = strText
    lngCharIndex = 1
    RemoveCR = ""
    
    Do Until lngCharIndex > Len(strTemp)
        strChar = Mid(strTemp, lngCharIndex, 1)
    
        If (strChar <> vbCr) And (strChar <> vbLf) Then
            RemoveCR = RemoveCR & strChar
            blnCrLf = False
        Else
            'see if previous character was a Cr or Lf
            If Not (blnCrLf) Then RemoveCR = RemoveCR & " "
            blnCrLf = True
        End If
    
        'increment index by 1
        lngCharIndex = lngCharIndex + 1
    Loop

End Function

'This procedure extracts a line of text from a string with carriage returns in it
Private Function GetLineFromString(strText As String, lngLineNumber As Long) As String

    Dim lngStart As Long
    Dim strTemp As String
    Dim strLine As String
    
    strTemp = strText
    
    'loop through and find required line
    For lngStart = 0 To lngLineNumber
        strLine = ""
        
        'create line of text character by character
        Do Until (Left(strTemp, 1) = vbCr) Or (Len(strTemp) = 0)
            strLine = strLine & Left(strTemp, 1)
            strTemp = Right(strTemp, Len(strTemp) - 1)
        Loop
        
        'check if line has been obtained
        If lngStart = lngLineNumber Then
            
            'return string without leading and trailing spaces
            GetLineFromString = Trim(strLine)
        Else
            'make sure there are some characters before processing
            
            If Len(strTemp) <> 0 Then
                'remove carriage return
                If Left(strTemp, 1) = vbCr Then strTemp = Right(strTemp, Len(strTemp) - 1)
            End If
            
            If Len(strTemp) <> 0 Then
                'remove line feed
                If Left(strTemp, 1) = vbLf Then strTemp = Right(strTemp, Len(strTemp) - 1)
            End If
            
            'remove leading and trailing spaces
            strTemp = Trim(strTemp)
        End If
        
    Next lngStart
    
End Function

'This procedure returns first word in the string
Private Function GetFirstWordFromString(strText As String) As String
    Dim lngStart As Long
    Dim strTemp As String
    Dim strWord As String
    
    strTemp = strText
    
    strWord = ""
    
    'create a word character by character
    Do Until (Left(strTemp, 1) = " ") Or (Len(strTemp) = 0)
        strWord = strWord & Left(strTemp, 1)
        strTemp = Right(strTemp, Len(strTemp) - 1)
    Loop
        
    'return first word
    GetFirstWordFromString = Trim(strWord)
   
End Function


