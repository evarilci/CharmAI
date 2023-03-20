//
//  ChatInputView.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit



class ChatInputView: UIView {
    // MARK: PROPERTIES
    
    var sendAction : ((String?) -> ())?
    
       let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.textColor = .labelColor
        textView.autocorrectionType = .no
        return textView
    }()
    
    let placeholderLabel : UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.textColor = .placeholderText
        label.font = UIFont(name: "Inter", size: 15)
        return label
    }()
    
    let sendButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:K.Images.emptySendButton), for: .normal)
        return button
    }()
    
    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    @objc func didPressPassDataButton(_ sender: UIButton) {
        guard let input = textView.text else { return }
        sendAction?(input)
        textView.text = ""
   
   }
    
    
    @objc func handleButton() {
        
        sendButton.setImage(textView.text.isEmpty ? UIImage(named: K.Images.emptySendButton) : UIImage(named: K.Images.sendButton), for: .normal)
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func setupUI() {
        let line = UIView()
        line.layer.borderWidth = 0.5
        line.layer.borderColor = UIColor.accentColor.cgColor
        addSubview(textView)
        addSubview(sendButton)
        addSubview(placeholderLabel)
       
        addSubview(line)
      
        autoresizingMask = .flexibleHeight
        NotificationCenter.default.addObserver(self, selector: #selector(handleButton), name: UITextView.textDidChangeNotification, object: nil)
        sendButton.addTarget(self, action: #selector(didPressPassDataButton(_:)), for: .touchUpInside)
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.width.equalTo(sendButton.snp.height)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(sendButton.snp.leading)
            make.bottom.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            
            line.snp.makeConstraints { make in
                make.bottom.equalTo(textView.snp.top)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
            
            placeholderLabel.snp.makeConstraints { make in
                make.top.equalTo(textView.snp.top)
                make.leading.equalTo(textView.snp.leading).offset(4)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
            
        }
    }
}



