ParserWalker subclass: #PreOrderParserWalker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!PreOrderParserWalker commentStamp: 'fbs 10/16/2012 09:30' prior: 0!
I am a cycle-safe pre-order depth first graph traversal.!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

PreOrderParserWalker class
	instanceVariableNames: ''!

!PreOrderParserWalker class methodsFor: 'private' stamp: 'fbs 9/8/2012 23:18'!
walk: aParser collecting: aUnaryBlock withCache: someParsers andMap: someAssocs
	| newCache newMap |
	(someParsers includes: aParser) ifTrue: [^ {someParsers. someAssocs}].
	
	newMap := someAssocs copy.
	newCache := someParsers copy.
	newCache add: aParser.
	newMap addAll: {aParser. aUnaryBlock value: aParser}.
	aParser subParsers collect: [:p | | result |
		result := self walk: p collecting: aUnaryBlock withCache: newCache andMap: newMap.
		newCache addAll: result first.
		result second pairsDo: [:a :b |
			(newMap includes: a) ifFalse: [newMap addAll: {a. b}]]].
	^ {newCache. newMap}.! !
