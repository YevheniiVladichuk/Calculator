//
//  Model.swift
//  Calculator
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
    
    // Reset all data to initial state
    mutating func allClear() {
        displayValue = "0"
        currentOperator = nil
        accumulator = 0.0
        isOperationJustPerformed = false
    }
    
    // Adding a number to the display
    mutating func addNumber(number: String) {
        // Checking for a recently performed operation or initial display state
        if isOperationJustPerformed || displayValue == "0" && number != "." {
            displayValue = number
            isOperationJustPerformed = false
        } else {
            // Preventing the addition of multiple dots
            if number == "." && displayValue.contains(".") {
                return
            }
            displayValue += number
        }
        operand = Double(displayValue)
    }
    
    // Converting the display value from String to Double
    mutating func displayValueAsDouble() {
        guard let displayValueAsDouble = Double(displayValue) else {
            print("error guard displayValueAsDouble")
            return
        }
        // Setting the value in the accumulator
        if accumulator == 0 {
            accumulator = displayValueAsDouble
        } else {
            operand = displayValueAsDouble
        }
    }
    
    // Handling the selection of a mathematical operator
    mutating func onOperatorSelected(_ mathOperator: String) {
        
        if isOperationJustPerformed {
            currentOperator = mathOperator
            return
        }
        
        
        // Executing calculations with the current operator, if selected
        if let currentOperator = currentOperator {
            
            calculate(currentOperator)
            
            if displayValue == "Error" {
                return
            }
            formatAndDisplayResult(accumulator)
            
        } else {
            displayValueAsDouble()
        }
        
        isOperationJustPerformed = true
        currentOperator = mathOperator
        operand = nil
    }
    
    // Performing calculations depending on the selected operator
    mutating func calculate(_ mathOperator: String) {
        
        switch mathOperator {
        case "+":
            accumulator = accumulator + operand!
        case "-":
            accumulator = accumulator - operand!
        case "×":
            accumulator = accumulator * operand!
        case "÷":
            // Checking for division by zero
            if let op = operand, op == 0 {
                displayValue = "Error"
                print("\(displayValue)")
                return
            } else {
                accumulator = accumulator / (operand ?? 1)
            }
        case "%":
            accumulator = accumulator.truncatingRemainder(dividingBy: operand!)
        default:
            break
        }
    }
    
    // Changing the sign of the current value
    mutating func toggleSign() {
        if let currentValue = Double(displayValue) {
            formatAndDisplayResult(-currentValue)
            
            // Updating the value in the accumulator or operand
            if isOperationJustPerformed {
                accumulator = -accumulator
            } else {
                operand = -currentValue
            }
        }
    }
    
    // Formatting and displaying the result
    mutating func formatAndDisplayResult(_ number: Double) {
        // Checking for an integer
        
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            // Formatting an integer
            displayValue = String(format: "%.0f", number)
        } else {
            // Formatting a decimal number
            displayValue = String(number)
        }
    }
    
    // Performing the equal operation
    mutating func performEqualOperation() {
        // Checking for the presence of an operator and operand
        if let currentOperator = currentOperator, operand != nil {
            
            calculate(currentOperator)
            
            if displayValue == "Error" {
                return
            }
            
            formatAndDisplayResult(accumulator)
            self.operand = nil
            self.currentOperator = nil
            isOperationJustPerformed = true
        }
    }
}
