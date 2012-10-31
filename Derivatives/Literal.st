DerivingParser subclass: #Literal
	instanceVariableNames: 'token'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!Literal commentStamp: 'fbs 8/30/2012 16:10' prior: 0!
I represent a parser that accepts some literal. Note that parsing with derivatives is not limited to parsing streams of characters, so my literal could be any object (not already parsed by other parsers).!


!Literal methodsFor: 'initialize-release' stamp: 'fbs 8/30/2012 15:55'!
token: anObject
	token := anObject! !


!Literal methodsFor: 'testing' stamp: 'fbs 8/30/2012 15:56'!
isLiteral
	^ true.! !


!Literal methodsFor: 'accessing' stamp: 'fbs 9/5/2012 10:00'!
token
	^ token.! !


!Literal methodsFor: 'printing' stamp: 'fbs 9/17/2012 18:54'!
printAsDotNode: parserIntegerMap
	^ ('{1} [label="Literal ({2}) ({1})"]' format: {
		(parserIntegerMap at: self) printString.
		self token printString}),
	Character cr.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Literal class
	instanceVariableNames: ''!

!Literal class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 15:55'!
token: anObject
	^ self new token: anObject! !
 'instance creation' stamp: 'fbs 8/30/2012 15:55'!
token: anObject
	^ self new token: anObject! !
