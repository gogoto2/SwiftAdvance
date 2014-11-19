//
//  ViewController.swift
//  Swift-Enumerations
//
//  Created by 王钱钧 on 14/11/17.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        testEnum()
//        associatedValues()
        rawValues()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


/*
在Swift中，枚举类型是一等类型（first-class），他们采用很多传统上只被class所支持的特征
例如计算型属性，用于提供关于枚举当前值得附加信息
实例方法，用于提供和枚举所代表的值相关联的功能
枚举也可以定义构造函数来提供一个初始成员值，可以在原始的实现基础上扩展他们的功能
*/
enum CompassPoint {
    // 多个成员出现在一行，用逗号隔开
    case North
    case South
    case East, West
}

func testEnum() {
    var dire = CompassPoint.North
//    dire = .South
    println(dire)
    switch dire {
    case .North:
        println("North")
    case .South:
        println("South")
    case .East:
        println("East")
    case .West:
        println("West")
    }
}

//==========1 相关值（Associated Values）
/*
你可以定义Swift的枚举类型存储任何类型的相关值，如果需要的话，每个成员的数据类型可以使各不相同的
*/
enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

func associatedValues() {
    var productBarcode = Barcode.UPCA(1, 645324_234564, 3)
    productBarcode = .QRCode("DFGHJRTYUIHJK")
    
    switch productBarcode {
    case .UPCA(let numberSystem, let identifier, let check):
        println("UPC-A with value of \(numberSystem), \(identifier), \(check)")
    case .QRCode(var productCode):
        println("QR code with value of \(productCode)")
    }
}

//============2 原始值（Raw Values）
/*
注意，原始值和相关值是不相同的。
*/

enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars
}

func rawValues() {
    let earthOrder = Planet.Earth.rawValue
    println("earthOrder = \(earthOrder)")
    
    let possiblePlanet = Planet(rawValue: 4)
    println("possiblePlanet = \(possiblePlanet)")
}




