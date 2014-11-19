//
//  ViewController.swift
//  Swift-继承
//
//  Created by 王钱钧 on 14/11/18.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testClass()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//=============1 定义一个基类（Base class）
/*
Swift 中的类并不是从一个通用的基类继承而来，如果你不为你定义的类指定一个超类的话，这个类就自动成为基类
*/
class Vehicle {

    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // 什么也不做，因为车辆不一定有噪音
    }
}

//=============2 子类生成 （Subclassing）
/*
子类继承父类的特性，并且可以优化或改变它，还可以添加新特性
*/

// 自行车继承车类
class Bicycle: Vehicle {
    var hasBasket = false
}

// 双人自行车
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

//=============3 重写 Overriding
/*
子类可以为继承来的实例方法，类方法，实例属性，或下标脚本提供自己定制的实现--------重写（override）
*/
class Train: Vehicle {
    
    // 重写方法
    override func makeNoise() {
        println("Choo Choo......")
    }
}

// 重写属性
/*
你可以提供定制的getter（或setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算性的属性
*/
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

//重写属性观察器
/*
注意：

1）你不可以为继承来的常量存储型属性或者继承来的只读计算型属性添加属性观察器。这些属性值是不可以被设置的
2）你不可以同时提供重写的setter和重写的属性观察器，如果你想观察属性值的变化，并且你已经为那个属性提供了定制的setter，那么你在setter中就可以观察到任何值得变化了

*/


//重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}


//=============4 防止重写
/*
你可以通过把方法，属性或下标脚本标记为final来防止他们被重写，只需要在声明关键字前加上@final即可
例如：
final var
final func
final class func
final subscript
*/

func testClass() {
    let someVehicle = Vehicle()
    println("Vehicle:\(someVehicle.description)")

    let bicycle = Bicycle()
    bicycle.hasBasket = true
    bicycle.currentSpeed = 15.0
    println("Bicycle:\(bicycle.description)")
    
    let tandem = Tandem()
    tandem.currentNumberOfPassengers = 2
    tandem.currentSpeed = 20.0
    println("Tandem:\(tandem.description)")
    
    let train = Train()
    train.makeNoise()
    
    let car = Car()
    car.currentSpeed = 40.0
    car.gear = 4
    println("Car: \(car.description)")
    
    let automatic = AutomaticCar()
    automatic.currentSpeed = 35.0
    print("AutomaticCar:\(automatic.description)")
}


