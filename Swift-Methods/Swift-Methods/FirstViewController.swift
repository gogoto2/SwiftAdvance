//
//  FirstViewController.swift
//  Swift-Methods
//
//  Created by 王钱钧 on 14/11/18.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        testMutating()
        testTypeMethods()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
/*
方法是与某些特定类型相关联的函数
*/

//===========1 实例方法（Instance Methods）
/*
实例方法是属于某个特定类、结构体或者枚举类型实例的方法
*/

class Counter {
    var count = 0
    
    // self 属性
    /*
    类型的每一个实例都有一个隐含属性叫self，你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例
    你不必在代码里面经常写self，无论何时，只要在一个方法中使用一个已知属性或者方法名称，如果没有明确的写self，Swift假定是指当前实例的属性或者方法
    */
    func increment() {
        
//        count++
        self.count++
        
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    
    func reset() {
        count = 0
    }
}

//在实例方法中修改值类型
/*
结构体和枚举类型是值类型，一般情况下，值类型的属性不能在它的实例方法中被修改
但是，如果你确实需要在某个具体方法中修改结构体或者枚举的属性，你可以选择 变异（mutating）这个方法
方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后替换原来实例
*/
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, deltaY: Double) {
//        x += deltaX
//        y += deltaY
        //
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case Off, Low, Hight
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .Hight
        case .Hight:
            self = .Off
        }
    }
}


func testMutating() {
    var somePoint = Point(x: 1.0, y: 1.0)
    somePoint.moveByX(2.0, deltaY: 3.0)
    println("The point is now at (\(somePoint.x), \(somePoint.y))")
    
    var ovenLight = TriStateSwitch.Low
    ovenLight.next()
    
}


func testMethods() {
    let counter = Counter()
    counter.incrementBy(5, numberOfTimes: 3)
}

//===========2 类型方法（Type Methods）/ 类方法
/*
你也可以定义类型本身调用的方法--类方法
类的类型方法，在func之前加关键字class
结构体和枚举类型的类型方法，在func之前加static
*/

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
//        if level > self.highestUnlockedLevel { self.highestUnlockedLevel = level }
        // 结构体和枚举的类型方法也能够直接通过静态属性的名称访问静态属性
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
//            self.currentLevel = 3 // 只能访问静态属性
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
//            currentLevel = level
            self.currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}


func testTypeMethods() {
    var player = Player(name: "Arthur")
    player.completedLevel(3)
    println("Heightest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
    
    var player2 = Player(name: "Doris")
    player2.completedLevel(8)
    println("Heightest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
}
