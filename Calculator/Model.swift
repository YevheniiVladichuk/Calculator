//
//  Model.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import Foundation

struct CalculatorModel {
    
    var displayValue: String = "0"
    var currentOperator: String?
    var operand: Double?
    var accumulator = 0.0
    var result: Double?
    var isOperationJustPerformed = false
    
    mutating func allClear() {
        displayValue = "0"
        currentOperator = nil
        accumulator = 0.0
        isOperationJustPerformed = false
    }
    
    // Adding the number on the display
    mutating func addNumber(number: String) {
        if isOperationJustPerformed || displayValue == "0"  {
               displayValue = number
               isOperationJustPerformed = false
           } else {
               displayValue += number
               print(displayValue)
           }
           operand = Double(displayValue)
    }
   
    // Converting the number on the display from String to Double
    mutating func displayValueAsDouble() {
        guard let displayValueAsDouble = Double(displayValue) else {
            print("error guard displayValueAsDouble")
            return
        }
        if accumulator == 0 {
            accumulator = displayValueAsDouble
        }else {
            operand = displayValueAsDouble
        }
    }

    
    mutating func onOperatorSelected(_ mathOperator: String) {
        
        if isOperationJustPerformed {
            currentOperator = mathOperator
            return
        }
        
        if let currentOperator = currentOperator {
            calculate(currentOperator)
            displayValue = String(accumulator)
        }else {
            displayValueAsDouble()
        }
        
        isOperationJustPerformed = true
        currentOperator = mathOperator
        operand = nil
        
    }
    
    mutating func calculate(_ mathOperator: String) {
        
        switch mathOperator {
        case "+":
            accumulator = accumulator + operand!
            print("accumulator value = \(accumulator)")
        case "-":
            accumulator = accumulator - operand!
            print("accumulator value = \(accumulator)")
        case "×":
            accumulator = accumulator * operand!
            print("accumulator value = \(accumulator)")
        case "÷":
            if operand != 0 {
                accumulator = accumulator / operand!
                print("accumulator value = \(accumulator)")
            } else {
                print("Division by zero")
            }
        case "%":
            accumulator = accumulator.truncatingRemainder(dividingBy: operand!)
            print("accumulator value = \(accumulator)")
        case "+/-":
            accumulator = -accumulator
            print("accumulator value = \(accumulator)")
        default:
            break
        }
    }
}
