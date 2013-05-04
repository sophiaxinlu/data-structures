Heap = require '../Heap'

# Shorthand for logging.
l = (x) -> console.log require('util').inspect x, true, 10

extractMinsAndValidate = (heap, output) ->
    i = 0
    actualOutput = []
    while heap.peekMin()?
        actualOutput[i] = heap.removeMin()
        i++
    expect(actualOutput).toEqual output

describe "Add, peek minimum and remove it", ->
    heap = new Heap()
    it "should return undefined if minimum is not found (heap empty)", ->
        expect(heap.peekMin()).toBeUndefined()
        expect(heap.removeMin()).toBeUndefined()
    it "should discard undefined and null", ->
        expect(heap.add undefined).toBeUndefined()
        expect(heap.add 0).toBe 0
        expect(heap.add null).toBeUndefined()
        heap.add 9
        heap.add 8
        extractMinsAndValidate heap, [0, 8, 9]
    heap2 = new Heap()
    it "should return the value added, even negative ones", ->
        expect(heap2.add -1).toBe -1
        expect(heap2.add 0).toBe 0
        expect(heap2.add -2).toBe -2
        heap2.add undefined
        heap2.add -10
        heap2.add 4
        heap2.add 9
        heap2.add undefined
        heap2.add 99
        heap2.add -6
        heap2.add 8
        heap2.add 7
    it "should have the correct minimum", ->
        extractMinsAndValidate heap2, [-10, -6, -2, -1, 0, 4, 7, 8, 9, 99]

describe "Initialization passing an array", ->
    heap = new Heap([-3, undefined, 4, 6, -8, null, 5, -3, 2, 5, 6, -7])
    it "should heapify the array", ->
        extractMinsAndValidate heap, [-8, -7, -3, -3, 2, 4, 5, 5, 6, 6]
