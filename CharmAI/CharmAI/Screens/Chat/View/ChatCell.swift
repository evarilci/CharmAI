//
//  ChatCell.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

class ChatCell: UITableViewCell {
    
     private let iconView : UIImageView = {
         let iv = UIImageView()
         iv.contentMode = .scaleAspectFill
         iv.backgroundColor = .systemGray6
         iv.clipsToBounds = true
         return iv
    }()
    
    
    var messageContainer : UIView = {
       let view = UIView()
        view.backgroundColor = .receivedMessage
        view.clipsToBounds = true
       return view
       
   }()
    
    private let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text = "Message"
        textView.textColor = .white
        
        return textView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setupUI()
        
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(iconView)
        addSubview(messageContainer)
        addSubview(textView)
        
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
        }
        
        messageContainer.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(4)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(messageContainer.snp.top)
            make.bottom.equalTo(messageContainer.snp.bottom)
            make.leading.equalTo(messageContainer.snp.leading).offset(3)
            make.trailing.equalTo(messageContainer.snp.trailing)
            
        }
        
        messageContainer.layer.cornerRadius = self.frame.size.height / 2
        messageContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
      
        iconView.layer.cornerRadius = 25 / 2
    }
    
}
