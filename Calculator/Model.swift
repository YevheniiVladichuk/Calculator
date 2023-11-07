//
//  Model.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import Foundation

struct CalculatorModel {
    
    var currentValue: String = "0"
    var currentOperation: String = ""
    var previousValue: Double = 0.0
    
    mutating func addNumber(number: String) {
        if currentValue == "0" {
            currentValue = number
        }else {
            currentValue += number
        }
    }
    
    mutating func addOperation(operation: String) {
        
        
        if previousValue == 0.0 {
            previousValue = Double(currentValue)!
            currentValue = "0"
            currentOperation = operation
        }else {
            
            //add logic
            
        }
        
        
    }
    
}
