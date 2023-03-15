//
//  CharmButton.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

class CharmButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .accentColor.withAlphaComponent(0.85) : .accentColor
        }
    }
    
     init(frame: CGRect = .zero, title: String) {
        super.init(frame: frame)
         setButton(title: title)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(title: String) {
        self.backgroundColor = .accentColor
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 15
     
    }
    
}



