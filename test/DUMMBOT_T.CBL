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

           TESTCASE 'Decide see if anno=last anno +1 and anno > 63.'
               MOVE "6 4" TO ANNOUNCED-DICE
               MOVE "6 3" TO LAST-ANNOUNCED-DICE
               PERFORM DecideSee
           EXPECT DECISION-SEE TO BE 1

           TESTCASE 'Decide see if anno=last anno +1 and anno < 63.'
               MOVE "6 3" TO ANNOUNCED-DICE
               MOVE "6 2" TO LAST-ANNOUNCED-DICE
               PERFORM DecideSee
           EXPECT DECISION-SEE TO BE 0

           TESTCASE 'Decide see if anno=last anno+1 and anno pair > 63.'
               MOVE "1 1" TO ANNOUNCED-DICE
               MOVE "6 5" TO LAST-ANNOUNCED-DICE
               PERFORM DecideSee
           EXPECT DECISION-SEE TO BE 1

           TESTCASE 'Decide see if last anno empty and anno > 63.'
               MOVE "6 5" TO ANNOUNCED-DICE
               MOVE "   " TO LAST-ANNOUNCED-DICE
               PERFORM DecideSee
           EXPECT DECISION-SEE TO BE 0

           TESTCASE 'Decide see if first die >=7.'
               MOVE "7 3" TO ANNOUNCED-DICE
               PERFORM DecideSee
           EXPECT DECISION-SEE TO BE 1

           TESTCASE 'Random Add. Random > 0.5'
               MOVE 0.6 TO Pseudo-Random-Number
               MOVE "1 1" TO DICE-VALUE
               PERFORM RandomAdd
           EXPECT DICE-VALUE TO BE "2 2"

           TESTCASE 'Random Add. Random < 0.5'
               MOVE 0.3 TO Pseudo-Random-Number
               MOVE "1 1" TO DICE-VALUE
               PERFORM RandomAdd
           EXPECT DICE-VALUE TO BE "1 1"

           TESTCASE 'Initial Roll'
               MOVE "   " TO ANNOUNCED-DICE
               MOVE "3 1" TO ROLLED-DICE
               PERFORM DecideAnnounce
           EXPECT ROLLED-DICE TO BE "3 1"

           TESTCASE 'Compare empty Roll'
               MOVE "   " TO ANNOUNCED-DICE
               MOVE "3 1" TO ROLLED-DICE
               PERFORM CompareDice
           EXPECT DICE-COMPARISON TO BE 1

           TESTCASE 'Unsort'
               MOVE "3 1" TO ROLLED-DICE
               PERFORM UnsortRolledDice
           EXPECT ROLLED-DICE TO BE "1 3"

           TESTCASE 'Unsort'
               MOVE "6 3" TO ROLLED-DICE
               PERFORM UnsortRolledDice
           EXPECT ROLLED-DICE TO BE "3 6"


