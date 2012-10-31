ParserWalker subclass: #PostOrderParserWalker
	instanceVariableNames: ''
	classVariableNames: 'NotYetResolvedMarker'
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!PostOrderParserWalker commentStamp: 'fbs 10/16/2012 09:30' prior: 0!
I am a cycle-safe post-order depth first graph traversal.!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

PostOrderParserWalker class
	instanceVariableNames: ''!

!PostOrderParserWalker class methodsFor: 'private' stamp: 'fbs 9/8/2012 23:21'!
walk: aParser collecting: aUnaryBlock withCache: someParsers andMap: someAssocs
	| newCache newMap |
	(someParsers includes: aParser) ifTrue: [^ {someParsers. someAssocs}].
	
	newMap := someAssocs copy.
	newCache := someParsers copy.
	newCache add: aParser.
	aParser subParsers collect: [:p | | result |
		result := self walk: p collecting: aUnaryBlock withCache: newCache andMap: newMap.
		newCache addAll: result first.
		result second pairsDo: [:a :b |
			(newMap includes: a) ifFalse: [newMap addAll: {a. b}]]].
	newMap addAll: {aParser. aUnaryBlock value: aParser}.
	^ {newCache. newMap}.! !


!PostOrderParserWalker class methodsFor: 'class initialization' stamp: 'fbs 9/8/2012 12:35'!
initialize
	"My presence in a cache represents that (a) this node has been visited but (b) its mapped value has not been calculated (and will be after tree traversal unwinds)."
	NotYetResolvedMarker := Object new.! !


PostOrderParserWalker initialize!
