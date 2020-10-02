       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUBPROGD.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
            COPY ZUTZCWS     .
       01  BOT-PARAMETERS.
           05 SERVER-MESSAGE PIC X(80).
           05 MESSAGE-TO-SERVER PIC X(80).
       PROCEDURE DIVISION.
           PERFORM UT-INITIALIZE

           DISPLAY SPACE
           DISPLAY "TEST SUITE:"
           DISPLAY
           'Test OHCE Kata'
           DISPLAY SPACE

           MOVE 'Reversing works (5 char)'
               TO UT-TEST-CASE-NAME
           PERFORM UT-BEFORE
           ADD 1 TO UT-TEST-CASE-COUNT
           SET UT-NORMAL-COMPARE TO TRUE
           MOVE 1 TO UT-ACTUAL
           MOVE "1"
                       TO UT-EXPECTED
           SET UT-COMPARE-DEFAULT TO TRUE
           PERFORM UT-ASSERT-EQUAL

           PERFORM UT-AFTER
            COPY ZUTZCPD     .
           .
       UT-BEFORE.

           .
       UT-AFTER.

           .
       UT-INITIALIZE.
           MOVE SPACE TO UT-FILE-INFORMATION

           .
       UT-END.

           MOVE 'Test' TO SERVER-MESSAGE
           MOVE 'Test2' TO MESSAGE-TO-SERVER
           CALL 'DUMMBOT' USING
               BY REFERENCE BOT-PARAMETERS
           END-CALL

           .
       9999-END.

           .
