//
//  ViewController.swift
//  Swift-Extensions
//
//  Created by 王钱钧 on 14/11/18.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
Swift中的扩展可以：
1）添加计算型属性和计算静态属性
2）定义实例方法和类型方法
3）提供新的构造器
4）定义下标
5）定义和使用新的嵌套类型
6）使一个已有类型符合某个协议
*/

//===============1 扩展语法（extension）

/*
extension SomeType {
    
}

extension SomeType: SomeProtocol, AnotherProtocol {
    
}
*/

//===============2 计算型属性
/*
扩展可以向已有的类型添加计算型实例属性和计算型类型属性
*/
extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
    //var storeProperty = 0 // 扩展不能添加存储属性
}

func test() {
    let oneInch = 25.4.mm
    3.repetitions { () -> () in
        println("hello")
    }
    var someInt = 3
    someInt.square()
    println(1234567[0])
    println(1234567[1])
    println(1234567[2])
    println(1234567[3])
    println(1234567[4])
    
    printLetterKinds("Hello!")
}


//===============3 构造器
/*
扩展可以向已有类型添加新的构造器（便利构造器 convenience），这个可以让你扩展其他类型，将你自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项

不能添加指定构造器（Designated），指定构造器和析构函数只能由原始的类实现
*/

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    // 便利构造器
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//===============4 方法
extension Int {
    func repetitions(task: ()->()) {
        for i in 0..<self { // ... = [],  ..< = [)
            task()
        }
    }
}

//修改实例方法
extension Int {
    mutating func square() {
        self = self * self
        println(self)
    }
}


//===============5 下标
extension Int {
    subscript(var digintIndex: Int) -> Int {
        var decrimalBase = 1
        while digintIndex > 0 {
            decrimalBase *= 10
            digintIndex--
        }
        return (self / decrimalBase) % 10
    }
}
//===============6 嵌套类型
extension Character {
    
    struct testStruct {
        var test: String = ""
    }
    
    enum Kind {
        case Vowel, Consonant, Other
    }
    
    var kind: Kind {
        switch String(self).lowercaseString {
            case "a", "e", "i", "o", "u":
                return .Vowel
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                return .Consonant
            default:
                return .Other
            
        }
    }
}

func printLetterKinds(word: String) {
    println("\(word)'s made up of the following kinds of letters:")
    for characher in word {
        switch characher.kind {
        case .Vowel:
            println("Vowel")
        case .Consonant:
            println("Consonant")
        case .Other:
            println("Other")
        }
    }
}
