//
//  ViewController.swift
//  Calculator
//
//  Created by Yevhenii Vladichuk on 15/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let userInterface = UserInterface()
    
    override func loadView() {
        super.loadView()
        view = userInterface
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

