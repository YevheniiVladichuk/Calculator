//
//  ViewController.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let userInterface = UserInterface()
    var model = CalculatorModel()
    
    
    override func loadView() {
        super.loadView()
        view = userInterface
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInterface.inputNumberLabel.text = model.currentValue
        
        for (index, button) in userInterface.buttonsArray.enumerated() {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        let buttonValue = sender.currentTitle!
//        print("Нажата кнопка: \(buttonValue)")
        
        
        switch buttonValue {
            
        case "AC":
            model.currentValue = "0"
            userInterface.inputNumberLabel.text = "0"
//            print (model.currentValue)
            
        case "0"..."9", ".":
            if (!model.currentValue.contains(".") && model.currentValue.count < 9) || (model.currentValue.contains(".") && model.currentValue.count < 10 && buttonValue != ".") {
                model.addNumber(number: buttonValue)
                
                updateDisplay()
            }
        case "+/-", "%", "÷", "×", "-", "+", "=":
            
            model.addOperation(operation: buttonValue)
           
            
        default:
            print("error")
        }
    }
    
    func updateDisplay() {
        let stringValue = model.currentValue
        if !stringValue.contains("."){
            userInterface.inputNumberLabel.text = userInterface.formatNumber(stringValue)
        }else {
            userInterface.inputNumberLabel.text = stringValue
        }
    }
}
