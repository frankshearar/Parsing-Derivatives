DerivingParserTestCase subclass: #StarParserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!StarParserTest methodsFor: 'testing - testing' stamp: 'fbs 9/13/2012 19:34'!
testIsStar
	self assert: self sampleParser isStar.! !

!StarParserTest methodsFor: 'testing - testing' stamp: 'fbs 10/11/2012 09:32'!
testSubParserIsChildOfSelf
	| p |
	p := self sampleParser.
	self assert: (p parser isChildOf: p).! !


!StarParserTest methodsFor: 'fixtures' stamp: 'fbs 9/13/2012 19:34'!
sampleParser
	^ $a asParser star.! !


!StarParserTest methodsFor: 'testing - deriving' stamp: 'fbs 10/16/2012 16:58'!
testDerivativeOfStarParserPeelsOffOneCopyOfSubParser
	| p d |
	p := $a asParser star.
	d := DerivingParser deriverBlock value: $a value: p.
	self assert: d isCat.
	self assert: d first isEpsStar.
	self assert: p equals: d second.! !


!StarParserTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:45'!
testPrintAsDigraphPrintsSubparsers
	| r digraph |
	r := $1 asParser.
	digraph := r star printAsDigraph.
	self assert: (digraph includesSubString: r dotLabel) description: 'digraph doesn''t mention subparser'.! !


!StarParserTest methodsFor: 'testing - generating' stamp: 'fbs 10/26/2012 09:28'!
testGenerateReturnsEverLongerParses
	self flag: #todo. "Really? A star parser is like empty | doitagain"
	self
		assert: #(() ($a) ($a $a) ($a $a $a) ($a $a $a $a))
		equals: ($a asParser star generate read: 5)! !

