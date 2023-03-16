//
//  InAppViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 16.03.2023.
//

import UIKit

final class InAppViewController: UIViewController {
    
    
    private let weeklyButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    private let mounthlyButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    private let annualyButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        
        
    }
    
    
    func setupUI() {
        
    }
    
    
}
