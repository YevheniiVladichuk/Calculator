//
//  Interface.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import UIKit

class UserInterface: UIView {
    
    let topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .darkGray
        return topView
    }()
    
    let verticalStack: UIStackView = {
        let vS = UIStackView()
        vS.translatesAutoresizingMaskIntoConstraints = false
        vS.axis = .vertical
        vS.distribution = .fillEqually
        vS.spacing = 1.2
        return vS
    }()
    
    let computedValue: UILabel = {
        let computedValue = UILabel()
        computedValue.translatesAutoresizingMaskIntoConstraints = false
        computedValue.text = "0"
        computedValue.font = computedValue.font.withSize(75)
        computedValue.textColor = .white
        return computedValue
    }()
    
    var arrayOfStackViews: [UIStackView] = []
    var buttonsArray: [UIButton] = []
    let symbolsArray = ["AC", "+/-", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="]
    var buttonsCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configStackViewsInRow()
        buttonsConfig()
        setUpElements()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configStackViewsInRow() {
        
        for _ in 0...6 {
            let stackView = UIStackView()
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.spacing = 1.2
            arrayOfStackViews.append(stackView)
        }
    }
    
    func buttonsConfig() {
        
        for symbol in symbolsArray {
            let button = UIButton()
            button.setTitle(symbol, for: .normal)
            
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
    
    func setUpStacksAndButtons() {
        //add hStackViews from array into bottomVerticalStack
        for index in 0...4 {
            let stack = arrayOfStackViews[index]
            verticalStack.addArrangedSubview(stack)
        }
        
        for index in 0...3 {
            let stack = arrayOfStackViews[index]
            for _ in 0...3 {
                stack.addArrangedSubview(buttonsArray.first!)
                buttonsArray.removeFirst()
            }
        }
    
        if arrayOfStackViews.count == 7 {
            let lastRow = arrayOfStackViews[4]
            let stackA = arrayOfStackViews[5]
            let stackB = arrayOfStackViews[6]
            
            lastRow.addArrangedSubview(stackA)
            lastRow.addArrangedSubview(stackB)
            
            for _ in 0...2 {
                if buttonsArray.count == 3 {
                    stackA.addArrangedSubview(buttonsArray.first!)
                    buttonsArray.removeFirst()
                }else {
                    stackB.addArrangedSubview(buttonsArray.first!)
                    buttonsArray.removeFirst()
                }
            }
        }
    }
    
    func setUpElements() {
        
        addSubview(verticalStack)
        addSubview(topView)
        
        topView.addSubview(computedValue)
        setUpStacksAndButtons()
        
        NSLayoutConstraint.activate([
            verticalStack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.60),
            verticalStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.bottomAnchor.constraint(equalTo: verticalStack.topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            computedValue.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            computedValue.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
        ])
    }
}

