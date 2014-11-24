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
//        propertRequirement()
//        delegation()
        addingProtocolAdoptionWithAnEx()
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
/*
实例可以要求遵循者实现某些指定的实例方法或类方法，这些方法作为协议的一部分，像普通的方法一样清晰的放在协议的定义中，而不需要大括号和方法体

主意：
协议中得方法支持变长参数 variadic parameter， 不支持默认参数 default value

*/

protocol RandomNumberGenerator {
    func random() -> Double // 协议并不在意每一个随机数怎样生成的，它只强调这里有一个随机数生成器
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 129968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom
    }
}


//===============================4 对突变方法的规定 Mutating Method Requirement
/*
主意：
用类实现协议中的mutating方法时，不需要写mutating关键字
用结构体和枚举实现协议中得mutating方法时，必须写mutating关键字

*/

protocol Toggle {
    mutating func toggle()
}

//当使用枚举或结构体来实现Toggle协议时，需要提供一个带有mutating前缀的toggle方法
enum OnOffSwitch: Toggle {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}

func mutatingMethodRequirement() {
    var lightSwitch = OnOffSwitch.Off
    lightSwitch.toggle()
}

//===============================5 对构造器的规定 Initializer Requirement
/*
协议可以要求它的遵循类型实现特定的构造器
*/
protocol SomeProtocol {
    init(someParameter: Int) // 没有方法体
}

class SomeSuperClass: SomeProtocol {
    required init(someParameter: Int) { // 使用required可以保证：所有的遵循该协议的子类，同样能为构造器规定提供一种显示的实现或继承实现
        // 构造器的实现
    }
}

// 如果一个子类重写了父类的制定构造器，并且该构造器遵循了某个协议的规定，那么该构造器的实现需要被同时标示require 和 override
class SomeSubClass: SomeSuperClass, SomeProtocol {
    required init(someParameter: Int) {
        //...
        super.init(someParameter: someParameter)
    }
}

//===============================6 协议类型 Protocol as Types
/*
尽管协议本身并不实现任何功能，但是协议可被当做类型来使用。
使用场景：
1）协议类型作为函数、方法或构造器中得参数类型或返回值类型
2）协议类型作为常量、变量或属性的类型
3）协议类型作为数组、字典或其他容器中元素类型
*/

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    // generator 被认为是遵循了 RandomNumberGenerator 的类型
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator // 协议类型
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
    
}

func protocolAsTypes() {
    var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    for _ in 0...5 {
        println("Random dice roll is \(d6.roll())")
    }
}

//===============================7 委托模式 Delegation
/*
委托是一种设计模式，它允许类或结构体将一些需要他们负责的功能交由（委托）给其他的类型的实例
委托模式的实现很简单： 定义协议来封装那些需要被委托的函数和方法，使其遵循着拥有这些被委托的函数和方法
*/

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakeAndLadders: DiceGame {
    let finalSquare = 25;
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08
        board[06] = +11
        board[09] = +09
        board[10] = +02
        board[14] = -10
        board[19] = -11
        board[22] = -02
        board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
        // 带标签的语句（gameloop - 标签）
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
    
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakeAndLadders {
            println("Started a new game of Snakes and Ladders")
        }
        
        println("The game is using a \(game.dice.sides) -sided dice")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns++
        println("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        println("The game lasted for \(numberOfTurns) turns")
    }
}

func delegation() {
    let traker = DiceGameTracker()
    var snakerAndLadder = SnakeAndLadders()
    snakerAndLadder.delegate = traker
    snakerAndLadder.play()
}

//===============================8 在扩展中添加协议成员 Adding Protocol Adoption With an Extension
protocol TextRepresentable {
    func asText() -> String
}

extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides) -sided dice"
    }
}

func addingProtocolAdoptionWithAnEx() {
    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
    println(d12.asText())
}


//===============================9 通过扩展补充协议声明 Declaring Protocol Adoption With an Extension
/*
当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明
*/
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}

//补充声明
extension Hamster: TextRepresentable {}

func declaringProtocolAdoptionWihtEx() {
    let simonTheHasmter = Hamster(name: "Simon")
    let somethingTextRepresentable: TextRepresentable = simonTheHasmter
    println(somethingTextRepresentable.asText())
}

//===============================10 集合中协议类型 Collections of Protocol Types
//===============================11 协议的继承 Protocol Inheritance
//===============================12 类专属协议 Class-Only Protocol
//===============================13 协议合成 Protocol Composition
//===============================14 检验协议的一致性 Checking for Protocol Conformance
//===============================15 对可选协议的规定 Optional Protocol Requirement

