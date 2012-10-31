DerivingParser subclass: #Union
	instanceVariableNames: 'left right'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!Union commentStamp: 'fbs 10/16/2012 09:33' prior: 0!
I represent a parser combines two parsers: both parsers consume some stream.

For example, $a asParser or: $b asParser (only) accepts input from the #('a' 'b') asSet.!


!Union methodsFor: 'initialize-release' stamp: 'fbs 8/30/2012 16:51'!
left: lParser right: rParser
	left := lParser.
	right := rParser.! !


!Union methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:52'!
isUnion
	^ true.! !


!Union methodsFor: 'accessing' stamp: 'fbs 8/31/2012 08:47'!
left
	left isDelayed ifTrue: [left := left force].
	^ left.! !

!Union methodsFor: 'accessing' stamp: 'fbs 8/31/2012 08:47'!
right
	right isDelayed ifTrue: [right := right force].
	^ right.! !

!Union methodsFor: 'accessing' stamp: 'fbs 9/5/2012 19:51'!
subParsers
	^ {self left. self right.}.! !


!Union methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:06'!
printAsDotNode: parserIntegerMap
	^ ('{1}',
	'{2} -> {3} [label="left"]', Character cr,
	'{2} -> {4} [label="right"]', Character cr) format: {
		super printAsDotNode: parserIntegerMap.
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self left) printString.
		(parserIntegerMap at: self right) printString.}! !


!Union methodsFor: 'generating' stamp: 'fbs 10/31/2012 14:54'!
generate
	^ (DelayedStream on: [left generate])
		interleave: (DelayedStream on: [right generate]).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Union class
	instanceVariableNames: ''!

!Union class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 16:50'!
left: lParser right: rParser
	^ self new left: lParser right: rParser.! !
