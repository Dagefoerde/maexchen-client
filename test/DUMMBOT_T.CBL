           TESTSUITE 'Test MAEXCHENBOT'

           TESTCASE 'Add 1 to current dice value'
               MOVE 32 to DICE-VALUE
               PERFORM AddOneToDice
           EXPECT DICE-VALUE TO BE 41
         