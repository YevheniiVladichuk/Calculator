//
//  Model.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import Foundation

struct CalculatorModel {
    
    var displayValue: String = "0"
    var currentOperationEnum: CalculatorOperation?
    var previousValue: Double = 0.0
    var accumulator: Double?
    var resultString: String?
    
    enum CalculatorOperation: String {
        case toggleSign = "+/-"
        case percent = "%"
        case divide = "÷"
        case multiply = "×"
        case subtract = "-"
        case add = "+"
        case equals = "="
    }
    
    mutating func allClear() {
        
        displayValue = "0"
        currentOperationEnum = nil
        previousValue = 0.0
        accumulator = nil
        resultString = "0"
        

        
    }
    
    mutating func addNumber(number: String) {
        if displayValue == "0" {
            displayValue = number
        }else {
            displayValue += number
        }
    }
    
    mutating func operation(operation: String) {
        
        guard let enumOperation = CalculatorOperation(rawValue: operation) else {
            print("не известная операция")
            return
        }
        
        print (enumOperation)
        
        if let currentValueAsDouble = Double(displayValue) {
            
            print("currentValueAsDouble = \(currentValueAsDouble)")
            
            if let currentOpEnum = currentOperationEnum {
                
                switch currentOpEnum {
                case .add:
                    accumulator = (accumulator ?? previousValue) + currentValueAsDouble
                default:
                    break
                }
            }else {
                accumulator = currentValueAsDouble
            }
            
        }
        
        if enumOperation != .equals {
            previousValue = accumulator ?? 0.0
            displayValue = "0" // Сбросить currentValue после выполнения операции
        } else {
            // Для операции равно, обновляем previousValue и currentValue
            previousValue = accumulator ?? 0.0
            displayValue = String(previousValue)
        }
        
        
        
        currentOperationEnum = enumOperation != .equals ? enumOperation : nil
        
        
        
        
    }
    
}
