
!XTReadStream methodsFor: '*Parsing-Derivatives' stamp: 'fbs 10/31/2012 13:26'!
interleave: aXTReadStream
	"Interleave my values with those of aXTReadStream. If either of us are exhausted, read from the other. If we are both exhausted, signal so with an Incomplete."
	| readFromLeft |
	readFromLeft := true.
	^ self transforming: [:input :output |
		[output put: (readFromLeft ifTrue: [input] ifFalse: [aXTReadStream]) get.
		readFromLeft := readFromLeft not]
			on: Incomplete do: [	readFromLeft := readFromLeft not.
					output put: (readFromLeft ifTrue: [input] ifFalse: [aXTReadStream]) get]].! !
