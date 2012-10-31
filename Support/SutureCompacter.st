Object subclass: #SutureCompacter
	instanceVariableNames: 'cache'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!SutureCompacter commentStamp: '<historical>' prior: 0!
I compact parsers. To that end, I walk the graph of a parser in a post-order fashion. At each step I map a parser to its compacted form. Since the walk is post-order, a composite parser (Cat, Union) will have already had its subparsers mapped.!



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



!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/12/2012 18:45'!
compact: aParser
	"Pre-order mark the parser as visited; post-order compact the parser (so that all its subparsers (except in a cycle) have been compacted)."
	cache at: aParser ifPresent: [:p | ^ p].
	cache at: aParser put: Suture new.
	aParser subParsers do: [:p | self compact: p].
	(cache at: aParser) reference: (aParser class
		caseOf: {
			[Cat] -> [self compactCat: aParser].
			[DelayedParser] -> [self compactDelayed: aParser].
			[DelegateParser] -> [self compactDelegate: aParser].
			[Red] -> [self compactRed: aParser]}
		otherwise: [aParser]).! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/11/2012 19:26'!
compactCat: aCat
	| c1 c2 |
	c1 := cache at: aCat first.
	c2 := cache at: aCat second.
	c1 whenNullable: [:singleToken |
		^ c2 reduce: [:w2 | singleToken asOrderedCollection , w2]].
	c2 whenNullable: [:singleToken |
		^ c1 reduce: [:w1 | w1 asOrderedCollection , singleToken]].
	^ ((c1 reference == aCat first) and: [c2 reference == aCat second])
		ifTrue: [aCat]
		ifFalse: [c1 then: c2]! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/12/2012 18:50'!
compactDelayed: aDelayedParser
	| c |
	c := cache at: aDelayedParser force.
	c reference == aDelayedParser force
		ifTrue: [^ aDelayedParser].
		
	^ c delay.! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/11/2012 09:47'!
compactDelegate: aDelegateParser
	"The compaction of a delegate parser is the compaction of its subparser. A delegate parser might not be resolvable yet, because if the delegate closes a cycle, the parser to which it should point will not have been mapped yet."
	| mappedSubparser |
	"This delegate completes a cycle. Its subparser hasn't been mapped yet. Mark its presence, and bail. The post-walk will resolve things."
	(cache contains: [:s | s reference = aDelegateParser parser]) ifFalse: [^ DelegateParser new].
	mappedSubparser := cache at: aDelegateParser parser.
	(aDelegateParser parser == mappedSubparser reference)
		ifTrue: [^ aDelegateParser].
	(cache includesKey: aDelegateParser) ifTrue: [
		^ DelegateParser new parser: mappedSubparser].
	
	^ DelegateParser new.! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/11/2012 09:20'!
compactRed: aRed
	| sub |
	sub := (cache at: aRed parser) reference.
	(sub = aRed parser)
		ifTrue: [^ aRed "Already compact"].
	^ sub reduce: aRed reducer.! !

!SutureCompacter methodsFor: 'private' stamp: 'fbs 10/10/2012 19:28'!
resolveDelegates: aParser
	PreOrderParserWalker
		walk: aParser
		doing: [:suture | | p |
			p := suture reference.
			(p isDelegate and: [p isResolved not])
				ifTrue: [| preimage |
					preimage := cache keyAtValue: (cache values detect: [:sutr | sutr reference = p]).
					p parser: (cache at: preimage parser)]].! !

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
 sub |
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
