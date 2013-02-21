Object subclass: #ParserCompacter
	instanceVariableNames: 'cache'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!ParserCompacter commentStamp: '<historical>' prior: 0!
I compact parsers. At each step as I traverse the parser graph. I map a parser to its compacted form. When I compact a composite parser (Cat, Union), it will have already had its subparsers mapped (and hence compacted).!


!ParserCompacter methodsFor: 'accessing' stamp: 'fbs 2/8/2013 08:29'!
cached: aParser
	"If a delegate doesn't form part of a cycle, it does no harm to point to the delegate's reference instead of the delegate. This also makes the parser one node smaller, potentially."
	| p |
	p := cache at: aParser.
	(p notNil and: [p isDelegate and: [(self formsACycle: p) not]]) ifTrue: [
		^ self cached: p parser].
	^ p.! !


!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/15/2013 14:15'!
compact: aParser
	"Pre-order mark the parser as visited (by storing the parser in the cache); post-order compact the parser (so that all its subparsers (except in a cycle) have been compacted)."
	cache at: aParser ifPresent: [:p | ^ p].
	cache at: aParser put: aParser.
	(aParser subParsers reject: [:p | cache includesKey: p]) do: [:p | self compact: p].
	cache at: aParser put: (aParser class
		caseOf: {
			"Optimise case testing by putting the most common cases first"
			[Empty] -> [aParser].
			[EmptyString] -> [aParser].
			[EpsStar] -> [aParser].
			[Literal] -> [aParser].
			[Cat] -> [self compactCat: aParser].
			[Union] -> [self compactUnion: aParser].
			[Red] -> [self compactRed: aParser].
			[DelayedParser] -> [self compactDelayed: aParser].
			[DelegateParser] -> [self compactDelegate: aParser].
			[StarParser] -> [self compactStar: aParser]}
		otherwise: [aParser]).! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/15/2013 14:31'!
compactCat: aCat
	| c1 c2 |
	c1 := self cached: aCat first.
	c2 := self cached: aCat second.
	
	c1 whenNullable: [:singleToken |
		^ c2 reduce: [:w2 | singleToken asArray , w2 asArray]].
	c1 isEmpty ifTrue: [^ DerivingParser empty].
	
	c2 whenNullable: [:singleToken |
		^ c1 reduce: [:w1 | w1 asArray , singleToken asArray]].
	c2 isEmpty ifTrue: [^ DerivingParser empty].

	^ ((c1 == aCat first) and: [c2 == aCat second])
		ifTrue: [aCat]
		ifFalse: [c1 then: c2]! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/8/2013 08:34'!
compactDelayed: aDelayedParser
	| c |
	c := self cached: aDelayedParser force.
	c == aDelayedParser force
		ifTrue: [^ aDelayedParser].
		
	^ c delay.! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/8/2013 08:45'!
compactDelegate: aDelegateParser
	"The compaction of a delegate parser is the compaction of its subparser. A delegate parser might not be resolvable yet, because if the delegate closes a cycle, the parser to which it should point will not have been mapped yet."
	| mappedSubparser |
	"This delegate completes a cycle. Its subparser hasn't been mapped yet. Mark its presence, and bail. The post-walk will resolve things."
	(cache contains: [:p | p = aDelegateParser parser]) ifFalse: [^ DelegateParser new].
	mappedSubparser := self cached: aDelegateParser parser.
	(aDelegateParser parser == mappedSubparser)
		ifTrue: [^ aDelegateParser].
	(cache includesKey: aDelegateParser) ifTrue: [
		^ DelegateParser new parser: mappedSubparser].
	
	^ DelegateParser new.! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/15/2013 14:33'!
compactRed: aRed
	| sub |
	sub := self cached: aRed parser.
	"Red -> Empty => Empty"
	(sub isEmpty)
		ifTrue: [^ sub].
	"Red -> Red => RedRed"
	(sub isRed)
		ifTrue: [^ sub reduce: aRed reducer].
	"Red -> Delegate -> Red => RedRed"
	(sub isDelegate and: [sub isResolved] and: [sub parser isRed])
		ifTrue: [^ sub parser reduce: aRed reducer].
	"Already compact?"
	(sub == aRed parser) ifTrue: [^ aRed].
	^ sub reduce: aRed reducer.! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/15/2013 14:17'!
compactStar: aStar
	| sub |
	sub := self cached: aStar parser.
	sub isEmpty ifTrue: [^ sub].
	^ aStar! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/14/2013 21:48'!
compactUnion: aUnion
	| c1 c2 |
	c1 := self cached: aUnion left.
	c2 := self cached: aUnion right.
	(c1 isEmpty and: [c2 isEmpty]) ifTrue: [
		^ DerivingParser
			emptyExpected: (c1 expected asArray , c2 expected asArray)
			actual: c2 actual].
	c1 isEmpty ifTrue: [^ c2].
	c2 isEmpty ifTrue: [^ c1].

	^ ((c1 == aUnion left) and: [c2 == aUnion right])
		ifTrue: [aUnion]
		ifFalse: [c1 or: c2]! !

!ParserCompacter methodsFor: 'private' stamp: 'fbs 2/8/2013 17:20'!
resolveDelegates: aParser
	"During compaction we sometimes introduce cycle-closing delegates. After compaction, we need to go back and fix these delegates."
	PreOrderParserWalker
		walk: aParser
		doing: [:p |
			(p isDelegate and: [p isResolved not])
				ifTrue: [ | preimage |
					preimage := cache keyAtValue: p.
					p parser: (self cached: preimage parser)]].! !


!ParserCompacter methodsFor: 'testing' stamp: 'fbs 2/8/2013 08:28'!
formsACycle: aDelegateParser
	"If aDelegateParser is not yet resolved, treat it as though it forms a cycle."
	aDelegateParser isResolved ifFalse: [^ true].
	^ aDelegateParser isChildOf: aDelegateParser parser.! !


!ParserCompacter methodsFor: 'initialize-release' stamp: 'fbs 2/8/2013 08:28'!
initialize
	super initialize.
	cache := Dictionary new.! !


!ParserCompacter methodsFor: 'evaluating' stamp: 'fbs 2/8/2013 08:37'!
value: aParser
	| visited |
	cache at: aParser ifPresent: [:compacted | ^ compacted].
	visited := IdentitySet new.
	self compact: aParser.
	self resolveDelegates: (cache at: aParser).
	^ cache at: aParser.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ParserCompacter class
	instanceVariableNames: ''!

!ParserCompacter class methodsFor: 'instance creation' stamp: 'fbs 2/8/2013 08:28'!
value: aParser
	^ self new value: aParser.! !
