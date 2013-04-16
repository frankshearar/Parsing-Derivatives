DerivingParserTestCase subclass: #EmptyStringTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!EmptyStringTest methodsFor: 'fixtures' stamp: 'fbs 9/4/2012 09:01'!
sampleParser
	^ DerivingParser emptyString.! !


!EmptyStringTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:32'!
testSubParsersReturnsEmptySet
	self assert: {} equals: DerivingParser emptyString subParsers.! !


!EmptyStringTest methodsFor: 'testing - testing' stamp: 'fbs 9/4/2012 09:02'!
testIsEps
	self assert: self sampleParser isEps.! !

!EmptyStringTest methodsFor: 'testing - testing' stamp: 'fbs 10/24/2012 21:41'!
testIsNullable
	self assert: (DerivingParser isNullableBlock value: self sampleParser).! !


!EmptyStringTest methodsFor: 'testing - deriving' stamp: 'fbs 4/15/2013 22:08'!
testDerivativeIsEmpty
	| e |
	e := DerivingParser isEmptyBlock.
	self
		assert: (e value: (DerivingParser deriverBlock value: $a value: (DerivingParser emptyString)))
		description: 'd(_, eps*) == empty'! !


!EmptyStringTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:36'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: 'eps').! !


!EmptyStringTest methodsFor: 'testing - generating' stamp: 'fbs 10/29/2012 12:03'!
testGenerateProducesOneEmptyString
	self assert: #(()) equals: (self sampleParser generate read: 1).
	self should: [self sampleParser generate read: 2] raise: Incomplete.! !

