           TESTSUITE 'Test MAEXCHENBOT'

           TESTCASE 'Add 1 to current dice value'
               MOVE "3 2" to ANNOUNCED-DICE
      *        PERFORM AddOneToDice
           EXPECT ANNOUNCED-DICE TO BE 41
         