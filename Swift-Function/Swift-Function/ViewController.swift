//
//  ViewController.swift
//  Swift-Function
//
//  Created by 王钱钧 on 14/11/17.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        testInout()
//        useFunctionTypes()
        functionTypeAsReturnTypes()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//==========1 函数定义与调用 Defining and Calling Functions
//==========2 函数参数返回值 Function Parameters and Return Values

// 多重返回值函数Multiple Return Values （元组）
func count(str: String) -> (vowels: Int, consonants: Int, others: Int) {
    var v = 0, c = 0, o = 0
    for character in str {
        //..
    }
    
    return(v, c, o) // 返回元组
}

//==========3 函数参数名称 Function Parameter Names
/*
可变参数, 可以接受一个或多个值（...）,多参数相当于数组。
可变参数放在参数列表的最后
*/
func arithmeticMean(numbers: Double...) -> Double {
    
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

// 常量参数与变量参数(参数中特别声明了 var 的为变量参数，默认的为常量参数)
func alignRight(var str: String, count: Int, pad: Character) -> String {
    str = "g"
    return ""
}

// 输入输出参数（inout）
//变量参数，仅仅能再函数体内被更改，如果你想要一个函数可以修改参数的值，并且想要在这些修改函数调用结束后仍然存在，就应该把这个参数定义为输入输出参数
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

//==========4 函数类型 Function Types
func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}

func useFunctionTypes() {
    var mathFunction: (Int, Int) -> Int = addTwoInts
    let anotherMathFunction = addTwoInts
    println("Result: \(mathFunction(2,3))")
    printMathResult(mathFunction, 4, 8)
}

//函数类型作为参数类型
func printMathResult(mathFunction:(Int, Int) -> Int, a: Int, b: Int) {
    println("Result: \(mathFunction(a, b))")
}

//函数类型作为返回类型
func stepForward(input: Int) -> Int {
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int)->Int { // 返回一个函数
    return backwards ? stepBackward : stepForward
}

func functionTypeAsReturnTypes() {
    var currentValue = 8
    let moveNearerToZero = chooseStepFunction(currentValue > 0)
    while currentValue != 0 {
        println("\(currentValue)...")
        currentValue = moveNearerToZero(currentValue)
    }
    
    println("zero!")
}

//==========5 函数嵌套

func chooseStepFunction1(backwards: Bool) -> (Int)->Int { // 返回一个函数
    func stepForward1(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward1(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackward1 : stepForward1
}



