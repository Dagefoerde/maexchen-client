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
          05   LAST-ANNOUNCED-DICE.
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
         05 DICE-COMPARISON PIC 9.
           88 ROLLED-GREATER VALUE 1.
         05 DECISION-SEE PIC 9.
           88 WANT-TO-SEE VALUE 1.
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
           PERFORM DecideSee
           IF WANT-TO-SEE THEN
             STRING "SEE;" DELIMITED BY SIZE
                    TOKEN  DELIMITED BY SIZE
             INTO MESSAGE-TO-SERVER
           ELSE
             STRING "ROLL;" DELIMITED BY SIZE
                    TOKEN  DELIMITED BY SIZE
             INTO MESSAGE-TO-SERVER
           END-IF
           EXIT.

       HANDLE-ROLLED SECTION.
          PERFORM PARSE-SERVER-MESSAGE-ROLLED
          PERFORM DecideAnnounce
          STRING "ANNOUNCE;" DELIMITED BY SIZE
                 ROLLED-DICE       DELIMITED BY SIZE
                 ";"         DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ROUND-STARTING SECTION.
          INITIALIZE LAST-ANNOUNCED-DICE
          STRING "JOIN;" DELIMITED BY SIZE
                  TOKEN  DELIMITED BY SIZE
           INTO  MESSAGE-TO-SERVER
          EXIT.

       HANDLE-ANNOUNCED SECTION.
          MOVE ANNOUNCED-DICE TO LAST-ANNOUNCED-DICE
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
               MOVE DICE-1 IN DICE-VALUE  TO ONE-DIE
               MOVE DICE-2 IN DICE-VALUE  TO DICE-1 IN DICE-VALUE 
               MOVE ONE-DIE TO DICE-2 IN DICE-VALUE 
           END-IF
           EXIT.

       CompareDice SECTION.
           MOVE ANNOUNCED-DICE TO DICE-VALUE
           PERFORM SortDice
           MOVE DICE-VALUE TO ANNOUNCED-DICE
           MOVE ROLLED-DICE TO DICE-VALUE
           PERFORM SortDice
           MOVE DICE-VALUE TO ROLLED-DICE

           INITIALIZE DICE-COMPARISON

           IF DICE-1 IN ANNOUNCED-DICE = 2 AND 
                                            DICE-2 IN ANNOUNCED-DICE = 1
             EXIT SECTION
           END-IF

           IF DICE-1 IN ROLLED-DICE = 2 AND DICE-2 IN ROLLED-DICE = 1
               SET ROLLED-GREATER TO TRUE
               
           ELSE
             IF DICE-1 IN ROLLED-DICE = DICE-2 IN ROLLED-DICE
                AND DICE-1 IN ANNOUNCED-DICE NOT = DICE-2 IN
                                                          ANNOUNCED-DICE
               SET ROLLED-GREATER TO TRUE
             ELSE 
               IF DICE-1 IN ROLLED-DICE = DICE-2 IN ROLLED-DICE
                  AND DICE-1 IN ANNOUNCED-DICE < DICE-1 IN ROLLED-DICE
                 SET ROLLED-GREATER TO TRUE
               ELSE
                 IF DICE-1 IN ANNOUNCED-DICE NOT = DICE-2
                                                       IN ANNOUNCED-DICE
                   IF DICE-1 IN ANNOUNCED-DICE < DICE-1 IN ROLLED-DICE
                     SET ROLLED-GREATER TO TRUE
                   ELSE
                     IF DICE-1 IN ANNOUNCED-DICE = DICE-1 IN ROLLED-DICE
                    AND DICE-2 IN ANNOUNCED-DICE < DICE-2 IN ROLLED-DICE
                     SET ROLLED-GREATER TO TRUE          
                     END-IF
                   END-IF
                 END-IF
               END-IF
             END-IF
           END-IF
           EXIT.

       DecideAnnounce SECTION.
           PERFORM CompareDice
           IF NOT ROLLED-GREATER
             MOVE ANNOUNCED-DICE TO DICE-VALUE
             PERFORM AddOneToDice
             MOVE DICE-VALUE TO ROLLED-DICE
           END-IF
           EXIT.

       DecideSee SECTION.
           INITIALIZE DECISION-SEE
           
           SET DICE-1 IN ROLLED-DICE TO 6
           SET DICE-2 IN ROLLED-DICE TO 6

           Perform CompareDice
           
           IF ANNOUNCED-DICE > 6 
               SET WANT-TO-SEE TO TRUE
               EXIT LINKAGE SECTION.
           END-IF

           IF NOT ROLLED-GREATER
               SET WANT-TO-SEE TO TRUE
               EXIT SECTION
           END-IF

           

           EXIT.

       END PROGRAM MUFFINBO.
