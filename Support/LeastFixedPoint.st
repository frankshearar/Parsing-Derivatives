Object subclass: #LeastFixedPoint
	instanceVariableNames: 'changed running visited cache bottom block'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support'!
!LeastFixedPoint commentStamp: 'fbs 7/13/2012 18:48' prior: 0!
I calculate the least fixed point of some calculation. That is, given a calculation f and an initial value x, I repeatedly calculate x := f value: x until x == f value x.

My implementation comes from a translation of Matt Might's derp library, from his "YACC is Dead" work.!


!LeastFixedPoint methodsFor: 'initialize-release' stamp: 'fbs 7/20/2012 19:00'!
run: aBlock bottom: anObject
	self initialize.
	cache := WeakDictionary new.
	changed := DelimitedDynamicVariable default: #errorChanged.
	running := DelimitedDynamicVariable default: false.
	visited := DelimitedDynamicVariable default: #errorVisited.
	block := aBlock.
	bottom := anObject.! !


!LeastFixedPoint methodsFor: 'evaluating' stamp: 'fbs 8/7/2012 07:56'!
value: anObject
	| cached cachedValue run |
	cached := cache includesKey: anObject.
	cachedValue := cache at: anObject ifAbsent: [bottom].
	run := running dref.
	
	(cached and: [run not]) ifTrue: [^ cachedValue].
	(run and: [visited dref includesKey: anObject]) ifTrue:
		[^ cached ifTrue: [cachedValue] ifFalse: [bottom]].
	
	run ifTrue: [ | newVal |
		visited dref at: anObject put: true.
		newVal := block value: anObject.
		newVal ~= cachedValue ifTrue: [
			changed dset: true.
			cache at: anObject put: newVal].
		^ newVal].
	
	"Technically this condition's not necessary. It causes all the cases to be non-overlapping."
	(cached not and: [run not]) ifTrue: [
		changed, running, visited dlet: {true. true. WeakDictionary new} in: [ | v |
			v := anObject.
			[changed dref] whileTrue: [
				changed dset: false.
				visited dset: WeakDictionary new.
				v := self value: anObject].
			^ v]].
	
	Error signal: 'It''s impossible to reach here.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

LeastFixedPoint class
	instanceVariableNames: ''!

!LeastFixedPoint class methodsFor: 'instance creation' stamp: 'fbs 7/13/2012 09:45'!
run: aBlock bottom: anObject
	^ self new run: aBlock bottom: anObject.! !
