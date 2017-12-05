DEFINE VARIABLE chFileName AS CHARACTER   NO-UNDO.
DEFINE VARIABLE chExcel    AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE cCopied    AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE cMemptr    AS MEMPTR      NO-UNDO.
DEFINE VARIABLE cText      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iRow       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCol       AS INTEGER     NO-UNDO.
DEFINE VARIABLE vRow       AS CHARACTER   NO-UNDO.

DEFINE TEMP-TABLE tt-data NO-UNDO
    FIELD serial AS INTEGER
    FIELD price  AS DECIMAL
    FIELD d_date AS DATE
    FIELD NAME   AS CHARACTER.

CREATE "Excel.Application" chExcel.

chExcel:Workbooks:OPEN("C:\Users\sachin.kulkarni\Desktop\Progress4gl_Programs\EMP.xlsx").
chExcel:VISIBLE = FALSE.
chExcel:Worksheets("Sheet1"):ACTIVATE.
chExcel:Worksheets("Sheet1"):UsedRange:COPY.
cCopied = CLIPBOARD:VALUE.
COPY-LOB FROM cCopied TO cMemptr.
CLIPBOARD:VALUE = "".

cText = GET-STRING(cMemptr, 1, -1).

DO iRow = 1 TO NUM-ENTRIES(cText,CHR(10)) - 1:
    vRow = ENTRY(iRow,cText,CHR(10)).
    CREATE tt-data.
    ASSIGN tt-data.serial  = INTEGER(ENTRY(1,vRow,CHR(9)))
           tt-data.price       = DECIMAL(ENTRY(2,vRow,CHR(9)))
           tt-data.d_date      = DATE(ENTRY(3,vRow,CHR(9)))
           tt-data.NAME        = ENTRY(4,vRow,CHR(9)).
    IF vRow = "" THEN NEXT.
END.

FOR EACH tt-data:
    CREATE test.
    ASSIGN test.serial = tt-data.serial
           test.price  = tt-data.price 
           test.d_date = tt-data.d_date
           test.NAME   = tt-data.NAME.  
END.








