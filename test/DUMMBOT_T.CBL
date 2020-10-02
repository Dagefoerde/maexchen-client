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
         
           TESTCASE 'Is rolled dice greater than announced dice'
               MOVE "2 4" TO ANNOUNCED-DICE
               MOVE "5 3" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT ROLLED-GREATER TO BE TRUE

           TESTCASE 'Is rolled dice greater than announced dice'
               MOVE "2 4" TO ANNOUNCED-DICE
               MOVE "1 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT ROLLED-GREATER TO BE TRUE

           TESTCASE 'Is announced dice greater than rolled dice'
               MOVE "2 2" TO ANNOUNCED-DICE
               MOVE "1 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT ROLLED-GREATER TO BE FALSE

           TESTCASE 'Is announced dice greater than rolled dice'
               MOVE "2 2" TO ANNOUNCED-DICE
               MOVE "3 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT ROLLED-GREATER TO BE FALSE

           TESTCASE 'Is announced dice greater than rolled dice'
               MOVE "1 2" TO ANNOUNCED-DICE
               MOVE "3 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT ROLLED-GREATER TO BE FALSE

           TESTCASE 'Is announced dice greater than rolled dice'
               MOVE "1 2" TO ANNOUNCED-DICE
               MOVE "2 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT ROLLED-GREATER TO BE FALSE

