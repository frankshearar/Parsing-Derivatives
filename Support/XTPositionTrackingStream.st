XTReadStream subclass: #XTPositionTrackingStream
	instanceVariableNames: 'columnNumber lineNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!XTPositionTrackingStream commentStamp: 'fbs 2/11/2013 21:24' prior: 0!
I keep track of column/line numbers. Initially these are set to 0. After reading the first character I am at position 1/1 - the first character of the first line. Every time I read a linefeed character my line number increments and character number resets to zero.!


!XTPositionTrackingStream methodsFor: 'accessing' stamp: 'fbs 2/11/2013 21:13'!
columnNumber
	^ columnNumber.! !

!XTPositionTrackingStream methodsFor: 'accessing' stamp: 'fbs 2/11/2013 21:19'!
lineNumber
	^ lineNumber.! !

!XTPositionTrackingStream methodsFor: 'accessing' stamp: 'fbs 2/11/2013 22:21'!
read: anInteger into: aSequenceableCollection at: startIndex
	| read lineCounts |
	read := source read: anInteger into: aSequenceableCollection at: startIndex.
	columnNumber := columnNumber + read.
	lineCounts := (aSequenceableCollection select: [:o | o == Character lf]) size.
	lineCounts > 0 ifTrue: [
		lineNumber := lineNumber + lineCounts.
		columnNumber := 0].
	lineNumber == 0 ifTrue: [lineNumber := 1].
	^ read.! !


!XTPositionTrackingStream methodsFor: 'initialize-release' stamp: 'fbs 2/11/2013 21:11'!
contentsSpecies
	^ source contentsSpecies.! !

!XTPositionTrackingStream methodsFor: 'initialize-release' stamp: 'fbs 2/11/2013 21:19'!
initialize
	super initialize.
	columnNumber := 0.
	lineNumber := 0.! !


!XTPositionTrackingStream methodsFor: 'parsing' stamp: 'fbs 4/12/2013 22:12'!
parsing: aParser
	"Return an XTReadStream that takes a parser aParser, consumes a character C, calculates the derivative of aParser with respect to C, and produces a new parser. Throws a ParseError if it unexpectedly derives Empty."
	| d derivative parse |
	derivative := aParser.
	d := DerivingParser deriverBlock.
	^ (self transforming: [:input :output |
		parse := [:next :p | | drv |
			drv := ParserCompacter value: (d value: next value: p).
			drv isEmptyParser
				ifTrue: [ParseError signalLine: input lineNumber column: input columnNumber error: drv error]
				ifFalse: [drv]].
		derivative := parse value: input get value: derivative.
		output write: derivative])
			contentsSpecies: Array;
			yourself.! !
