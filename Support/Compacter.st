Object subclass: #Compacter
	instanceVariableNames: 'cache'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!Compacter commentStamp: 'fbs 10/16/2012 09:27' prior: 0!
I compact parsers. To that end, I walk the graph of a parser in a post-order fashion. At each step I map a parser to its compacted form. Since the walk is post-order, a composite parser (Cat, Union) will have already had its subparsers mapped.

This class is DEPRECATED. It looks like SutureCompacter (despite its dash of magic) works better.!


!Compacter methodsFor: 'private' stamp: 'fbs 10/2/2012 09:31'!
compact: aParser
	^ aParser class
		caseOf: {
			[Cat] -> [self compactCat: aParser].
			[DelayedParser] -> [self compact: aParser force].
			[DelegateParser] -> [self compactDelegate: aParser].
			[Red] -> [self compactRed: aParser]}
		otherwise: [aParser]! !

!Compacter methodsFor: 'private' stamp: 'fbs 10/3/2012 09:24'!
compact: aParser havingVisited: someParsers
	| visited |
	(someParsers includes: aParser)
		ifTrue: [aParser isDelegate
			ifTrue: [^ cache at: aParser ifAbsentPut: DelegateParser new]
			ifFalse: [^ cache at: aParser]].
	visited := someParsers copy.
	visited add: aParser.
	"Are we about to complete a cycle? If so, just move along."
	(aParser isDelegate and: [someParsers includes: aParser parser]) ifFalse: [
		aParser subParsers do: [:p | self compact: p havingVisited: visited]].
	cache at: aParser put: (self compact: aParser).! !

!Compacter methodsFor: 'private' stamp: 'fbs 10/2/2012 09:32'!
compactCat: aCat
	| c1 c2 |
"	cache at: aCat ifPresent: [:p | ^ p]."
	c1 := cache at: aCat first.
	c2 := cache at: aCat second.
	c1 whenNullable: [:singleToken |
		^ c2 reduce: [:w2 | singleToken asOrderedCollection , w2]].
	c2 whenNullable: [:singleToken |
		^ c1 reduce: [:w1 | w1 asOrderedCollection , singleToken]].
	^ ((c1 == aCat first) and: [c2 == aCat second])
		ifTrue: [aCat]
		ifFalse: [c1 then: c2]! !

!Compacter methodsFor: 'private' stamp: 'fbs 10/2/2012 19:07'!
compactDelegate: aDelegateParser
	"The compaction of a delegate parser is the compaction of its subparser. A delegate parser might not be resolvable yet, because if the delegate closes a cycle, the parser to which it should point will not have been mapped yet."
	| mappedSubparser |
	self halt.
	"This delegate completes a cycle. Its subparser hasn't been mapped yet. Mark its presence, and bail. The post-walk will resolve things."
	(cache includes: aDelegateParser parser) ifFalse: [^ DelegateParser new].
	mappedSubparser := cache at: aDelegateParser parser.
	(aDelegateParser parser == mappedSubparser reference) ifTrue: [^ aDelegateParser].
	(cache includesKey: aDelegateParser) ifTrue: [
		^ DelegateParser new parser: mappedSubparser].
	
	^ DelegateParser new.! !

!Compacter methodsFor: 'private' stamp: 'fbs 10/2/2012 09:32'!
compactRed: aRed
"	cache at: aRed ifPresent: [:p | ^ p]."
	^ cache at: aRed parser
		ifPresent: [:compactedSubparser |
			(compactedSubparser = aRed parser)
				ifTrue: ["Already compact"
					aRed]
				ifFalse: [compactedSubparser reduce: aRed reducer]]
		ifAbsent: ["Very strange!! A post-order traversal should guarantee that the subparser's already compact!!"
			Error signal: 'Tried to compact a Red but its subparser is not yet compacted'].! !

!Compacter methodsFor: 'private' stamp: 'fbs 10/3/2012 09:24'!
resolveDelegates: aParser
	PreOrderParserWalker
		walk: aParser
		doing: [:p |			
			(p isDelegate and: [p isResolved not])
				ifTrue: [| preimage |
					preimage := cache keyAtValue: p.
					p parser: (cache at: preimage parser)]].! !


!Compacter methodsFor: 'initialize-release' stamp: 'fbs 9/11/2012 09:44'!
initialize
	super initialize.
	cache := Dictionary new.! !


!Compacter methodsFor: 'evaluating' stamp: 'fbs 10/1/2012 16:49'!
value: aParser
	| visited |
	cache at: aParser ifPresent: [:compacted | ^ compacted].
	visited := IdentitySet new.
	self compact: aParser havingVisited: visited.
	self resolveDelegates: aParser.
	^ cache at: aParser.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Compacter class
	instanceVariableNames: ''!

!Compacter class methodsFor: 'instance creation' stamp: 'fbs 9/10/2012 19:53'!
value: aParser
	^ self new value: aParser.! !
