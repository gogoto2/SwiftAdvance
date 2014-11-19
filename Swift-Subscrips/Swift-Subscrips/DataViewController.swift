//
//  DataViewController.swift
//  Swift-Subscrips
//
//  Created by 王钱钧 on 14/11/18.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: AnyObject?


    override func viewDidLoad() {
        super.viewDidLoad()
//        testSyntax()
        testOptional()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            self.dataLabel!.text = obj.description
        } else {
            self.dataLabel!.text = ""
        }
    }


}


//=============1 下表脚本语法
//subscript(index: Int) -> Int {
//    get {
//        
//    }
//    
//    set(newValue) {
//        
//    }
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

func testSyntax() {
    let threeTimesTable = TimesTable(multiplier: 3)
    println("3的6倍是\(threeTimesTable[6])")
}

//=============2 下标脚本用法


//=============3 下标脚本选项
/*
下标脚本允许任意数量的入参索引，并且每个入参类型也没有限制。下标脚本的返回值也可以是任何类型。下表脚本可以使用变量参数和可变参数，但使用写入读出（inout）参数或给参数设置默认值都是不允许的
*/
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        
        set(newValue) {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

func testOptional() {
    var matrix = Matrix(rows: 2, columns: 2)
    println(matrix.grid)
    matrix[0,0] = 00
    matrix[0,1] = 01
    println(matrix.grid)
}
