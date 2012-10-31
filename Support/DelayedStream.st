XTReadStream subclass: #DelayedStream
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!DelayedStream commentStamp: 'fbs 10/30/2012 11:33' prior: 0!
A DelayedStream is an otherwise normal XTReadStream except that it reads off a source that has not yet been calculated:

	hasRun := false.
	delay := DelayedStream on: [hasRun := true. #(1)].
	self deny: hasRun.
	self assert: 1 equals: (delay read: 1).
	self assert: hasRun.!


!DelayedStream methodsFor: 'initialize-release' stamp: 'fbs 10/30/2012 13:37'!
contentsSpecies
	^ self force contentsSpecies.! !


!DelayedStream methodsFor: 'private' stamp: 'fbs 10/31/2012 08:49'!
force
	source isBlock ifTrue: [source := source value reading].
	^ source.! !


!DelayedStream methodsFor: 'accessing' stamp: 'fbs 10/30/2012 13:37'!
read: anInteger into: aSequenceableCollection at: startIndex
	^ self force read: anInteger into: aSequenceableCollection at: startIndex.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DelayedStream class
	instanceVariableNames: 'source'!
