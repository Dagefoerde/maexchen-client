       IDENTIFICATION DIVISION.
       PROGRAM-ID. MUFFINBO.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 CURRENT-GAME.
          05 LAST-PLAYER PIC X(20).
          05 ANNOUNCED-DICE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
       01 CURRENT-TURN.
          05 COMMAND PIC X(32).
             88 ROUND-STARTING VALUE "ROUND STARTING".
             88 YOUR-TURN VALUE "YOUR TURN".
             88 ROLLED VALUE "ROLLED".
             88 ANNOUNCED VALUE "ANNOUNCED".
          05 TOKEN   PIC X(36).
          05 ROLLED-DICE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
       01  TEMPS.
         05 DICE-VALUE.
            07 DICE-1 PIC 9.
            07 FILLER PIC X.
            07 DICE-2 PIC 9.
         05 ONE-DIE PIC 9.
       LINKAGE SECTION.
       01 BOT-PARAMETERS.
        COPY DATA.

       PROCEDURE DIVISION USING BOT-PARAMETERS.
           PERFORM PARSE-SERVER-MESSAGE
           INITIALIZE MESSAGE-TO-SERVER
           EVALUATE TRUE
           WHEN ROUND-STARTING
              PERFORM HANDLE-ROUND-STARTING
           WHEN ANNOUNCED
              PERFORM HANDLE-ANNOUNCED
           WHEN YOUR-TURN
              PERFORM HANDLE-YOUR-TURN
           WHEN ROLLED
              PERFORM HANDLE-ROLLED
           WHEN OTHER
      *        CONTINUE
               DISPLAY "Unknown command: " SERVER-MESSAGE
           END-EVALUATE
           GOBACK
          .
       HANDLE-YOUR-TURN SECTION.
          STRING "ROLL;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ROLLED SECTION.
          PERFORM PARSE-SERVER-MESSAGE-ROLLED
          STRING "ANNOUNCE;" DELIMITED BY SIZE
                 ROLLED-DICE       DELIMITED BY SIZE
                 ";"         DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ROUND-STARTING SECTION.
          STRING "JOIN;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ANNOUNCED SECTION.
          UNSTRING SERVER-MESSAGE DELIMITED BY ';'
              INTO COMMAND
                   LAST-PLAYER
                   ANNOUNCED-DICE
          EXIT.

       PARSE-SERVER-MESSAGE SECTION.
           UNSTRING SERVER-MESSAGE
            DELIMITED BY ';'
            INTO COMMAND
                 TOKEN
           EXIT.

       PARSE-SERVER-MESSAGE-ROLLED SECTION.
           UNSTRING SERVER-MESSAGE
            DELIMITED BY ';'
            INTO COMMAND
                 ROLLED-DICE
                 TOKEN
           EXIT.

       AddOneToDice SECTION.
           PERFORM SortDice.

           IF DICE-1 IN DICE-VALUE = DICE-2 IN DICE-VALUE
      *      Pasch
             ADD 1 TO DICE-1 IN DICE-VALUE
             ADD 1 TO DICE-2 IN DICE-VALUE
             IF DICE-1 IN DICE-VALUE = 7
      *        Mäxchen
               SET DICE-1 IN DICE-VALUE TO 2
               SET DICE-2 IN DICE-VALUE TO 1
             END-IF
           ELSE
      *      Kein Pasch
             ADD 1 TO DICE-2 IN DICE-VALUE
      *      ggf. Overflow
             IF DICE-2 IN DICE-VALUE = DICE-1 IN DICE-VALUE
               SET DICE-2 IN DICE-VALUE TO 1
               ADD 1 TO DICE-1 IN DICE-VALUE
               IF DICE-1 IN DICE-VALUE = 7
                   SET DICE-1 IN DICE-VALUE TO 1
               END-IF
             END-IF
           END-IF
           
           EXIT.

       SortDice SECTION.
           IF DICE-1 IN DICE-VALUE < DICE-2 IN DICE-VALUE
               MOVE DICE-1 TO ONE-DIE
               MOVE DICE-2 TO DICE-1
               MOVE ONE-DIE TO DICE-2
           END-IF
           EXIT.


       END PROGRAM MUFFINBO.
