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
           EXPECT DICE-VALUE TO BE "1 4"
         