DerivingParserTestCase subclass: #UnionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!UnionTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 16:52'!
sampleParser
	^ $a asParser or: $b asParser.! !


!UnionTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 16:51'!
testIsUnion
	self assert: self sampleParser isUnion.! !

!UnionTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:31'!
testSubParserIsChildOfUnion
	| p |
	p := self sampleParser.
	self assert: (p left isChildOf: p).
	self assert: (p right isChildOf: p).! !


!UnionTest methodsFor: 'testing - accessing' stamp: 'fbs 8/31/2012 08:46'!
testLeft
	| p p1 p2 |
	p1 := $a asParser.
	p2 := $b asParser.
	p := p1 or: p2.
	self assert: p1 equals: p left.! !

!UnionTest methodsFor: 'testing - accessing' stamp: 'fbs 8/31/2012 08:47'!
testRight
	| p p1 p2 |
	p1 := $a asParser.
	p2 := $b asParser.
	p := p1 or: p2.
	self assert: p2 equals: p right.! !

!UnionTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:27'!
testSubParsersReturnsLeftAndRight
	| p |
	p := $a asParser or: $b asParser.
	self assert: {p left. p right} equals: p subParsers.! !


!UnionTest methodsFor: 'testing - parsing' stamp: 'fbs 10/11/2012 19:36'!
testDerivativeIsUnionOfSubparserDerivatives
	| d |
	"This strange-looking grammar ensures that the derivative of both subparsers are not isEmpty."
	d := (($a asParser then: $c asParser) or: ($a asParser then: $b asParser)) d: $a.
	self assert: d isUnion.
	"Left subparser is now 'we have read a $a and expect a $c next."
	self assert: d left isUnion.
	self assert: d left right isCat.
	self assert: d left right first isEpsStar.
	self assert: d left right second isLiteral.
	self assert: $c equals: d left right second token.
	
	"Right subparser is now 'we have read a $a and expect a $b next."
	self assert: d right isUnion.
	self assert: d right right isCat.
	self assert: d right right first isEpsStar.
	self assert: d right right second isLiteral.
	self assert: $b equals: d right right second token.! !

!UnionTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:53'!
testParseNullIsUnionOfSubParsersParseTrees
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: {1. 2} asSet equals: (parseNull value: ((EpsStar treeSet: {1}) or: (EpsStar treeSet: {2}))).! !

!UnionTest methodsFor: 'testing - parsing' stamp: 'fbs 9/12/2012 09:12'!
testUnionOfCompactedParsersCompactsToItself
	| u |
	u := $a asParser or: $b asParser.
	self assert: u == (Compacter value: u).! !



/24/2012 09:43'!
testPrintAsDigraphPrintsSubparsers
	| l r digraph |
	l := $1 asParser.
	r := DerivingParser emptyString.
	digraph := (l or: r) printAsDigraph.
	self assert: (digraph includesSubString: l dotLabel) description: 'digraph doesn''t mention first subparser'.
	self assert: (digraph includesSubString: r dotLabel) description: 'digraph doesn''t mention second subparser'.! !


!UnionTest methodsFor: 'testing - generating' stamp: 'fbs 10/30/2012 17:30'!
testGenerateHandlesLeftSubparserWithInfiniteStream
	| u |
	"Left subparser an infinite number of parse trees; right can produce one."
	u := $a asParser star or: $c asParser.
	self assert: #(() $c ($a)) equals: (u generate read: 3).
	self shouldnt: [u generate read: 4] raise: Incomplete.! !

!UnionTest methodsFor: 'testing - generating' stamp: 'fbs 10/29/2012 20:15'!
testGenerateHandlesLeftSubparserWithShortStreams
	| u |
	"Left subparser can only produce one parse tree; right can produce two."
	u := $a asParser or: ($b asParser or: $c asParser).
	self assert: #($a $b $c) equals: (u generate read: 3).
	self should: [u generate read: 4] raise: Incomplete.! !

!UnionTest methodsFor: 'testing - generating' stamp: 'fbs 10/30/2012 17:31'!
testGenerateHandlesRightSubparserWithInfiniteStream
	| u |
	"Right subparser can an infinite number of parse trees; left can produce one."
	u := $a asParser or: $c asParser star.
	self assert: #($a () ($c)) equals: (u generate read: 3).
	self shouldnt: [u generate read: 4] raise: Incomplete.! !

!UnionTest methodsFor: 'testing - generating' stamp: 'fbs 10/29/2012 20:16'!
testGenerateHandlesRightSubparserWithShortStreams
	| u |
	"Right subparser can only produce one parse tree; left can produce two."
	u := ($a asParser or: $b asParser) or: $c asParser.
	self assert: #($a $c $b) equals: (u generate read: 3).
	self should: [u generate read: 4] raise: Incomplete.! !

!UnionTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 18:59'!
testGenerateProducesInterleavedParsesFromSubparsers
	| u |
	u := $a asParser or: $b asParser.
	self assert: #($a $b) equals: (u generate read: 2).
	self should: [u generate read: 3] raise: Incomplete.! !
