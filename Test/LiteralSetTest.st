DerivingParserTestCase subclass: #LiteralSetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!LiteralSetTest methodsFor: 'fixtures' stamp: 'fbs 2/1/2013 08:53'!
sampleParser
	^ LiteralSet tokens: {$a. $b. $c}.! !


!LiteralSetTest methodsFor: 'testing - deriving' stamp: 'fbs 4/15/2013 21:18'!
testDerivativeOfLiteralWrtAnotherObjectIsEmpty
	| d e |
	e := DerivingParser isEmptyBlock.
	d := DerivingParser deriverBlock value: $d value: self sampleParser.
	self assert: (e value: d).
	self assert: 'Expected one of <$a, $b, $c>, found a <$d>' equals: d error.! !

!LiteralSetTest methodsFor: 'testing - deriving' stamp: 'fbs 2/1/2013 08:55'!
testDerivativeOfLiteralWrtSelfIsEps
	| d dLit litSet |
	d := DerivingParser deriverBlock.
	litSet := self sampleParser.
	self sampleParser tokens do: [:token |
		dLit := d value: token value: litSet.
		self assert: dLit isEpsStar.
		self assert: {token} asSet equals: dLit treeSet]! !


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


!LiteralSetTest methodsFor: 'testing - testing' stamp: 'fbs 2/1/2013 08:53'!
testIsLiteral
	self assert: self sampleParser isLiteral.! !


!LiteralSetTest methodsFor: 'testing - parsing' stamp: 'fbs 2/1/2013 08:53'!
testParseNullIsEmptySet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: Set new equals: (parseNull value: $a asParser).! !


!LiteralSetTest methodsFor: 'testing - accessing' stamp: 'fbs 2/1/2013 08:56'!
testSubParsersReturnsEmptySet
	self assert: {} equals: self sampleParser subParsers.! !


!LiteralSetTest methodsFor: 'testing - printing' stamp: 'fbs 2/18/2013 21:40'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: 'LiteralSet').! !

!LiteralSetTest methodsFor: 'testing - printing' stamp: 'fbs 2/18/2013 21:41'!
testPrintAsDigraphMentionsTokens
	| p digraph |
	p := LiteralSet tokens: #(1 2).
	digraph := p printAsDigraph.
	self assert: (digraph includesSubString: p tokens printString).! !
