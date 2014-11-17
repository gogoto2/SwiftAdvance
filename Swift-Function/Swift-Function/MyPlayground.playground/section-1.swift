// Playground - noun: a place where people can play

import Cocoa

func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func testInout() {
    var someInt = 3
    var anotherInt = 108
    swapTwoInts(&someInt, &anotherInt)
}

testInout()
