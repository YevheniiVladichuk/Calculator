//
//  ViewController.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let userInterface = UserInterface()
    var model = CalculatorModel() {
        didSet {
            userInterface.updateCurrentValueFont(model.currentValue)
        }
    }
    

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
        
        let buttonTitle = sender.currentTitle!
        
        switch buttonTitle {
        case "AC":
            model.currentValue = []
            userInterface.currentValue.text = "0"
            
            print (model.currentValue)
        case "0"..."9", ".":
            
            if model.currentValue.count < 12 {
                model.currentValue.append(buttonTitle)
                let stringValue = model.currentValue.joined()
                userInterface.currentValue.text = stringValue
            }
            
        default:
            print("error")
        }
    }
    
}

//"AC", "+/-", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="
