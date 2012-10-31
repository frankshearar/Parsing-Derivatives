DerivingParser subclass: #StarParser
	instanceVariableNames: 'parser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!StarParser commentStamp: 'fbs 10/16/2012 09:34' prior: 0!
I represent the repetition of some language.

For instance, ($a asParser then: $b asParser) star accepts 'ab', 'abab', 'ababab', ...!


!StarParser methodsFor: 'initialize-release' stamp: 'fbs 9/13/2012 19:37'!
parser: aParser
	parser := aParser.! !


!StarParser methodsFor: 'testing' stamp: 'fbs 9/13/2012 19:37'!
isStar
	^ true.! !


!StarParser methodsFor: 'accessing' stamp: 'fbs 9/13/2012 19:49'!
parser
	^ parser.! !

!StarParser methodsFor: 'accessing' stamp: 'fbs 9/14/2012 20:48'!
subParsers
	^ {parser}.! !


!StarParser methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:09'!
printAsDotNode: parserIntegerMap
	^ ('{1}',
	'{2} -> {3}', Character cr) format: {
		super printAsDotNode: parserIntegerMap.
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self parser) printString.
	}.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

StarParser class
	instanceVariableNames: ''!

!StarParser class methodsFor: 'instance creation' stamp: 'fbs 9/13/2012 19:36'!
repeating: aParser
	^ self new parser: aParser.! !
ingParser emptyString generate ,
		[ | s |
		s := ((1 to: count) collect: [:ignore | parser generate]) reading stitching.
		count := count + 1.
		"Return an array of parse trees from the underlying parser."
		{s rest} reading] reading stitching.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

StarParser class
	instanceVariableNames: ''!

!StarParser class methodsFor: 'instance creation' stamp: 'fbs 9/13/2012 19:36'!
repeating: aParser
	^ self new parser: aParser.! !
