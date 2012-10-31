EmptyString subclass: #EpsStar
	instanceVariableNames: 'treeSet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!EpsStar commentStamp: 'fbs 8/30/2012 16:10' prior: 0!
I represent an intermediate state in the parsing of some input. treeSet forms the collective seed of a set of parse trees.!


!EpsStar methodsFor: 'initialize-release' stamp: 'fbs 8/30/2012 15:58'!
treeSet: aCollection
	treeSet := aCollection.! !


!EpsStar methodsFor: 'testing' stamp: 'fbs 9/4/2012 09:05'!
isEps
	"This is rubbish. We should actually have the eps and eps* be subclasses of a common ancestor."
	self flag: #todo.
	^ false.! !

!EpsStar methodsFor: 'testing' stamp: 'fbs 9/4/2012 09:04'!
isEpsStar
	^ true.! !


!EpsStar methodsFor: 'accessing' stamp: 'fbs 8/30/2012 15:59'!
treeSet
	^ treeSet! !


!EpsStar methodsFor: 'printing' stamp: 'fbs 10/24/2012 09:39'!
dotLabel
	^ 'eps*'.! !

!EpsStar methodsFor: 'printing' stamp: 'fbs 10/24/2012 09:38'!
printAsDotNode: parserIntegerMap
	^ ('{1} [label="{2} ({3}) ({4})"]' format: {
		(parserIntegerMap at: self) printString.
		self dotLabel.
		self treeSet printString.
		(parserIntegerMap at: self) printString}),
	Character cr.! !


!EpsStar methodsFor: 'generating' stamp: 'fbs 10/29/2012 12:05'!
generate
	"An eps* node represents a partial parse: it's an internal construct and should never appear in an initial grammar."
	^ #() reading.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

EpsStar class
	instanceVariableNames: ''!

!EpsStar class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 15:58'!
treeSet: aCollection
	^ self new treeSet: aCollection asSet.! !
