TestCase subclass: #DelayedStreamTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!DelayedStreamTest methodsFor: 'testing' stamp: 'fbs 10/30/2012 11:34'!
testCanBeInstantiated
	self shouldnt: [DelayedStream on: [#(1)]] raise: Error.! !

!DelayedStreamTest methodsFor: 'testing' stamp: 'fbs 10/31/2012 08:14'!
testCanWrapAnotherStream
	| delay |
	delay := DelayedStream on: [#(1) reading].
	self assert: #(1) equals: (delay read: 1).
	self should: [(DelayedStream on: [#(1) reading]) read: 2] raise: Incomplete.! !

!DelayedStreamTest methodsFor: 'testing' stamp: 'fbs 10/30/2012 12:29'!
testContentsSpeciesDependsOnBlockReturnType
	self assert: Array equals: (DelayedStream on: [#()]) contentsSpecies.
	self assert: ByteArray equals: (DelayedStream on: [#[]]) contentsSpecies.! !

!DelayedStreamTest methodsFor: 'testing' stamp: 'fbs 10/30/2012 13:38'!
testUnderlyingStreamCreatedLazily
	| delay hasRun |
	hasRun := false.
	delay := DelayedStream on: [hasRun := true. #(1)].
	self deny: hasRun.
	self assert: #(1) equals: (delay read: 1).
	self assert: hasRun.! !
