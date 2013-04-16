DerivingParserTestCase subclass: #DelayedParserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!DelayedParserTest methodsFor: 'fixtures' stamp: 'fbs 8/30/2012 21:28'!
sampleParser
	^ [1 asParser] asParser.! !


!DelayedParserTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 21:30'!
testForce
	| p sub |
	sub := $a asParser.
	p := sub delay.
	self assert: p force == sub.! !

!DelayedParserTest methodsFor: 'testing - testing' stamp: 'fbs 8/30/2012 21:29'!
testIsDelayed
	self assert: self sampleParser isDelayed.! !

!DelayedParserTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:32'!
testSubParserIsChildOfSelf
	| p |
	p := self sampleParser.
	self assert: (p parser isChildOf: p).! !


!DelayedParserTest methodsFor: 'testing - instance creation' stamp: 'fbs 9/5/2012 09:38'!
testDelayingADelayedParserIsaNoOp
	| p d |
	p := [1 asParser] asParser.
	d := p delay.
	self assert: p == d.! !


!DelayedParserTest methodsFor: 'testing - deriving' stamp: 'fbs 4/15/2013 22:05'!
testDerivativeIsDerivativeOfSubparser
	| e |
	e := DerivingParser isEmptyBlock.
	self assert: (e value: (DerivingParser deriverBlock value: $b value: ($a asParser delay))).! !


!DelayedParserTest methodsFor: 'testing - parsing' stamp: 'fbs 10/24/2012 21:41'!
testIsNullable
	"A delay is as nullable as its subparser."
	| n |
	n := DerivingParser isNullableBlock.
	self assert: (n value: (EpsStar treeSet: {1}) delay).
	self deny: (n value: DerivingParser empty delay).! !

!DelayedParserTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:51'!
testParseNullIsThatOfSubparser
	| parseNull |
	parseNull := DerivingParser parseNullBlock.
	self assert: #(1 2) asSet equals: (parseNull value: (EpsStar treeSet: #(1 2)) delay).! !


!DelayedParserTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:29'!
testSubParsersReturnsForced
	| p |
	p := $a asParser delay.
	self assert: {p parser} equals: p subParsers.! !


!DelayedParserTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:35'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: 'Delay').! !

!DelayedParserTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:44'!
testPrintAsDigraphPrintsSubparsers
	| r digraph |
	r := $1 asParser.
	digraph := r delay printAsDigraph.
	self assert: (digraph includesSubString: r dotLabel) description: 'digraph doesn''t mention subparser'.! !


!DelayedParserTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 19:00'!
testGenerateReturnsSubparsersParses
	| d p |
	p := $a asParser.
	d := p delay.
	self assert: (p generate read: 1) equals: (d generate read: 1).
	self should: [d generate read: 2] raise: Incomplete.! !
