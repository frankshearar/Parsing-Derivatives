Object subclass: #DerivingParser
	instanceVariableNames: ''
	classVariableNames: 'DeriverBlock EmptyBlock EmptyParser EmptyStringParser NullableBlock ParseNullBlock'
	poolDictionaries: ''
	category: 'Parsing-Derivatives'!
!DerivingParser commentStamp: 'fbs 2/21/2013 08:40' prior: 0!
My subclasses implement parsers that represent the _derivative_ of a context free language. Each time you "derive" a new parser with respect to a character you get a parser that
* builds a partial parse tree of the input thus far (the sequence of characters used to derive the current parser), and
* is a parser for the remaining input.

(Of course, you may parse a stream of arbitrary objects, not just characters.)

As a result, my subclasses represent non-blocking parsers: they may consume partial input (say from a socket), storing partial parses until such time as the input is drained.

To put it another way, derivation calculates the parser's continuation.!


!DerivingParser methodsFor: 'accessing' stamp: 'fbs 9/5/2012 19:34'!
subParsers
	"Most parsers don't have subparsers."
	^ #().! !


!DerivingParser methodsFor: 'delaying' stamp: 'fbs 8/30/2012 21:29'!
delay
	^ [self] asParser.! !

!DerivingParser methodsFor: 'delaying' stamp: 'fbs 9/5/2012 09:49'!
force
	^ self.! !


!DerivingParser methodsFor: 'deriving' stamp: 'fbs 9/28/2012 09:52'!
d: anObject
	^ DeriverBlock value: anObject value: self.! !


!DerivingParser methodsFor: 'evaluating' stamp: 'fbs 9/20/2012 17:13'!
whenNullable: aUnaryBlock
	"If this parser's parse forest contains exactly one tree, pass in that tree to aUnaryBlock."
	| trees |
	trees := self parseNull.
	(trees size = 1) ifTrue: [aUnaryBlock value: trees anyOne].! !


!DerivingParser methodsFor: 'generating' stamp: 'fbs 10/25/2012 18:42'!
generate
	"Many parsers don't parse anything."
	^ #() reading.! !


!DerivingParser methodsFor: 'inspecting' stamp: 'fbs 10/9/2012 09:33'!
inspectorClass
	^ ParserInspector! !


!DerivingParser methodsFor: 'parsing' stamp: 'fbs 2/15/2013 14:49'!
or: aParser
	aParser isEmptyParser ifTrue: [^ self].
	^ Union left: self delay right: aParser delay.! !

!DerivingParser methodsFor: 'parsing' stamp: 'fbs 9/21/2012 18:50'!
parseNull
	"Can I parse the empty string?"
	^ ParseNullBlock value: self.! !

!DerivingParser methodsFor: 'parsing' stamp: 'fbs 10/25/2012 09:22'!
reduce: aUnaryBlock
	^ Red parser: self reduceWith: aUnaryBlock! !

!DerivingParser methodsFor: 'parsing' stamp: 'fbs 9/13/2012 19:36'!
star
	^ StarParser repeating: self.! !

!DerivingParser methodsFor: 'parsing' stamp: 'fbs 2/18/2013 08:30'!
then: aParser
	aParser isEmptyParser ifTrue: [^ aParser].
	^ Cat with: self delay with: aParser delay.! !


!DerivingParser methodsFor: 'printing' stamp: 'fbs 9/6/2012 09:16'!
dotLabel
	^ self className! !

!DerivingParser methodsFor: 'printing' stamp: 'fbs 9/21/2012 09:27'!
printAsDigraph
	| c intmap i |
	"Post-order makes for nicer graphs."
	i := 0.
	intmap := Dictionary new.
	PreOrderParserWalker walk: self collecting: [:p | intmap at: p put: i. i := i + 1].
	c := (PostOrderParserWalker walk: self collecting: [:p | p printAsDotNode: intmap]) asOrderedCollection.
	c reverseInPlace.
	c addAllFirst: {'digraph {', Character cr. 'ordering=out', Character cr}.
	
	c addLast: ('}', Character cr).
	^ c reduce: #,.! !

!DerivingParser methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:09'!
printAsDotNode: parserIntegerMap
	"parserIntegerMap maps parsers to integers. We do this manually because #identityHash is not a reliable way (by design) of distinguishing between two objects."
	^ self printNode: parserIntegerMap.! !

!DerivingParser methodsFor: 'printing' stamp: 'fbs 9/14/2012 21:20'!
printNode: parserIntegerMap
	^ ('{1} [label="{2} ({1})"]' format: {(parserIntegerMap at: self) printString. self dotLabel}),
		Character cr.! !


!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:35'!
isCat
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 10/11/2012 19:12'!
isChildOf: aParser
	aParser subParsers do:
		[:child | PostOrderParserWalker
		walk: child
			doing: [:p | p = self ifTrue: [^ true]]].
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 21:14'!
isDelayed
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 9/11/2012 19:55'!
isDelegate
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 9/21/2012 09:48'!
isEmpty
	"Is the language I define I the empty set?"
	^ EmptyBlock value: self.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 2/15/2013 09:29'!
isEmptyParser
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 15:59'!
isEps
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 9/4/2012 09:04'!
isEpsStar
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:28'!
isLazy
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 15:56'!
isLiteral
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 9/21/2012 18:47'!
isNullable
	"Can I parse the empty string?"
	^ NullableBlock value: self.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:43'!
isRed
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 9/13/2012 19:35'!
isStar
	^ false.! !

!DerivingParser methodsFor: 'testing' stamp: 'fbs 8/30/2012 16:48'!
isUnion
	^ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DerivingParser class
	instanceVariableNames: ''!

