//
//  ChatInputView.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

class ChatInputView: UIView {
    // MARK: PROPERTIES
    
    private let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.text = "Message"
        textView.textColor = .white
        
        return textView
    }()
    
    private let sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:K.Images.sendButton), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(textView)
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4)
            make.top.equalToSuperview()
            make.width.height.equalTo(33)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(sendButton.snp.leading).inset(2.75)
            make.height.equalTo(65)
        }
    }
    
}
