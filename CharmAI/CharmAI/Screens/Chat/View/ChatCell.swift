//
//  ChatCell.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit
class ChatCell: UITableViewCell {
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .red
        
    }
    
}
