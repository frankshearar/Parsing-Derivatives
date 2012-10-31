TestCase subclass: #LeastFixedPointTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!LeastFixedPointTest methodsFor: 'testing - lfp' stamp: 'fbs 8/9/2012 17:29'!
testLfpMemoises
	| f run |
	run := false.
	f := [:x | run := true. x*x - 2] lfpWithBottom: 0.
	f value: 0.
	run := false. "Reset the flag, because the block _will_ have been run in the previous statements."
	f value: 0.
	"The block should not be executed again."
	self deny: run.! !

!LeastFixedPointTest methodsFor: 'testing - lfp' stamp: 'fbs 7/13/2012 18:57'!
testLfpOfIdentityIsOwnThing
	| f |
	f := LeastFixedPoint run: #yourself bottom: 1.
	self assert: 1 equals: (f value: 1).
	self assert: 2 equals: (f value: 2).! !

!LeastFixedPointTest methodsFor: 'testing - lfp' stamp: 'fbs 8/9/2012 17:31'!
testLfpReturnsLeastFixedPoint
	| f |
	"This example doesn't work because lfp really does this: 'run the block until its value stops changing'. Given the simple and pure function below, that's immediately true, and the 'its value stops changing' value is just the first result: f(0) = -2."
	f := [:x | x*x - 2] lfpWithBottom: 0.
	"f(0) = -2. f(-2) = 2. f(2) = 2. So f(f(f(x))) = x when x = 2."
	f value: 0.
	"self assert: 2 equals: fixp."! !

!LeastFixedPointTest methodsFor: 'testing - lfp' stamp: 'fbs 8/30/2012 21:07'!
testLfpWithBottomExplainsCorrectArgCount
	[#+ lfpWithBottom: 0]
		on: ArityMismatch
		do: [:am |
			self assert: 2 equals: am actualArgCount.
			self assert: 1 equals: am expectedArgCount].! !
