DerivingParserTestCase subclass: #EmptyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!EmptyTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:05'!
sampleParser
	^ DerivingParser empty.! !


!EmptyTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:05'!
testIsEmpty
	self assert: self sampleParser isEmpty.! !


!EmptyTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 17:00'!
testDerivativeIsItself
	| D |
	D := DerivingParser deriverBlock.
	self assert: (D value: $a value: DerivingParser empty) isEmpty.
	self assert: (D value: $a value: DerivingParser empty) == DerivingParser empty.! !


!EmptyTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:52'!
testParseNullIsEmptySet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: Set new equals: (parseNull value: DerivingParser empty).! !


!EmptyTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:32'!
testSubParsersReturnsEmptySet
	self assert: {} equals: DerivingParser empty subParsers.! !


!EmptyTest methodsFor: 'testing - generating' stamp: 'fbs 10/25/2012 18:43'!
testGenerateProducesNothing
	self should: [self sampleParser generate read: 1] raise: Incomplete.! !

