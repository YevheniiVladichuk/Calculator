//
// Interface.swift
// Calculator
//
// Created by Yevhenii Vladichuk on 15/10/2023.
//

import UIKit

// A custom UIView class for the user interface of the calculator.
class UserInterface: UIView {
    
    // A UIView for the top section of the calculator interface.
    let topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    // A vertical stack view to organize buttons in the calculator.
    let verticalStack: UIStackView = {
        let vS = UIStackView()
        vS.translatesAutoresizingMaskIntoConstraints = false
        vS.axis = .vertical
        vS.distribution = .fillEqually
        vS.spacing = 1.2
        return vS
    }()
    
    // Label to display the inputted number or result.
    let inputNumberLabel: UILabel = {
        let inputNumberLabel = UILabel()
        inputNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        inputNumberLabel.font = inputNumberLabel.font.withSize(85)
        inputNumberLabel.adjustsFontSizeToFitWidth = true
        inputNumberLabel.minimumScaleFactor = 0.2
        inputNumberLabel.numberOfLines = 1
        inputNumberLabel.textColor = .white
        inputNumberLabel.textAlignment = .right
        return inputNumberLabel
    }()
    
    // Arrays to hold dynamically created stack views and buttons.
    var arrayOfStackViews: [UIStackView] = []
    var buttonsArray: [UIButton] = []
    // Symbols for calculator buttons.
    let symbolsArray = ["AC", "+/-", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="]
    var buttonsCount = 0
    
    // Standard initializer for UIView.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configuration methods for UI setup.
        configStackViewsInRow()
        buttonsConfig()
        setUpElements()
    }
    
    // Required initializer for decoding views from a nib or storyboard.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adjusts the font size of the label based on the length of the current value.
    func updateCurrentValueFont(_ currentValue: [String]) {
        if currentValue.count > 5 {
            self.inputNumberLabel.font = self.inputNumberLabel.font.withSize(80)
        } else {
            self.inputNumberLabel.font = self.inputNumberLabel.font.withSize(85)
        }
        self.inputNumberLabel.text = currentValue.joined()
    }
    
    // Formats a number string with decimal separators.
    func formatNumber(_ value: String)-> String? {
        if let number = Double(value) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = " "
            numberFormatter.groupingSize = 3
            return numberFormatter.string(from: NSNumber(value: number))
        }
        return nil
    }
    
    // Configures stack views to be used in rows for button placement.
    func configStackViewsInRow() {
        for _ in 0...6 {
            let stackView = UIStackView()
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.spacing = 1.2
            arrayOfStackViews.append(stackView)
        }
    }
    
    // Configures the calculator buttons with their properties.
    func buttonsConfig() {
        for symbol in symbolsArray {
            let button = HighlightableButton() // Custom UIButton subclass
            button.setTitle(symbol, for: .normal)
            button.titleLabel?.font = button.titleLabel?.font.withSize(30)
            
            // Sets colors for different button types.
            switch symbol {
            case "AC", "+/-", "%":
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .lightGray
            case "÷", "×", "-", "+", "=":
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .orange
            default:
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .darkGray
            }
            buttonsArray.append(button)
        }
    }
    
    // Adds buttons to the stack views and arranges them accordingly.
    func setUpStacksAndButtons() {
        let buttonCount = buttonsArray.count
        var buttonIndex = 0 // Index to keep track of the current button
        
        // Adding horizontal stacks to the vertical stack.
        for index in 0...4 {
            let stack = arrayOfStackViews[index]
            verticalStack.addArrangedSubview(stack)
            
            // Adding buttons to the horizontal stacks.
            for _ in 0..<4 {
                let button = buttonsArray[buttonIndex]
                stack.addArrangedSubview(button)
                buttonIndex += 1
                if buttonIndex == buttonCount {
                    break
                }
            }
        }
    }
    
    // Sets up the UI elements and their constraints.
    func setUpElements() {
        // Adding subviews and setting up their constraints.
        addSubview(topView)
        topView.addSubview(inputNumberLabel)
        addSubview(verticalStack)
        
        // Constraints for the top view.
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        
        // Constraints for the input number label.
        NSLayoutConstraint.activate([
            inputNumberLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            inputNumberLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            inputNumberLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            inputNumberLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
        
        // Constraints for the vertical stack view.
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 1),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        setUpStacksAndButtons() // Final step of UI setup
    }
}
