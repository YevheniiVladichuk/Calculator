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
        
        userInterface.inputNumberLabel.text = "0"
        
        for (index, button) in userInterface.buttonsArray.enumerated() {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        let buttonValue = sender.currentTitle!

        switch buttonValue {
            
        case "AC":
            model.allClear()
            userInterface.inputNumberLabel.text = "0"
            
        case "0"..."9", ".":
            if (!model.displayValue.contains(".") && model.displayValue.count < 9) || (model.displayValue.contains(".") && model.displayValue.count < 10 && buttonValue != ".") {
                model.addNumber(number: buttonValue)
                updateDisplay()
            }
        case "+/-", "%", "÷", "×", "-", "+":
            model.onOperatorSelected(buttonValue)
            updateDisplay()
            
        default:
            print("error")
        }
    }
    
    func updateDisplay() {
        let stringValue = model.displayValue
        if !stringValue.contains("."){
            userInterface.inputNumberLabel.text = userInterface.formatNumber(stringValue)
        }else {
            userInterface.inputNumberLabel.text = stringValue
        }
    }
}
