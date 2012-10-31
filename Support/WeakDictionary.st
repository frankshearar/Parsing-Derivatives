WeakValueDictionary subclass: #WeakDictionary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!WeakDictionary commentStamp: 'fbs 7/20/2012 22:17' prior: 0!
I am like a WeakValueDictionary, but I regard nil values as meaning "I don't have this thing".

That means that if a parser p is garbage collected, myself includesKey: p will return false. Thus, I look much like a normal Dictionary to my users.!


!WeakDictionary methodsFor: 'accessing' stamp: 'fbs 7/20/2012 19:00'!
at: key
	^ (super at: key)
		ifNil: [self errorKeyNotFound: key]! !


!WeakDictionary methodsFor: 'testing' stamp: 'fbs 7/24/2012 11:54'!
includesKey: anObject
	^ [(super includesKey: anObject) and: [(self at: anObject) notNil]]
		on: KeyNotFound do: [false]! !
