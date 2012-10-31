TestCase subclass: #ParserInspectorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!ParserInspectorTest methodsFor: 'testing - accessing' stamp: 'fbs 10/24/2012 21:45'!
testFieldListIncludesGraphItem
	| i |
	i := ParserInspector inspect: DerivingParser empty.
	self assert: (i fieldList includes: '<graph>').! !

!ParserInspectorTest methodsFor: 'testing - accessing' stamp: 'fbs 10/24/2012 21:50'!
testHandlesDisplayingBrokenGraph
	| i |
	i := ParserInspector inspect: (DerivingParser empty then: nil).
	self shouldnt: [i toggleIndex: (i fieldList size).] raise: Error.! !

!ParserInspectorTest methodsFor: 'testing - accessing' stamp: 'fbs 10/24/2012 21:49'!
testSelectingGraphPrintsGraph
	| i |
	i := ParserInspector inspect: DerivingParser empty.
	i toggleIndex: (i fieldList size).
	self assert: i object printAsDigraph printString equals: i contents asString.! !
