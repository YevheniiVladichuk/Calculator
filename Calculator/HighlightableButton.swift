//
//  HighlightableButton.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 20/11/2023.
//

import UIKit

class HighlightableButton: UIButton {
    private var originalBackgroundColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                originalBackgroundColor = backgroundColor
                backgroundColor = .white.withAlphaComponent(0.80)
            } else {
                backgroundColor = originalBackgroundColor
            }
        }
    }
}

