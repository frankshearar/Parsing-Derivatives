DerivingParser subclass: #Cat
	instanceVariableNames: 'first second'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!Cat commentStamp: 'fbs 10/16/2012 09:32' prior: 0!
I represent a parser combines two parsers: #first consumes the first part of some stream and, once it has accepted that prefix, #second consumes the rest of the stream.

For example, $a asParser then: $b asParser (only) accepts the input 'ab'.!


!Cat methodsFor: 'initialize-release' stamp: 'fbs 8/30/2012 16:35'!
first: firstParser second: secondParser
	first := firstParser.
	second := secondParser.! !


!Cat methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:36'!
isCat
	^ true.! !


!Cat methodsFor: 'accessing' stamp: 'fbs 8/31/2012 08:03'!
first
	first isDelayed ifTrue: [first := first force].
	^ first.! !

!Cat methodsFor: 'accessing' stamp: 'fbs 8/31/2012 08:03'!
second
	second isDelayed ifTrue: [second := second force].
	^ second.! !

!Cat methodsFor: 'accessing' stamp: 'fbs 9/5/2012 19:51'!
subParsers
	^ {self first. self second}.! !


!Cat methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:06'!
printAsDotNode: parserIntegerMap
	^ ('{1}',
	'{2} -> {3} [label="first"]', Character cr,
	'{2} -> {4} [label="second"]', Character cr) format: {
		super printAsDotNode: parserIntegerMap.
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self first) printString.
		(parserIntegerMap at: self second) printString.}! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Cat class
	instanceVariableNames: ''!

!Cat class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 16:35'!
with: firstParser with: secondParser
	^ self new first: firstParser second: secondParser.! !
 tail}]]) stitching.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Cat class
	instanceVariableNames: ''!

!Cat class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 16:35'!
with: firstParser with: secondParser
	^ self new first: firstParser second: secondParser.! !
