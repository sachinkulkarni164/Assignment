def var a as integer no-undo.
def var b as character no-undo.

/* r-udf1.p */
/* Defines and references a user-defined function */

/* Define doubler() */
FUNCTION doubler RETURNS INTEGER (INPUT parm1 AS INTEGER):
  RETURN (2 * parm1). 
END FUNCTION.

/* Reference doubler() */
DISPLAY  "doubler(0)=" doubler(0) SKIP
  "doubler(1)=" doubler(1) skip
  "doubler(2)=" doubler(2) skip.