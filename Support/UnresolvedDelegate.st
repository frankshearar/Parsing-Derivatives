Error subclass: #UnresolvedDelegate
	instanceVariableNames: 'parser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!UnresolvedDelegate commentStamp: 'fbs 10/10/2012 19:06' prior: 0!
I signal that you've tried to access the parser to which a DelegateParser points, only you haven't told the parser which parser that is.!


!UnresolvedDelegate methodsFor: 'accessing' stamp: 'fbs 10/10/2012 19:08'!
parser
	^ parser.! !

!UnresolvedDelegate methodsFor: 'accessing' stamp: 'fbs 10/10/2012 19:08'!
parser: aDelegateParser
	parser := aDelegateParser.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnresolvedDelegate class
	instanceVariableNames: ''!

!UnresolvedDelegate class methodsFor: 'instance creation' stamp: 'fbs 10/10/2012 19:08'!
accessing: aDelegateParser
	^ (self new parser: aDelegateParser) signal.! !
