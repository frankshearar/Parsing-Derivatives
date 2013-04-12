TestCase subclass: #XTPositionTrackingStreamTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!XTPositionTrackingStreamTest methodsFor: 'testing - parsing' stamp: 'fbs 4/11/2013 22:20'!
testParsingParsesWithCatParsers
	| d pn digits |
	d := DerivingParser deriverBlock.
	pn := DerivingParser parseNullBlock.
	digits := 1 asParser then: 2 asParser.
	self assert: Set new equals: (pn value: (d value: $n value: digits)).
	self assert: #(1 2) equals: (pn value: (d value: 2 value: (d value: 1 value: digits))) anyOne.! !

!XTPositionTrackingStreamTest methodsFor: 'testing - parsing' stamp: 'fbs 4/11/2013 22:06'!
testParsingParsesWithSimpleParsers
	| d pn |
	d := DerivingParser deriverBlock.
	pn := DerivingParser parseNullBlock.
	self assert: $n equals: (pn value: (d value: $n value: $n asParser)) anyOne.
	self assert: 1 equals: (pn value: (d value: 1 value: 1 asParser)) anyOne.
	self assert: false equals: (pn value: (d value: false value: false asParser)) anyOne.! !


!XTPositionTrackingStreamTest methodsFor: 'testing - line numbers' stamp: 'fbs 2/11/2013 21:18'!
testLineNumberDoesntIncrementOnOrdinaryCharacters
	| stream |
	stream := XTPositionTrackingStream on: '123' reading.
	stream get.
	self assert: 1 equals: stream lineNumber description: 'After 1 get'.
	stream get.
	self assert: 1 equals: stream lineNumber description: 'After 2 gets'.
	stream get.
	self assert: 1 equals: stream lineNumber description: 'After 3 gets'.! !

!XTPositionTrackingStreamTest methodsFor: 'testing - line numbers' stamp: 'fbs 2/11/2013 21:22'!
testLineNumberIncrementsAfterReadingaNewline
	| stream |
	stream := XTPositionTrackingStream on: ('1\2\3' replaceAll: $\ with: Character lf) reading.
	stream get.
	self assert: 1 equals: stream lineNumber description: 'After 1 get'.
	stream get.
	self assert: 2 equals: stream lineNumber description: 'After 1 lf get'.
	stream get.
	self assert: 2 equals: stream lineNumber description: 'Line 2, 1 get'.
	stream get.
	self assert: 3 equals: stream lineNumber description: 'After 2 lf gets'.
	stream get.
	self assert: 3 equals: stream lineNumber description: 'Line 3, 1 get'.! !

!XTPositionTrackingStreamTest methodsFor: 'testing - line numbers' stamp: 'fbs 2/11/2013 21:06'!
testLineNumberStartsAtZero
	self assert: 0 equals: (XTPositionTrackingStream on: '' reading) lineNumber.! !


!XTPositionTrackingStreamTest methodsFor: 'testing - column numbers' stamp: 'fbs 2/11/2013 21:12'!
testColumnNumberIncrementsAfterReading
	| stream |
	stream := XTPositionTrackingStream on: '123' reading.
	stream get.
	self assert: 1 equals: stream columnNumber description: 'After 1 get'.
	stream get.
	self assert: 2 equals: stream columnNumber description: 'After 2 gets'.
	stream get.
	self assert: 3 equals: stream columnNumber description: 'After 3 gets'.! !

!XTPositionTrackingStreamTest methodsFor: 'testing - column numbers' stamp: 'fbs 2/11/2013 21:06'!
testColumnNumberStartsAtZero
	self assert: 0 equals: (XTPositionTrackingStream on: '' reading) columnNumber.! !

!XTPositionTrackingStreamTest methodsFor: 'testing - column numbers' stamp: 'fbs 2/11/2013 22:20'!
testColumnNumbersResetAfterLineFeed
	| stream |
	stream := XTPositionTrackingStream on: ('1\2\3' replaceAll: $\ with: Character lf) reading.
	stream get.
	self assert: 1 equals: stream columnNumber description: 'After 1 get'.
	stream get.
	self assert: 0 equals: stream columnNumber description: 'After lf get'.
	stream get.
	self assert: 1 equals: stream columnNumber description: 'Line 2, after 1 get'.! !


!XTPositionTrackingStreamTest methodsFor: 'testing - instance creation' stamp: 'fbs 2/18/2013 21:48'!
testPositionTrackingAddsTrackingToPlainStreams
	| s |
	s := '123' reading positionTracking.
	s get.
	self assert: 1 equals: s columnNumber.
	self assert: 1 equals: s lineNumber.! !
