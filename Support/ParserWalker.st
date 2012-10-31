Object subclass: #ParserWalker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!ParserWalker commentStamp: 'fbs 10/11/2012 09:26' prior: 0!
I am a cycle-safe walker of a graph structure. I can perform collection-like operations on the nodes of a graph: doing and collecting.

My children implement different ways of walking a graph.!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ParserWalker class
	instanceVariableNames: ''!

!ParserWalker class methodsFor: 'enumerating' stamp: 'fbs 9/12/2012 09:31'!
walk: aParser collecting: aUnaryBlock
	"Walk all parsers reachable from aParser, executing aUnaryBlock on each parser and returning the collection of results (in traversal order). By default ParserWalker will use a cycle-safe pre-order traversal. Invoke #walk:collecting: on subclasses for other traversals."
	^ ((self == ParserWalker ifTrue: [PreOrderParserWalker] ifFalse: [self])
		walk: aParser
		collectingMap: aUnaryBlock)
			pairsCollect: [:a :b | b].! !

!ParserWalker class methodsFor: 'enumerating' stamp: 'fbs 9/8/2012 23:15'!
walk: aParser collectingMap: aUnaryBlock
	| cache mappedValues |
	"mappedValues contains a plist: {key1. value1. key2. value2. ...}. We don't use a Dictionary because we might care about the order in which we walk the graph, and hence the order of mapped values. cache contains all visited parsers, to render the traversal cycle-safe."
	cache := IdentitySet new.
	mappedValues := OrderedCollection new.
	^ (self walk: aParser collecting: aUnaryBlock withCache: cache andMap: mappedValues) second.! !

!ParserWalker class methodsFor: 'enumerating' stamp: 'fbs 9/12/2012 09:31'!
walk: aParser doing: aUnaryBlock
	"Walk all parsers reachable from aParser, executing aUnaryBlock on each parser. By default ParserWalker will use a cycle-safe pre-order traversal. Invoke #walk:doing: on subclasses for other traversals."
	((self == ParserWalker ifTrue: [PreOrderParserWalker] ifFalse: [self])
		walk: aParser
		collectingMap: aUnaryBlock)
			pairsCollect: [:a :b | b].
	^ self.! !


!ParserWalker class methodsFor: 'private' stamp: 'fbs 9/8/2012 21:43'!
walk: aParser collecting: aUnaryBlock withCache: someParsers andMap: someAssocs
	self subclassResponsibility.! !
