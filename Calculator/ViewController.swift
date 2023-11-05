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
        // Do any additional setup after loading the view.
        
        for (index, button) in userInterface.buttonsArray.enumerated() {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        let buttonValue = sender.currentTitle!
        
        switch buttonValue {
            
        case "AC":
            model.currentValue = []
            userInterface.currentValue.text = "0"
            
        case "0"..."9", ",":
            
            if !model.currentValue.contains(",") {
                if model.currentValue.count < 9 {
                    model.currentValue.append(buttonValue)
                    updateDisplay()
                }
            }else if model.currentValue.contains(",") {
                if model.currentValue.count < 10 {
                    model.currentValue.append(buttonValue)
                    updateDisplay()
                }
            }
            
//        case "+":
            
            
        default:
            print("error")
        }
    }
    
    func updateDisplay() {
        
        let stringValue = model.currentValue.joined()
        if !stringValue.contains(","){
            userInterface.currentValue.text = userInterface.formatNumber(stringValue)
        }else {
            userInterface.currentValue.text = stringValue
        }
    }
    
}

//"AC", "+/-", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="
