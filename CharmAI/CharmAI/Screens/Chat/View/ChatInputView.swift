//
//  ChatInputView.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

protocol ChatInputDelegate : AnyObject {
  //  func inputView(_ view: ChatInputView, input: String )
    func didPressPassData(text: String?)
}

class ChatInputView: UIView {
    // MARK: PROPERTIES
    weak var delegate : ChatInputDelegate?
    
    var sendAction : (() -> Void)? = nil
    
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
    @objc func sendButtonAction() {
        sendAction?()
        guard let input = textView.text else { return }
      //  delegate?.inputView(self, input: input)
        delegate?.didPressPassData(text: input)
       // textView.text = ""
    }
    
    @objc func didPressPassDataButton(_ sender: UIButton) {
        sendAction?()
        guard let input = textView.text else { return }
       delegate?.didPressPassData(text: input)
   }
    
    
    @objc func handleButton() {
        
        sendButton.setImage(textView.text.isEmpty ? UIImage(named: K.Images.emptySendButton) : UIImage(named: K.Images.sendButton), for: .normal)
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func setupUI() {
        addSubview(textView)
        addSubview(sendButton)
        addSubview(placeholderLabel)
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
            placeholderLabel.snp.makeConstraints { make in
                make.top.equalTo(textView.snp.top)
                make.leading.equalTo(textView.snp.leading).offset(4)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
            
        }
    }
}













import UIKit

class CustomView: UIView {

    weak var textView: UITextView!
    weak var delegate: CustomViewDelegate?
    
     func didPressPassDataButton(_ sender: UIButton) {
        delegate?.didPressPassData(text: textView.text)
    }
}

protocol CustomViewDelegate: AnyObject {
    func didPressPassData(text: String?)
}


// calling in the Parent VC

class ParentVC: UIViewController, CustomViewDelegate {
     weak var customView: CustomView!

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
    }

    //MARK: CustomViewDelegate methods
    func didPressPassData(text: String?) {
        print(text)
    }
}
