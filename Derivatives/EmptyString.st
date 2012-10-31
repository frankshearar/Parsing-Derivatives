DerivingParser subclass: #EmptyString
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!EmptyString commentStamp: 'fbs 8/30/2012 16:23' prior: 0!
I represent a parser that may parse the empty string.!


!EmptyString methodsFor: 'testing' stamp: 'fbs 9/4/2012 09:07'!
isEps
	^ true.! !


!EmptyString methodsFor: 'printing' stamp: 'fbs 10/15/2012 19:59'!
dotLabel
	^ 'eps'.! !

!EmptyString methodsFor: 'printing' stamp: 'fbs 9/18/2012 16:00'!
printAsDotNode: parserIntegerMap
	^ ('{1} [label="{2} ({1})"]' format: {
		(parserIntegerMap at: self) printString.
		self dotLabel}),
	Character cr.! !


!EmptyString methodsFor: 'converting' stamp: 'fbs 10/23/2012 18:55'!
asCollection
	^ #().! !


!EmptyString methodsFor: 'generating' stamp: 'fbs 10/29/2012 12:03'!
generate
	^ #(()) reading! !

