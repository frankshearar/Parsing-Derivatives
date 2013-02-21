DerivingParserTestCase subclass: #LiteralTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!LiteralTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:13'!
testIsLiteral
	self assert: self sampleParser isLiteral.! !


!LiteralTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:06'!
sampleParser
	^ $a asParser.! !


!LiteralTest methodsFor: 'testing - deriving' stamp: 'fbs 2/12/2013 16:13'!
testDerivativeOfLiteralWrtAnotherObjectIsEmpty
	| d |
	d := DerivingParser deriverBlock value: $b value: $a asParser.
	self assert: d isEmpty.
	self assert: 'Expected a <$a>, found a <$b>' equals: d error.! !

!LiteralTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 16:59'!
testDerivativeOfLiteralWrtSelfIsEps
	| d |
	d := DerivingParser deriverBlock value: $a value: $a asParser.
	self assert: d isEpsStar.
	self assert: {$a} asSet equals: d treeSet.! !


!LiteralTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:53'!
testParseNullIsEmptySet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: Set new equals: (parseNull value: $a asParser).! !


!LiteralTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:32'!
testSubParsersReturnsEmptySet
	self assert: {} equals: $a asParser subParsers.! !


!LiteralTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:54'!
testGenerateOnlyProducesOneResult
	self should: [self sampleParser generate read: 2] raise: Incomplete.! !

!LiteralTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:54'!
testGenerateProducesTheLiteral
	self assert: {self sampleParser token} equals: (self sampleParser generate read: 1).! !
