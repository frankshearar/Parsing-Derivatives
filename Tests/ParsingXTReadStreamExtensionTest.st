TestCase subclass: #ParsingXTReadStreamExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingXTReadStreamExtensionTest methodsFor: 'testing' stamp: 'fbs 10/31/2012 13:26'!
testInterleavingEmptyStreamsRaisesIncomplete
	self should: [(#() reading interleave: #() reading) read: 1] raise: Incomplete.! !

!ParsingXTReadStreamExtensionTest methodsFor: 'testing' stamp: 'fbs 10/31/2012 13:09'!
testInterleavingInfiniteStreamsIsFair
	self assert: #(1 2 1 2 1 2 1) equals: (([1] reading interleave: [2] reading) read: 7).! !

!ParsingXTReadStreamExtensionTest methodsFor: 'testing' stamp: 'fbs 10/31/2012 13:10'!
testInterleavingPermitsLeftStreamToStarve
	self assert: #(1 2 2) equals: ((#(1) reading interleave: [2] reading) read: 3).! !

!ParsingXTReadStreamExtensionTest methodsFor: 'testing' stamp: 'fbs 10/31/2012 13:10'!
testInterleavingPermitsRightStreamToStarve
	self assert: #(1 2 1) equals: (([1] reading interleave: #(2) reading) read: 3).! !
