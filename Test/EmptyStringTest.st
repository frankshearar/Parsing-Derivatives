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

!EmptyStringTest methodsFor: 'testing - testing' stamp: 'fbs 9/4/2012 09:02'!
testIsNullable
	self assert: self sampleParser isNullable.! !


!EmptyStringTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 17:00'!
testDerivativeIsEmpty
	self
		assert: (DerivingParser deriverBlock value: $a value: (DerivingParser emptyString)) isEmpty
		description: 'd(_, eps*) == empty'! !




!EmptyStringTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:52'!
testParseNullIsSetWithItself
	"I don't understand this - it seems to just pollute the parse tree set - but it's what dparse.rkt does."
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: {DerivingParser emptyString} asSet equals: (parseNull value: DerivingParser emptyString).! !
mpleParser generate read: 1).
	self should: [self sampleParser generate read: 2] raise: Incomplete.! !
