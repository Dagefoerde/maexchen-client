           TESTSUITE 'Test MAEXCHENBOT'

           TESTCASE 'Add 1 to current dice value'
               MOVE "3 2" to DICE-VALUE
               PERFORM AddOneToDice
           EXPECT DICE-VALUE TO BE "4 1"

           TESTCASE 'Sort sorted dice value'
               MOVE "3 2" to DICE-VALUE
               PERFORM SortDice
           EXPECT DICE-VALUE TO BE "3 2"

           TESTCASE 'Sort dice value'
               MOVE "1 4" to DICE-VALUE
               PERFORM SortDice
           EXPECT DICE-VALUE TO BE "4 1"

           TESTCASE 'Is rolled greater than announced (both numbers)'
               MOVE "2 4" TO ANNOUNCED-DICE
               MOVE "5 3" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 1

           TESTCASE 'Is rolled greater than announced (r=pair)'
               MOVE "2 4" TO ANNOUNCED-DICE
               MOVE "1 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 1

           TESTCASE 'Is announced greater than rolled (both pair)'
               MOVE "2 2" TO ANNOUNCED-DICE
               MOVE "1 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 0

           TESTCASE 'Is announced greater than rolled (a=pair)'
               MOVE "2 2" TO ANNOUNCED-DICE
               MOVE "3 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 0

           TESTCASE 'Is announced greater than rolled (a=mia)'
               MOVE "1 2" TO ANNOUNCED-DICE
               MOVE "3 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 0

           TESTCASE 'Is announced greater than rolled (both mia)'
               MOVE "1 2" TO ANNOUNCED-DICE
               MOVE "2 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 0

           TESTCASE 'Decide announce rolled higher'
               MOVE "1 5" TO ANNOUNCED-DICE
               MOVE "2 6" TO ROLLED-DICE
               PERFORM DecideAnnounce
           EXPECT ROLLED-DICE TO BE "6 2"

           TESTCASE 'Decide announce rolled lower'
               MOVE "1 5" TO ANNOUNCED-DICE
               MOVE "2 3" TO ROLLED-DICE
               PERFORM DecideAnnounce
           EXPECT ROLLED-DICE NOT TO BE "3 2"

           TESTCASE 'Decide announce rolled lower, compare against an..'
               MOVE "2 2" TO ANNOUNCED-DICE
               MOVE "2 3" TO ROLLED-DICE
               PERFORM DecideAnnounce
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 1

           TESTCASE 'Decide see in case of 6 pair.'
               MOVE "6 6" TO ANNOUNCED-DICE
               PERFORM DecideSee
           EXPECT DECISION-SEE TO BE 1
