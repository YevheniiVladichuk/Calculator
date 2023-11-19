//
//  Model.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import Foundation

struct CalculatorModel {
    
    var displayValue: String = "0"
    var currentOperation: String?
    var operand: Double?
    var accumulator = 0.0
    var isOperationJustPerformed = false
    
    mutating func allClear() {
        displayValue = "0"
        currentOperation = nil
        accumulator = 0.0
        isOperationJustPerformed = false
    }
    
    mutating func addNumber(number: String) {
        
        operand = nil
        
        if displayValue == "0" || isOperationJustPerformed {
            displayValue = number
        }else {
            displayValue += number
        }
    }
    
    //не отображает сумму после второго плюса !
    //сама логика работает
    
    mutating func operation(operation: String) {
        
        guard let displayValueAsDouble = Double(displayValue) else {
            print("error guard displayValueAsDouble")
            return
        }
        operand = displayValueAsDouble //число на дисплее стало операндом
        currentOperation = operation
        isOperationJustPerformed = true
        print("opperand = \(operand!)")
        print("operation = \(currentOperation!)")
        
        if let currentOp = currentOperation {
            
            switch currentOp {
            case "+":
                accumulator = accumulator + operand!
                print("accumulator value = \(accumulator)")
            default:
                break
            }
        }
    }
}
