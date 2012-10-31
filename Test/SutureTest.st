DerivingParserTestCase subclass: #SutureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Test'!

!SutureTest methodsFor: 'testing - instance creation' stamp: 'fbs 10/24/2012 09:27'!
testCanInstantiate
	| p |
	p := $1 asParser.
	self assert: p equals: (Suture pointingAt: p) reference.! !


!SutureTest methodsFor: 'fixtures' stamp: 'fbs 10/24/2012 09:26'!
sampleParser
	^ Suture pointingAt: $1 asParser.! !


!SutureTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:31'!
testPrintAsDigraphShowsSubparser
	| digraph p |
	p := $1 asParser.
	digraph := (Suture pointingAt: p) printAsDigraph.
	self assert: (digraph includesSubString: p dotLabel) description: 'digraph doesn''t contain subparser'.! !

!SutureTest methodsFor: 'testing - printing' stamp: 'fbs 10/24/2012 09:30'!
testPrintingShowsSubparser
	| desc p |
	p := $1 asParser.
	desc := (Suture pointingAt: p) printString.
	self assert: (desc includesSubString: 'Suture') description: 'Description doesn''t mention ''suture'''.
	self assert: (desc includesSubString: p className) description: 'Description doesn''t mention subparser'.! !
