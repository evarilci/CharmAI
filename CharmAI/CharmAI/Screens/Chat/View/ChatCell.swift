//
//  ChatCell.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit
import Toast

final class ChatCell: UITableViewCell {
    
    var chat : Chat?{
        didSet {
            configure(chat: chat!)
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
        textView.font = UIFont(name: "Inter", size: 14)
        textView.textColor = .labelColor
        
        return textView
    }()
    
    
    let copyButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: K.Images.copyButtonImage), for: .normal)
        return button
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
        contentView.addSubview(copyButton)
        addSubview(copyButton)
        messageContainer.addSubview(textView)
        
        
        copyButton.snp.makeConstraints { make in
            make.trailing.equalTo(messageContainer.snp.trailing)
            make.bottom.equalTo(messageContainer.snp.bottom)
            make.width.height.equalTo(25)
        }
        
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
            
            make.top.equalTo(messageContainer.snp.top)
            make.leading.equalTo(messageContainer.snp.leading)
            make.trailing.equalTo(copyButton.snp.leading)
            make.bottom.equalTo(messageContainer.snp.bottom)
        }
        
        messageContainer.layer.cornerRadius = self.frame.height / 3
        messageContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        
        iconView.layer.cornerRadius = 25 / 2
    }
    @objc func copyAction() {
        
        guard let textToCopy = textView.text else {
               return
           }
           UIPasteboard.general.string = textToCopy
        let toast = Toast.text("Copied")
        toast.show()
    }
    
    private func configure(chat: Chat) {
        
        messageContainer.backgroundColor = chat.isSender ? .accentColor : .receivedMessage
        iconView.isHidden = chat.isSender
        
        self.textView.text = chat.message
        if chat.isSender {
            messageContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            messageContainer.snp.remakeConstraints { make in
                make.leading.equalTo(self.snp.centerX)
                make.top.equalToSuperview().offset(6)
                make.trailing.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview().offset(-12)
            }
            layoutIfNeeded()
        } else {
            messageContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            messageContainer.snp.remakeConstraints { make in
                make.leading.equalTo(iconView.snp.trailing).offset(4)
                make.top.equalToSuperview().offset(6)
                make.trailing.equalToSuperview().multipliedBy(0.7)
                make.bottom.equalToSuperview().offset(-12)
            }
            layoutIfNeeded()
        }
    }
}
