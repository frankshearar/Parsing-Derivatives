Error subclass: #ParseError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ParseError class
	instanceVariableNames: ''!

!ParseError class methodsFor: 'as yet unclassified' stamp: 'fbs 3/22/2013 08:53'!
signalLine: lineNumber column: columnNumber error: aString.
	^ self signal: ('Error at line {1}, column {2}: {3}.'
		format: {lineNumber asString. columnNumber asString. aString}).! !
