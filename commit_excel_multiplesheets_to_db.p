DEFINE VARIABLE chFileName  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE chExcel     AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE cCopied     AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE cMemptr     AS MEMPTR      NO-UNDO.
DEFINE VARIABLE cText       AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iRow        AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCol        AS INTEGER     NO-UNDO.
DEFINE VARIABLE vRow        AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSheetcount AS INTEGER     NO-UNDO.
DEFINE VARIABLE iNo         AS INTEGER     NO-UNDO.
DEFINE VARIABLE cSheetname  AS CHARACTER   NO-UNDO.

DEFINE TEMP-TABLE tt-data NO-UNDO
    FIELD serial AS INTEGER
    FIELD price  AS DECIMAL
    FIELD d_date AS DATE
    FIELD NAME   AS CHARACTER.

CREATE "Excel.Application" chExcel.

chExcel:Workbooks:OPEN("C:\Users\sachin.kulkarni\Desktop\Progress4gl_Programs\CopyEMP3.xlsx").
chExcel:VISIBLE = FALSE.

FOR EACH test:
    DELETE test.
END.

/* To read the total sheets in excel file */
iSheetcount = chExcel:Worksheets:Count.

DO iNo = 1 TO iSheetcount:
    cSheetname = chExcel:Worksheets(iNo):Name.
    chExcel:Worksheets(cSheetname):ACTIVATE.
    chExcel:Worksheets(cSheetname):UsedRange:COPY.
    cCopied = CLIPBOARD:VALUE.
    COPY-LOB FROM cCopied TO cMemptr.
    CLIPBOARD:VALUE = "".
    cText = GET-STRING(cMemptr, 1, -1).

    DO iRow = 1 TO NUM-ENTRIES(cText,CHR(10)) - 1:
       vRow = ENTRY(iRow,cText,CHR(10)).
       CREATE tt-data.
       ASSIGN tt-data.serial      = INTEGER(ENTRY(1,vRow,CHR(9)))
              tt-data.price       = DECIMAL(ENTRY(2,vRow,CHR(9)))
              tt-data.d_date      = DATE(ENTRY(3,vRow,CHR(9)))
              tt-data.NAME        = ENTRY(4,vRow,CHR(9)).
       IF vRow = "" THEN NEXT.
    END.
END.



FOR EACH tt-data:
    CREATE test.
    ASSIGN test.serial = tt-data.serial
           test.price  = tt-data.price
           test.d_date = tt-data.d_date
           test.NAME   = tt-data.NAME.
END.

chExcel:DisplayAlerts = FALSE.
chExcel:QUIT(). 
RELEASE OBJECT chExcel.