!DerivingParser class methodsFor: 'class initialization' stamp: 'fbs 2/12/2013 16:22'!
initialize
	EmptyParser := Empty new.
	EmptyStringParser := EmptyString new.
	self flushCaches.! !


!DerivingParser class methodsFor: 'instance creation' stamp: 'fbs 8/30/2012 16:00'!
empty
	^ EmptyParser! !

!DerivingParser class methodsFor: 'instance creation' stamp: 'fbs 2/14/2013 20:51'!
emptyExpected: expectedObject actual: actualObject
	^ Empty expected: expectedObject actual: actualObject.! !

!DerivingParser class methodsFor: 'instance creation' stamp: 'fbs 9/4/2012 08:56'!
emptyString
	^ EmptyStringParser! !


!DerivingParser class methodsFor: 'private' stamp: 'fbs 2/12/2013 17:23'!
deriverBlock
	| d |
	d := nil.
	d := [:o :p |
		p class caseOf: {
			[Empty] -> [p].
			[EmptyString] -> [DerivingParser emptyExpected: #Nothing actual: o].
			[EpsStar] -> [DerivingParser emptyExpected: #EndOfStream actual: o].
			[Literal] -> [(o = p token)
							ifTrue: [EpsStar treeSet: {o}]
							ifFalse: [DerivingParser emptyExpected: p token actual: o]].
			[LiteralSet] -> [(p tokens includes: o)
				ifTrue: [EpsStar treeSet: {o}]
				ifFalse: [DerivingParser emptyExpected: p tokens actual: o]].
			[StarParser] -> [(d value: o value: p parser) then: p].
			[Union] -> [[d value: o value: p left] asParser
				or: [d value: o value: p right] asParser].
			[Cat] -> [p first isNullable
				ifTrue: [[[EpsStar treeSet: p first parseNull] asParser
							then: [d value: o value: p second] asParser] asParser
						or: [[d value: o value: p first] asParser
							then: p second] asParser]
				ifFalse: [[(d value: o value: p first)] asParser then: p second]].
			[Red] -> [(d value: o value: p parser) reduce: p reducer].
			[DelayedParser] -> [d value: o value: p force].
			[DelegateParser] -> [DelegateParser new parser: (d value: o value: p parser)]}
		otherwise: [Error signal: 'derivative not defined for ', p className]] memoized.
	^ d! !

!DerivingParser class methodsFor: 'private' stamp: 'fbs 10/25/2012 09:38'!
flushCaches
	DeriverBlock := self deriverBlock.
	EmptyBlock := self isEmptyBlock.
	NullableBlock := self isNullableBlock.
	ParseNullBlock := self parseNullBlock.! !

!DerivingParser class methodsFor: 'private' stamp: 'fbs 2/8/2013 08:39'!
isEmptyBlock
	| e |
	e := nil.
	e := [:p |
		p class caseOf: {
			[Empty] -> [true].
			[EmptyString] -> [false].
			[EpsStar] -> [false].
			[Literal] -> [false].
			[LiteralSet] -> [false].
			[StarParser] -> [false].
			[Union] -> [(e value: p left) and: [e value: p right]].
			[Cat] -> [(e value: p first) or: [e value: p second]].
			[Red] -> [e value: p parser].
			[DelayedParser] -> [e value: p force].
			[DelegateParser] -> [p isResolved ifTrue: [e value: p parser] ifFalse: ["We can't say!!" false]]}
			otherwise: [Error signal: 'isEmpty not defined for ', p className]] lfpWithBottom: false.
	^ e.! !

!DerivingParser class methodsFor: 'private' stamp: 'fbs 2/8/2013 08:39'!
isNullableBlock
	| n |
	n := nil.
	n := [:p |
		p class caseOf: {
			[Empty] -> [false].
			[EmptyString] -> [true].
			[EpsStar] -> [true].
			[Literal] -> [false].
			[LiteralSet] -> [false].
			[Union] -> [(n value: p left) or: [n value: p right]].
			[Cat] -> [(n value: p first) and: [n value: p second]].
			[Red] -> [n value: p parser].
			[StarParser] -> [(n value: p parser) or: [p parser isEmpty]].
			[DelayedParser] -> [n value: p force].
			[DelegateParser] -> [n value: p parser]}
		otherwise: [Error signal: 'isNullable not defined for ', p className]] lfpWithBottom: false.
	^ n.! !

!DerivingParser class methodsFor: 'private' stamp: 'fbs 2/8/2013 08:39'!
parseNullBlock
	| pn |
	pn := nil.
	pn := [:p |
		p class caseOf: {
			[Empty] -> [Set new].
			[EmptyString] -> [Set newFrom: {#()}].
			[EpsStar] -> [p treeSet].
			[Literal] -> [Set new].
			[LiteralSet] -> [Set new].
			[Union] -> [(pn value: p left) union: (pn value: p right)].
			[Cat] -> [ | concat |
				concat := [:t1 :t2 | t1 asArray , t2 asArray].
				(pn value: p first)
					cartesianProduct: concat
					with: (pn value: p second)].
			[Red] -> [(pn value: p parser) collect: p reducer].
			[StarParser] -> [Set newFrom: #(#())].
			[DelayedParser] -> [pn value: p force].
			[DelegateParser] -> [p isResolved ifFalse: [UnresolvedDelegate accessing: p]. pn value: p parser]}
		otherwise: [Error signal: 'parseNull not defined for ', p className]] lfpWithBottom: Set new.
	^ pn.! !


DerivingParser initialize!
