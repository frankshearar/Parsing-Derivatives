Error subclass: #ArityMismatch
	instanceVariableNames: 'expectedArgCount actualArgCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!ArityMismatch commentStamp: 'fbs 7/20/2012 22:01' prior: 0!
I represent someone trying to invoke a block with the incorrect number of arguments.!


!ArityMismatch methodsFor: 'accessing' stamp: 'fbs 7/20/2012 22:02'!
actualArgCount
	^ actualArgCount.! !

!ArityMismatch methodsFor: 'accessing' stamp: 'fbs 7/20/2012 22:02'!
expectedArgCount
	^ expectedArgCount.! !


!ArityMismatch methodsFor: 'initialize-release' stamp: 'fbs 7/20/2012 22:02'!
initializeWithActualCount: actual expectedCount: expected
	actualArgCount := actual.
	expectedArgCount := expected.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ArityMismatch class
	instanceVariableNames: ''!

!ArityMismatch class methodsFor: 'as yet unclassified' stamp: 'fbs 7/20/2012 22:03'!
actual: actual expected: expected
	^ self new initializeWithActualCount: actual expectedCount: expected.! !
