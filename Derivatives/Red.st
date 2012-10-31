DerivingParser subclass: #Red
	instanceVariableNames: 'parser reducer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!Red commentStamp: 'fbs 8/30/2012 20:46' prior: 0!
I represent a "reducing" parser: a parser that applies a certain function to every element of my subparser's partial parse trees.

I am the parser that allows you to express your semantic actions (such as building ASTs).!


!Red methodsFor: 'initialize-release' stamp: 'fbs 8/30/2012 16:45'!
parser: aParser reduceWith: aUnaryBlock
	parser := aParser.
	reducer := aUnaryBlock.! !


!Red methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:45'!
isRed
	^ true.! !


!Red methodsFor: 'accessing' stamp: 'fbs 8/30/2012 22:09'!
parser
	^ parser.! !

!Red methodsFor: 'accessing' stamp: 'fbs 8/30/2012 20:40'!
reducer
	^ reducer.! !

!Red methodsFor: 'accessing' stamp: 'fbs 9/5/2012 19:35'!
subParsers
	^ {parser}.! !


!Red methodsFor: 'parsing' stamp: 'fbs 10/25/2012 09:22'!
reduce: aUnaryBlock
	^ Red parser: self parser reduceWith: (aUnaryBlock compose: self reducer)! !


!Red methodsFor: 'printing' stamp: 'fbs 10/10/2012 09:45'!
dotLabel
	^ '{1} {2}' format: {self className. [self reducer decompile printString] on: Error do: ['??']}! !

!Red methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:14'!
printAsDotNode: parserIntegerMap
	^ ('{1}',
	'{2} -> {3}', Character cr) format: {
		super printAsDotNode: parserIntegerMap.
		(parserIntegerMap at: self) printString.
		(parserIntegerMap at: self parser) printString.
	}.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Red class
	instanceVariableNames: ''!

!Red class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 16:45'!
parser: aParser reduceWith: aUnaryBlock
	^ self new parser: aParser reduceWith: aUnaryBlock.! !
8/30/2012 16:45'!
parser: aParser reduceWith: aUnaryBlock
	^ self new parser: aParser reduceWith: aUnaryBlock.! !
