//
//  ViewController.swift
//  StackAndGradient3
//
//  Created by Дмитрий Исаев on 24.07.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var manager: ViewManager = {
        return ViewManager.init(controller: self)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#464C75FF")
        
        manager.createAppheader(headerTitle: "Lorem ipsum \nDuis aute irure dolor")
        manager.createCardsStack()
        manager.createServiceCard()
    }


}

