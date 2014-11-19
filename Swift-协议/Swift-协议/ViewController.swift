//
//  ViewController.swift
//  Swift-协议
//
//  Created by 王钱钧 on 14/11/19.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        propertRequirement()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
/*
协议用于定义完成某项任务或功能所必须的方法和属性，协议实际上并不提供这些功能或任务的具体实现，而只用来描述这些实现应该是什么样的
协议可以要求遵循着提供特定的实例属性，实例方法，类方法，操作符或者下标脚本等
*/


//===============================1 协议的语法 Protocol syntax




// 如果一个类在含有父类的同时也采用了协议，应当把父类放在所有协议之前
//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//    
//}


//===============================2 对属性的规定 Propert Requirement
protocol FullyNamed {
//    var defaultPar: String // 非法写法，必须如下面两种形式
//    var mustBeSettable: Int { get set } // 读写
//    var doesNotNeedToBeSettable: Int { get } // 只读
    var fullName: String { get }
    // 不能定义Struct
//    struct test {
//        var test: String
//    }
    
    
}

struct Person: FullyNamed {
    var fullName: String
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
   
    var fullName: String {
        return(prefix != nil ? prefix! + " " : " ") + name
    }
}

func propertRequirement() {
    let arthur = Person(fullName: "Arthur Wang")
    var doris = Starship(name: "Doris", prefix: "Wu")
    println(doris.fullName)
}


//===============================3 对方法的规定 Method Requirement
//===============================4 对突变方法的规定 Mutating Method Requirement
//===============================5 对构造器的规定 Initializer Requirement
//===============================6 协议类型 Protocol as Types
//===============================7 委托模式 Delegation
//===============================8 在扩展中添加协议成员 Adding Protocol Adoption With an Extension
//===============================9 通过扩展补充协议声明 Declaring Protocol Adoption With an Extension
//===============================10 集合中协议类型 Collections of Protocol Types
//===============================11 协议的继承 Protocol Inheritance
//===============================12 类专属协议 Class-Only Protocol
//===============================13 协议合成 Protocol Composition
//===============================14 检验协议的一致性 Checking for Protocol Conformance
//===============================15 对可选协议的规定 Optional Protocol Requirement

