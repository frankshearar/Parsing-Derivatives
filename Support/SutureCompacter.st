Object subclass: #SutureCompacter
	instanceVariableNames: 'cache'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!SutureCompacter commentStamp: 'fbs 10/25/2012 09:19' prior: 0!
I compact parsers. At each step as I traverse the parser graph. I map a parser to its compacted form. When I compact a composite parser (Cat, Union), it will have already had its subparsers mapped (and hence compacted).!


!SutureCompacter methodsFor: 'accessing' stamp: 'fbs 10/18/2012 09:54'!
cached: aParser
	"If a delegate doesn't form part of a cycle, it does no harm to point to the delegate's reference instead of the delegate. This also makes the parser one node smaller, potentially."
	| p suture |
	suture := cache at: aParser.
	p := suture reference.
	(p notNil and: [p isDelegate and: [(self formsACycle: p) not]]) ifTrue: [
		^ cache at: p parser].
	^ suture.! !


!SutureCompacter methodsFor: 'evaluating' stamp: 'fbs 10/10/2012 19:19'!
value: aParser
	| visited |
	cache at: aParser ifPresent: [:compacted | ^ compacted].
	visited := IdentitySet new.
	self compact: aParser.
	self resolveDelegates: (cache at: aParser).
	self tieSutures: aParser.
	^ cache at: aParser.! !


!SutureCompacter methodsFor: 'initialize-release' stamp: 'fbs 10/3/2012 09:17'!
initialize
	super initialize.
	cache := Dictionary new.! !


!SutureCompacter methodsFor: 'testing' stamp: 'fbs 10/18/2012 16:53'!
formsACycle: aDelegateParser
	"If aDelegateParser is not yet resolved, treat it as though it forms a cycle."
	[aDelegateParser parser] on: UnresolvedDelegate do: [^ true].
	^ aDelegateParser isChildOf: aDelegateParser parser.! !


!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/25/2012 09:22'!
compact: aParser
	"Pre-order mark the parser as visited; post-order compact the parser (so that all its subparsers (except in a cycle) have been compacted)."
	cache at: aParser ifPresent: [:p | ^ p].
	cache at: aParser put: Suture new.
	aParser subParsers do: [:p | self compact: p].
	(cache at: aParser) reference: (aParser class
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
			[DelegateParser] -> [self compactDelegate: aParser]}
		otherwise: [aParser]).! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/25/2012 09:21'!
compactCat: aCat
	| c1 c2 ref1 ref2 |
	c1 := self cached: aCat first.
	ref1 := c1 reference.
	c2 := self cached: aCat second.
	ref2 := c2 reference.
	
	"If a Suture's reference isNil then it's a reference to a parent node (and is part of a cycle)."
	ref1 ifNotNil: [
		ref1 whenNullable: [:singleToken |
			^ ref2 reduce: [:w2 | singleToken asArray , w2]].
		ref1 isEmpty ifTrue: [^ DerivingParser empty]].
	ref2 ifNotNil: [
		ref2 whenNullable: [:singleToken |
			^ ref1 reduce: [:w1 | w1 asArray , singleToken]].
		ref2 isEmpty ifTrue: [^ DerivingParser empty]].

	^ ((ref1 == aCat first) and: [ref2 == aCat second])
		ifTrue: [aCat]
		ifFalse: [c1 then: c2]! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/18/2012 09:50'!
compactDelayed: aDelayedParser
	| c |
	c := self cached: aDelayedParser force.
	c reference == aDelayedParser force
		ifTrue: [^ aDelayedParser].
		
	^ c delay.! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/18/2012 09:50'!
compactDelegate: aDelegateParser
	"The compaction of a delegate parser is the compaction of its subparser. A delegate parser might not be resolvable yet, because if the delegate closes a cycle, the parser to which it should point will not have been mapped yet."
	| mappedSubparser |
	"This delegate completes a cycle. Its subparser hasn't been mapped yet. Mark its presence, and bail. The post-walk will resolve things."
	(cache contains: [:s | s reference = aDelegateParser parser]) ifFalse: [^ DelegateParser new].
	mappedSubparser := self cached: aDelegateParser parser.
	(aDelegateParser parser == mappedSubparser reference)
		ifTrue: [^ aDelegateParser].
	(cache includesKey: aDelegateParser) ifTrue: [
		^ DelegateParser new parser: mappedSubparser].
	
	^ DelegateParser new.! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/25/2012 09:27'!
compactRed: aRed
	| ref sub |
	sub := self cached: aRed parser.
	ref := sub reference.
	"Red -> Red => RedRed"
	(ref isRed)
		ifTrue: [^ ref reduce: aRed reducer].
	"Red -> Delegate -> Red => RedRed"
	(ref isDelegate and: [ref isResolved] and: [ref parser isRed])
		ifTrue: [^ ref parser reduce: aRed reducer].
	"Already compact?"
	(ref = aRed parser) ifTrue: [^ aRed].
	^ sub reduce: aRed reducer.! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/19/2012 09:29'!
compactUnion: aUnion
	| c1 c2 |
	c1 := self cached: aUnion left.
	c2 := self cached: aUnion right.
	
	(c2 notNil and: [c1 reference isEmpty]) ifTrue: [^ c2 reference].
	(c2 notNil and: [c2 reference isEmpty]) ifTrue: [^ c1 reference].

	^ ((c1 reference == aUnion left) and: [c2 reference == aUnion right])
		ifTrue: [aUnion]
		ifFalse: [c1 or: c2]! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/18/2012 09:52'!
resolveDelegates: aParser
	PreOrderParserWalker
		walk: aParser
		doing: [:p |
			(p isDelegate and: [p isResolved not])
				ifTrue: [ | preimage |
					preimage := cache keyAtValue: (cache values detect: [:sutr | sutr reference = p]).
					p parser: (self cached: preimage parser)]].! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/10/2012 19:11'!
tieSutures: aParser
	| sutures references |
	sutures := cache values.
	references := sutures collect: #reference.
	"Put the pointed-to objects in the cache rather than the sutures."
	sutures do: [:s | cache at: s put: s reference].
	"Magically make everything that points to a Suture point to the Suture's reference, tying the cyclic knots."
	sutures elementsForwardIdentityTo: references.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SutureCompacter class
	instanceVariableNames: ''!

!SutureCompacter class methodsFor: 'instance creation' stamp: 'fbs 10/3/2012 09:17'!
value: aParser
	^ self new value: aParser.! !
