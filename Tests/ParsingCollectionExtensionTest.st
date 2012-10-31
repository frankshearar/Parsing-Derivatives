TestCase subclass: #ParsingCollectionExtensionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parsing-Derivatives-Support-Tests'!

!ParsingCollectionExtensionTest methodsFor: 'testing' stamp: 'fbs 10/19/2012 09:49'!
testCartesianProductWithEmptyLeftReturnsEmpty
	self assert: Set new equals: (Set new cartesianProduct: #+ with: #(1) asSet).
	self assert: #() equals: (#() cartesianProduct: #+ with: #(1)).
	self assert: OrderedCollection new equals: (OrderedCollection new cartesianProduct: #+ with: (OrderedCollection with: 1)).! !

!ParsingCollectionExtensionTest methodsFor: 'testing' stamp: 'fbs 10/19/2012 09:49'!
testCartesianProductWithEmptyRightReturnsEmpty
	self assert: Set new equals: (#(1) asSet cartesianProduct: #+ with: Set new).
	self assert: #() equals: (#(1) cartesianProduct: #+ with: #()).
	self assert: OrderedCollection new equals: ((OrderedCollection with: 1) cartesianProduct: #+ with: OrderedCollection new).! !

!ParsingCollectionExtensionTest methodsFor: 'testing' stamp: 'fbs 9/5/2012 09:16'!
testCartesianProductWithNonEmptyCollections
	"We show the duplicate 5 to explain the workings of the product. As a Set, the duplicate will be removed."
	self assert: #(4 5 5 6) asSet equals: (#(1 2) asSet cartesianProduct: #+ with: #(3 4) asSet).
	self assert: #(4 5 5 6) equals: (#(1 2) cartesianProduct: #+ with: #(3 4)).
	self assert: #(4 5 5 6) asOrderedCollection equals: (#(1 2) asOrderedCollection cartesianProduct: #+ with: #(3 4) asOrderedCollection).! !
