//
//  ChatViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit



final class ChatViewController: UIViewController {
    //MARK: PROPERTIES
    let tableView = UITableView()
    
    let viewModel = ChatViewModel()
   
    private lazy var chatInputView : ChatInputView = {
        let iv = ChatInputView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 65))
        
       
        return iv
    }()
    
  
    
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackBackgroundColor
        self.navigationItem.hidesBackButton = true
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: K.HomeScreenCellIdentifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        viewModel.delegate = self
       
        chatInputView.textView.delegate = self
       // UITextView().delegate = self
        viewModel.fetchChat()
        chatInputView.sendAction = { [self] input in
            viewModel.getResponse(input: input!) { result in
                switch result {
                case .success(let model):
                    print(model)
                case.failure(let error):
                    print(error)
                }
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let VC = InAppViewController()
            self.show(VC, sender:nil)
        })
        

        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
        
        tableView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.bottom.equalToSuperview()
        }
        self.view.layoutIfNeeded()
        let indexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        
     // self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
       
           return
        }
      // move the root view up by the distance of keyboard height
        
        tableView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.bottom.equalToSuperview().offset(-keyboardSize.height)
        }
        self.view.layoutIfNeeded()
        let indexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
       
  
    //MARK: BUTTON METHODS
    @objc func goSettings() {
     let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func refresh() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    //MARK: UI METHOD
    func setupUI() {
        let button = UIBarButtonItem(image: UIImage(named: K.Images.settings)!, style: .done, target: self, action: #selector(goSettings))
        let refresh = UIBarButtonItem(image: UIImage(named: K.Images.refresh)!, style: .done, target: self, action: #selector(refresh))
      
        navigationItem.rightBarButtonItem = button
        navigationItem.leftBarButtonItem = refresh
        navigationItem.titleView = BarView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.bottom.equalToSuperview()
        }
        
    }

    //MARK: BOTTOM ACCESORY VIEW
    override var inputAccessoryView: UIView? {
        
        get { return chatInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.HomeScreenCellIdentifier, for: indexPath) as! ChatCell
        let chat = viewModel.chatForRow(at: indexPath.row)
       // viewModel.saveChat(chate: chat)
        cell.chat = chat
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
}
//MARK: VIEWMODEL DELEGATE
extension ChatViewController: ViewModelDelegate {
    func responseSuccess() {
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
           
            
            
        }
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.viewModel.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
       
        
    }
}

// MARK: ChatInputDelegate
//extension ChatViewController : ChatInputDelegate {
//
//
//
//
//
//
//    func didPressPassData(text: String?) {
//
//        self.chatInputView.sendAction = {[self] input in
//
//
//
//        }
//
////        self.chatInputView.sendAction = { [self] in
////           // self.view.endEditing(true)
////
////            self.viewModel.getResponse(input: text!) { result in
////                    switch result {
////                    case .success(let model):
////                        print(model)
////                    case.failure(let error):
////                        print(error)
////                }
////            }
////        }
//    }
//
////    func inputView(_ view: ChatInputView, input: String) {
//////        self.chatInputView.sendAction = { [self] in
//////           // self.view.endEditing(true)
//////
//////                self.viewModel.getResponse(input: input) { result in
//////                    switch result {
//////                    case .success(let model):
//////                        print(model)
//////                    case.failure(let error):
//////                        print(error)
//////                }
//////            }
//////        }
////    }
//
//}
//
//
extension ChatViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

//    func textViewDidBeginEditing(_ textView: UITextView) {
//
//
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        tableView.snp.remakeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalToSuperview { view in
//                view.safeAreaLayoutGuide
//            }
//            make.bottom.equalToSuperview()
//        }
//        self.view.layoutIfNeeded()
//    }
//

}
