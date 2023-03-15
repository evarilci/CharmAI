//
//  ChatCell.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var chat : Chat?{
        didSet {
            configure()
        }
    }
    
     private let iconView : UIImageView = {
         let iv = UIImageView()
         iv.contentMode = .scaleAspectFill
         iv.backgroundColor = .systemGray6
         iv.image = UIImage(named: K.Images.iconImage)
         iv.clipsToBounds = true
         return iv
    }()
    
    
    var messageContainer : UIView = {
       let view = UIView()
        view.backgroundColor = .receivedMessage
        view.clipsToBounds = true
       return view
       
   }()
    
     let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text = "Message"
        textView.textColor = .labelColor
        
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
            make.top.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        textView.snp.makeConstraints { make in
            make.center.equalTo(messageContainer.snp.center)
            make.height.equalTo(messageContainer.snp.height)
            make.width.equalTo(messageContainer.snp.width)
            
        }
        
        messageContainer.layer.cornerRadius = self.frame.height / 3
        messageContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
      
        iconView.layer.cornerRadius = 25 / 2
    }
    
    private func configure() {
        guard let chat = self.chat else {return}
        let ViewModel = ChatViewModel(chat: chat)
        messageContainer.backgroundColor = ViewModel.chatBackgroundColor
        iconView.isHidden = ViewModel.isCurrentUser
        self.textView.text = chat.message
        
        if ViewModel.isCurrentUser {
            messageContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            messageContainer.snp.remakeConstraints { make in
                           make.leading.equalTo(self.snp.centerX)
                           make.top.equalToSuperview().offset(6)
                           make.trailing.equalToSuperview().offset(-5)
                           make.bottom.equalToSuperview().offset(-12)
                       }
            layoutIfNeeded()
        }
    }
}
