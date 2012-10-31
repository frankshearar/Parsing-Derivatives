DerivingParserTestCase subclass: #EpsStarTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!EpsStarTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:23'!
sampleParser
	^ EpsStar treeSet: {$a}.! !


!EpsStarTest methodsFor: 'testing - testing' stamp: 'fbs 9/4/2012 09:04'!
testIsEpsStar
	self assert: self sampleParser isEpsStar.! !

!EpsStarTest methodsFor: 'testing - testing' stamp: 'fbs 10/24/2012 21:42'!
testIsNullable
	self assert: (DerivingParser isNullableBlock value: self sampleParser).! !


!EpsStarTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 17:00'!
testDerivativeIsEmpty
	self
		assert: (DerivingParser deriverBlock value: $a value: (EpsStar treeSet: {})) isEmpty
		description: 'd(_, eps*) == empty'! !


!EpsStarTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:53'!
testParseNullIsTreeSet
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: {1. 2} asSet equals: (parseNull value: (EpsStar treeSet: {1. 2})).! !


!EpsStarTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:32'!
testSubParsersReturnsEmptySet
	self assert: {} equals: (EpsStar treeSet: {1}) subParsers.! !


!EpsStarTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:37'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: 'eps*').! !

!EpsStarTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:48'!
testPrintAsDigraphMentionsTreeSet
	| p digraph |
	p := EpsStar treeSet: {1}.
	digraph := p printAsDigraph.
	self assert: (digraph includesSubString: p treeSet printString).! !


!EpsStarTest methodsFor: 'testing - generating' stamp: 'fbs 10/25/2012 18:43'!
testGenerateProducesNothing
	self should: [self sampleParser generate read: 1] raise: Incomplete.! !
