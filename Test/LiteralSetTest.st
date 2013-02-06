DerivingParserTestCase subclass: #LiteralSetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!LiteralSetTest methodsFor: 'testing - testing' stamp: 'fbs 2/1/2013 08:53'!
testIsLiteral
	self assert: self sampleParser isLiteral.! !


!LiteralSetTest methodsFor: 'fixtures' stamp: 'fbs 2/1/2013 08:53'!
sampleParser
	^ LiteralSet tokens: {$a. $b. $c}.! !


!LiteralSetTest methodsFor: 'testing - deriving' stamp: 'fbs 2/1/2013 08:53'!
testDerivativeOfLiteralWrtAnotherObjectIsEmpty
	| d |
	d := DerivingParser deriverBlock value: $d value: $a asParser.
	self assert: d isEmpty.! !

!LiteralSetTest methodsFor: 'testing - deriving' stamp: 'fbs 2/1/2013 08:55'!
testDerivativeOfLiteralWrtSelfIsEps
	| d dLit litSet |
	d := DerivingParser deriverBlock.
	litSet := self sampleParser.
	self sampleParser tokens do: [:token |
		dLit := d value: token value: litSet.
		self assert: dLit isEpsStar.
		self assert: {token} asSet equals: dLit treeSet]! !


!LiteralSetTest methodsFor: 'testing - parsing' stamp: 'fbs 2/1/2013 08:53'!
testParseNullIsEmptySet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: Set new equals: (parseNull value: $a asParser).! !


!LiteralSetTest methodsFor: 'testing - accessing' stamp: 'fbs 2/1/2013 08:56'!
testSubParsersReturnsEmptySet
	self assert: {} equals: self sampleParser subParsers.! !


!LiteralSetTest methodsFor: 'testing - generating' stamp: 'fbs 2/1/2013 17:28'!
testGenerateOnlyProducesAtMostNResults
	| p |
	p := self sampleParser.
	self should: [p generate read: (p tokens size + 1)] raise: Incomplete.! !

!LiteralSetTest methodsFor: 'testing - generating' stamp: 'fbs 2/1/2013 08:57'!
testGenerateProducesTheLiteral
	| p |
	p := self sampleParser.
	self assert: p tokens equals: (self sampleParser generate read: (p tokens size)).! !
