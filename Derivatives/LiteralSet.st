DerivingParser subclass: #LiteralSet
	instanceVariableNames: 'token tokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!

!LiteralSet methodsFor: 'as yet unclassified' stamp: 'fbs 2/1/2013 17:29'!
generate
	^ tokens reading.! !

!LiteralSet methodsFor: 'as yet unclassified' stamp: 'fbs 1/18/2013 08:47'!
isLiteral
	^ true.! !

!LiteralSet methodsFor: 'as yet unclassified' stamp: 'fbs 1/18/2013 08:48'!
printAsDotNode: parserIntegerMap
	^ ('{1} [label="LiteralSet ({2}) ({1})"]' format: {
		(parserIntegerMap at: self) printString.
		tokens printString}),
	Character cr.! !

!LiteralSet methodsFor: 'as yet unclassified' stamp: 'fbs 1/18/2013 08:48'!
tokens
	^ tokens.! !

!LiteralSet methodsFor: 'as yet unclassified' stamp: 'fbs 1/18/2013 08:48'!
tokens: someObjects
	tokens := someObjects.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

LiteralSet class
	instanceVariableNames: ''!

!LiteralSet class methodsFor: 'as yet unclassified' stamp: 'fbs 1/18/2013 08:49'!
tokens: someObjects
	^ self new tokens: someObjects! !
