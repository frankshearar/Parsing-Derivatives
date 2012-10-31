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


!LiteralTest methodsFor: 'testing - deriving' stamp: 'fbs 8/30/2012 16:00'!
testDerivativeOfLiteralWrtAnotherObjectIsEmpty
	| d |
	d := $a asParser d: $b.
	self assert: d isEmpty.! !

!LiteralTest methodsFor: 'testing - deriving' stamp: 'fbs 9/4/2012 09:18'!
testDerivativeOfLiteralWrtSelfIsEps
	| d |
	d := $a asParser d: $a.
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

stSubParsersReturnsEmptySet
	self assert: {} equals: $a asParser subParsers.! !


!LiteralTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:54'!
testGenerateOnlyProducesOneResult
	self should: [self sampleParser generate read: 2] raise: Incomplete.! !

!LiteralTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:54'!
testGenerateProducesTheLiteral
	self assert: {self sampleParser token} equals: (self sampleParser generate read: 1).! !
