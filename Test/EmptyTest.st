DerivingParserTestCase subclass: #EmptyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!EmptyTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:05'!
sampleParser
	^ DerivingParser empty.! !


!EmptyTest methodsFor: 'testing - testing' stamp: 'fbs 4/15/2013 21:17'!
testIsEmpty
	| e |
	e := DerivingParser isEmptyBlock.
	self assert: (e value: self sampleParser).! !

!EmptyTest methodsFor: 'testing - testing' stamp: 'fbs 2/15/2013 09:30'!
testIsEmptyParser
	self assert: self sampleParser isEmptyParser.! !


!EmptyTest methodsFor: 'testing - deriving' stamp: 'fbs 4/15/2013 22:09'!
testDerivativeIsItself
	| D e specialE |
	e := DerivingParser isEmptyBlock.
	D := DerivingParser deriverBlock.
	self assert: (e value: (D value: $a value: DerivingParser empty)).
	self assert: (D value: $a value: DerivingParser empty) == DerivingParser empty description: 'Exact empty not returned (unspecified empty)'.
	
	specialE := DerivingParser emptyExpected: 1 actual: 2.
	self assert: specialE = (D value: 3 value: specialE) description: 'Exact empty not returned (specified empty)'.! !


!EmptyTest methodsFor: 'testing - parsing' stamp: 'fbs 2/18/2013 21:35'!
testAnythingThenEmptyIsEmpty
	| p e cat |
	e := DerivingParser emptyExpected: 1 actual: 2.
	p := self sampleParser.
	cat := p then: e.
	self assert: cat == p.! !

!EmptyTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:52'!
testParseNullIsEmptySet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: Set new equals: (parseNull value: DerivingParser empty).! !

!EmptyTest methodsFor: 'testing - parsing' stamp: 'fbs 2/15/2013 14:36'!
testReduceOfAnEmptyIsThatEmpty
	| e r |
	e := DerivingParser emptyExpected: 1 actual: 2.
	r := e reduce: #printString.
	self assert: e == r description: 'Red -> Empty => Empty'.! !


!EmptyTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:32'!
testSubParsersReturnsEmptySet
	self assert: {} equals: DerivingParser empty subParsers.! !


!EmptyTest methodsFor: 'testing - generating' stamp: 'fbs 10/25/2012 18:43'!
testGenerateProducesNothing
	self should: [self sampleParser generate read: 1] raise: Incomplete.! !


!EmptyTest methodsFor: 'testing - creating' stamp: 'fbs 2/14/2013 20:58'!
testEmptyMayHaveErrorMessage
	| e |
	e := Empty expected: 1 actual: 2.
	self assert: 'Expected a <1>, found a <2>' equals: e error.! !
