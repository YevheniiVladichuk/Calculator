//
//  ViewController.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import UIKit

// The main view controller for the calculator application.
class ViewController: UIViewController {
    
    // An instance of UserInterface, the custom UIView for the calculator's UI.
    let userInterface = UserInterface()
    // An instance of CalculatorModel, representing the calculator's logic and data.
    var model = CalculatorModel()
    
    // Overrides the default view with the custom user interface.
    override func loadView() {
        super.loadView()
        view = userInterface
    }
    
    // Setup method called after the view controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the initial display of the calculator to "0".
        userInterface.inputNumberLabel.text = "0"
        
        // Assigns a method to handle taps on each button in the calculator.
        for (index, button) in userInterface.buttonsArray.enumerated() {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    // Method to handle button tap events.
    @objc func buttonTapped(_ sender: UIButton) {
        
        // Retrieves the title of the tapped button.
        let buttonValue = sender.currentTitle!
        
        // Handles different button types and updates the model and display accordingly.
        switch buttonValue {
            
        case "AC": // Clears all input and resets display to "0".
            model.allClear()
            userInterface.inputNumberLabel.text = "0"
        case "0"..."9", ".": // Handles number and decimal point input.
            if (!model.displayValue.contains(".") && model.displayValue.count <= 9) || (model.displayValue.contains(".") && model.displayValue.count < 10 && buttonValue != ".") {
                model.addNumber(number: buttonValue)
                updateDisplay()
            }
        case "+/-": // Toggles the sign of the current value.
            model.toggleSign()
            updateDisplay()
        case "%", "÷", "×", "-", "+": // Handles operator input.
            model.onOperatorSelected(buttonValue)
            updateDisplay()
        case "=": // Performs the calculation and updates display.
            model.performEqualOperation()
            updateDisplay()
        default: // Error handling for unexpected button values.
            print("error")
        }
    }
    
    // Updates the calculator's display based on the current value in the model.
    func updateDisplay() {
        let stringValue = model.displayValue
        if stringValue == "Error" {
            userInterface.inputNumberLabel.text = "Error"
        } else if !stringValue.contains(".") {
            userInterface.inputNumberLabel.text = userInterface.formatNumber(stringValue)
        } else {
            userInterface.inputNumberLabel.text = stringValue
        }
    }
}
