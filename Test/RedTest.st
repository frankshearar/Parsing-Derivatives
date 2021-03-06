DerivingParserTestCase subclass: #RedTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!RedTest methodsFor: 'testing - accessing' stamp: 'fbs 8/30/2012 22:11'!
testParser
	| p sub red |
	sub := $1 asParser.
	red := [:x | x + 1].
	p := sub reduce: red.
	self assert: sub equals: p parser.
	self assert: red equals: p reducer.! !

!RedTest methodsFor: 'testing - accessing' stamp: 'fbs 8/30/2012 22:11'!
testReducer
	| p sub red |
	sub := $1 asParser.
	red := [:x | x + 1].
	p := sub reduce: red.
	self assert: red equals: p reducer.! !

!RedTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:33'!
testSubParsersReturnsSubParser
	| p |
	p := $a asParser reduce: #yourself.
	self assert: {p parser} equals: p subParsers.! !


!RedTest methodsFor: 'testing - testing' stamp: 'fbs 10/24/2012 21:42'!
testIsNullable
	"A reduction is as nullable as its subparser."
	| n |
	n := DerivingParser isNullableBlock.
	self assert: (n value: ((EpsStar treeSet: {1}) reduce: [:x | x + 1])).
	self deny: (DerivingParser isNullableBlock value: (DerivingParser empty reduce: [:x | x + 1])).! !

!RedTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:43'!
testIsRed
	self assert: self sampleParser isRed.! !

!RedTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:32'!
testSubParserIsChildOfSelf
	| p |
	p := self sampleParser.
	self assert: (p parser isChildOf: p).! !


!RedTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:44'!
sampleParser
	^ (EpsStar treeSet: {1. 2}) reduce: [:x | x + 1].! !


!RedTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 16:59'!
testDerivativeIsTheReductionOfTheSubParsersDerivative
	| d p sub parseNull |
	parseNull := DerivingParser parseNullBlock.
	sub := 1 asParser.
	p := sub reduce: [:x | x + 1].
	d := DerivingParser deriverBlock value: 1 value: p.
	self assert: d isRed.
	self assert: {2} asSet equals: (parseNull value: d) description: 'The subparser of the derivative is the derivative of the subparser'.
	self assert: d reducer == p reducer description: 'The reducer remains the same'.! !


!RedTest methodsFor: 'testing - parsing' stamp: 'fbs 2/8/2013 08:46'!
testCompactOfNestedRedsComposesTheirReducers
	| c p1 p2 |
	p1 := 1 asParser reduce: [:i | i + 1].
	p2 := p1 reduce: [:j | j * 2].
	c := ParserCompacter value: p2.
	self assert: c isRed.
	self assert: c parser isLiteral.
	self assert: 4 equals: (c reducer value: 1).! !

!RedTest methodsFor: 'testing - parsing' stamp: 'fbs 2/8/2013 08:47'!
testCompactionIsRedOfCompactedSubparser
	| p c |
	p := DerivingParser deriverBlock value: $a value: ($a asParser star reduce: [:x | {$b}, x]).
	c := ParserCompacter value: p.
	self assert: c isRed.
	self assert: c parser == (ParserCompacter value: c parser).! !

!RedTest methodsFor: 'testing - parsing' stamp: 'fbs 9/18/2012 09:38'!
testReduceOfaRedComposesReducers
	| r p |
	p := 1 asParser reduce: [:x | x + 1].
	r := p reduce: [:x | x * 2].
	self assert: r isRed.
	self assert: r parser isLiteral.
	self assert: 4 equals: (r reducer value: 1).! !


!RedTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:45'!
testPrintAsDigraphPrintsSubparsers
	| r digraph |
	r := $1 asParser.
	digraph := (r reduce: #yourself) printAsDigraph.
	self assert: (digraph includesSubString: r dotLabel) description: 'digraph doesn''t mention subparser'.! !


!RedTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:59'!
testGenerateProducesReducedParsesOfTheSubparser
	| red |
	red := 1 asParser reduce: [:x | x + 1].
	self assert: #(2) equals: (red generate read: 1).
	self should: [red generate read: 2] raise: Incomplete.! !
