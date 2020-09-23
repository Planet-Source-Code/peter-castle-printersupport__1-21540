<div align="center">

## PrinterSupport


</div>

### Description

The PrinterSupport.dll was created in order to simplify printing documents. Included features are;

1. Paragraphs

2. Rectangles

3. Circles

4. Pictures (picture object reference)

5. format text (i.e. bold, size, etc)

6. Justification (full, left, right and centre)

The printing is done using millimeters so that replicating documents for programs is relatively straight forward. The non-printable area of the printer is also taken care of.

Note:

The printer orientation is not modified at all but can easily be added if need be.

There is also no current method of selecting a printer which can also be added to the dll if required.
 
### More Info
 
To use PrinterSupport.dll, you need to do the following;

1. Create a reference to the dll in a project

2. Declare a variable as follows

Dim objPrinter As New PrinterSupport.MyPrinter

3. When printing it is important to treat the document you are doing like a recipe. In otherwords take it step by step. eg;

objPrinter.FontSize = 8

objPrinter.FontBold = True

objPrinter.PrintCentre 105, 280, strCopyHeader

objPrinter.FontBold = False

objPrinter.FontSize = 10

the above sets the font size to 8, then sets the bold property to true. This will stay that way until set to something different as is done after a variable is printed at X=105, Y = 280 using centre justification for a line of text.

Note:

To set justification for a paragraph you need to set the justification method BEFORE printing the paragraph.


<span>             |<span>
---                |---
**Submitted On**   |2000-12-13 10:35:28
**By**             |[Peter Castle](https://github.com/Planet-Source-Code/PSCIndex/blob/master/ByAuthor/peter-castle.md)
**Level**          |Intermediate
**User Rating**    |5.0 (10 globes from 2 users)
**Compatibility**  |VB 6\.0
**Category**       |[Files/ File Controls/ Input/ Output](https://github.com/Planet-Source-Code/PSCIndex/blob/master/ByCategory/files-file-controls-input-output__1-3.md)
**World**          |[Visual Basic](https://github.com/Planet-Source-Code/PSCIndex/blob/master/ByWorld/visual-basic.md)
**Archive File**   |[CODE\_UPLOAD16048352001\.zip](https://github.com/Planet-Source-Code/peter-castle-printersupport__1-21540/archive/master.zip)








