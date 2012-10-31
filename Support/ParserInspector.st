Inspector subclass: #ParserInspector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!ParserInspector commentStamp: 'fbs 10/9/2012 09:26' prior: 0!
To a normal Inspector I add the graphical rendering of that graph.!


!ParserInspector methodsFor: 'accessing' stamp: 'fbs 10/9/2012 09:35'!
fieldList
	^ self baseFieldList , {'<graph>'}! !


!ParserInspector methodsFor: 'selecting' stamp: 'fbs 10/9/2012 09:37'!
selection
	^ selectionIndex < self fieldList size
		ifTrue: [super selection]
		ifFalse: [self renderGraph: object]! !


!ParserInspector methodsFor: 'private' stamp: 'fbs 10/10/2012 09:22'!
renderGraph: aParser
	^ [aParser printAsDigraph]
		on: Error do: ['Something went wrong rendering this graph. Evaluate ''self printAsDigraph'' to debug it.'].! !
