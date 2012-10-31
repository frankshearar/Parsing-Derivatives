DerivingParserTestCase subclass: #DelegateParserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!DelegateParserTest methodsFor: 'testing - accessing' stamp: 'fbs 8/31/2012 12:09'!
testParser
	| p t |
	t := $a asParser.
	p := DelegateParser new.
	p parser: t.
	self assert: p parser == t.! !

!DelegateParserTest methodsFor: 'testing - accessing' stamp: 'fbs 9/12/2012 09:27'!
testSubParsersOfUnresolvedDelegateIsEmpty
	| p |
	p := DelegateParser new.
	self assert:#() equals: p subParsers.! !

!DelegateParserTest methodsFor: 'testing - accessing' stamp: 'fbs 9/5/2012 19:30'!
testSubParsersReturnsDelegatedParser
	| p |
	p := DelegateParser new.
	p parser: $a asParser.
	self assert: {p parser} equals: p subParsers.! !


!DelegateParserTest methodsFor: 'fixtures' stamp: 'fbs 8/31/2012 12:10'!
sampleParser
	^ DelegateParser new parser: $a asParser.! !


!DelegateParserTest methodsFor: 'testing - testing' stamp: 'fbs 8/31/2012 12:12'!
testIsAsNullableAsSubparser
	| p |
	p := DelegateParser new parser: (EpsStar treeSet: {1}); yourself.
	self assert: p isNullable.! !

!DelegateParserTest methodsFor: 'testing - testing' stamp: 'fbs 9/11/2012 19:55'!
testIsDelegate
	self assert: self sampleParser isDelegate.! !

!DelegateParserTest methodsFor: 'testing - testing' stamp: 'fbs 8/31/2012 12:11'!
testIsNullable
	| p |
	p := DelegateParser new.
	p parser: $a asParser.
	self deny: p isNullable.! !

!DelegateParserTest methodsFor: 'testing - testing' stamp: 'fbs 9/12/2012 09:33'!
testResolvedDelegateIsResolved
	self assert: (DelegateParser new parser: $a asParser) isResolved.! !

!DelegateParserTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:32'!
testSubParserIsChildOfSelf
	| p |
	p := self sampleParser.
	self assert: (p parser isChildOf: p).! !

!DelegateParserTest methodsFor: 'testing - testing' stamp: 'fbs 9/12/2012 09:32'!
testUnresolvedDelegateIsNotResolved
	self deny: DelegateParser new isResolved.! !


!DelegateParserTest methodsFor: 'testing - parsing' stamp: 'fbs 10/10/2012 18:59'!
testCompactionIsCompactionOfSubparser
	| p d |
	p := DerivingParser empty.
	d := DelegateParser new parser: p.
	self assert: (SutureCompacter value: d) parser isEmpty.! !

!DelegateParserTest methodsFor: 'testing - parsing' stamp: 'fbs 10/12/2012 18:51'!
testParseNullIsThatOfSubparser
	| p parseNull |
	parseNull := DerivingParser parseNullBlock.
	p := DelegateParser new
		parser: ((EpsStar treeSet: {1}) or: (EpsStar treeSet: {2}));
		yourself.
	self assert: #(1 2) asSet equals: (parseNull value: p).! !



: (parseNull value: p).! !


!DelegateParserTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:36'!
testDotLabelDescribesParser
	| p |
	p := self sampleParser.
	self assert: (p dotLabel includesSubString: 'Delegate').! !

!DelegateParserTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:45'!
testPrintAsDigraphPrintsSubparsers
	| r digraph |
	r := $1 asParser.
	digraph := (DelegateParser new parser: r) printAsDigraph.
	self assert: (digraph includesSubString: r dotLabel) description: 'digraph doesn''t mention subparser'.! !


!DelegateParserTest methodsFor: 'testing - evaluating' stamp: 'fbs 10/24/2012 21:38'!
testResolvedParserDoesntExecuteWhenNullableBlockWhenNotNullable
	| ranBlock |
	ranBlock := false.
	(DelegateParser new parser: $1 asParser)
		whenNullable: [:onlyParse | ranBlock := true ].
	self deny: ranBlock.! !

!DelegateParserTest methodsFor: 'testing - evaluating' stamp: 'fbs 10/24/2012 21:38'!
testResolvedParserExecutesWhenNullableBlockWhenNullable
	| ranBlock |
	ranBlock := false.
	(DelegateParser new parser: (EpsStar treeSet: {1}))
		whenNullable: [:onlyParse |
			ranBlock := true ].
	self assert: ranBlock.! !

!DelegateParserTest methodsFor: 'testing - evaluating' stamp: 'fbs 10/24/2012 21:38'!
testUnresolvedParserNeverExecutesWhenNullableBlock
	| ranBlock |
	ranBlock := false.
	DelegateParser new whenNullable: [:onlyParse | ranBlock := true ].
	self deny: ranBlock.! !


!DelegateParserTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 19:01'!
testGenerateReturnsSubparsersParses
	| d p |
	p := $a asParser.
	d := DelegateParser new parser: p.
	self assert: #($a) equals: (d generate read: 1).
	self should: [d generate read: 2] raise: Incomplete.! !
