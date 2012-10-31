Object subclass: #MemoizingBlock
	instanceVariableNames: 'block cache'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!MemoizingBlock commentStamp: 'fbs 7/17/2012 13:50' prior: 0!
A MemoizingBlock is a block-like thing that remembers the results of its previous invocations. On repeated invocations, it returns this stored result rather than re-executing.!


!MemoizingBlock methodsFor: 'initialize-release' stamp: 'fbs 8/14/2012 22:36'!
initialize
	cache := Dictionary new.! !

!MemoizingBlock methodsFor: 'initialize-release' stamp: 'fbs 8/2/2012 09:26'!
run: aBlock
	block := aBlock.! !


!MemoizingBlock methodsFor: 'evaluating' stamp: 'fbs 7/17/2012 20:15'!
value: anObject
	^ self valueWithArguments: {anObject}.! !

!MemoizingBlock methodsFor: 'evaluating' stamp: 'fbs 7/17/2012 20:15'!
value: anObject value: anotherObject
	^ self valueWithArguments: {anObject. anotherObject}.! !

!MemoizingBlock methodsFor: 'evaluating' stamp: 'fbs 7/17/2012 20:24'!
value: objectA value: objectB value: objectC
	^ self valueWithArguments: {objectA. objectB. objectC}.! !

!MemoizingBlock methodsFor: 'evaluating' stamp: 'fbs 7/17/2012 20:24'!
value: objectA value: objectB value: objectC value: objectD
	^ self valueWithArguments: {objectA. objectB. objectC. objectD}.! !

!MemoizingBlock methodsFor: 'evaluating' stamp: 'fbs 7/17/2012 20:15'!
valueWithArguments: someObjects
	^ cache at: someObjects ifAbsentPut: [block valueWithArguments: someObjects].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MemoizingBlock class
	instanceVariableNames: ''!

!MemoizingBlock class methodsFor: 'as yet unclassified' stamp: 'fbs 7/17/2012 13:53'!
run: aBlock
	^ self new run: aBlock! !
