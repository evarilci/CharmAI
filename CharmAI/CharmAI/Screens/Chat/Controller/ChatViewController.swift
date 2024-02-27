//
//  ChatViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit
import RevenueCat


final class ChatViewController: UIViewController {
    //MARK: PROPERTIES
    let tableView = UITableView()
    let defaults = UserDefaults.standard
    let viewModel = ChatViewModel()
    var isPremium : Bool?
    private lazy var chatInputView : ChatInputView = {
        let iv = ChatInputView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 65))
        return iv
    }()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        isPremium = defaults.bool(forKey: "premium")
        view.backgroundColor = .blackBackgroundColor
        self.navigationItem.hidesBackButton = true
        setupUI()
        viewModel.fetchChat()
        chatInputView.sendAction = { [self] input in
//            viewModel.getResponse(input: input!) { result in
//                switch result {
//                case .success(let model):
//                    print(model)
//                case.failure(let error):
//                    print(error)
//                }
//            }
        }
        
        if !isPremium! {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                let VC = InAppViewController()
                VC.modalTransitionStyle = .coverVertical
                self.show(VC, sender:nil)
            })
        }
        
        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPremium = defaults.bool(forKey: "premium")
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
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
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
        
        let input = defaults.string(forKey: "last") ?? "NO LAST MESSAGE"
//        viewModel.getResponse(input: input) { result  in
//            switch result {
//            case .success(let model):
//                print(model)
//            case.failure(let error):
//                print(error)
//            }
//            
//        }
 
    }
    //MARK: UI METHOD
    func setupUI() {
        let button = UIBarButtonItem(image: UIImage(named: K.Images.settings)!, style: .done, target: self, action: #selector(goSettings))
        let refresh = UIBarButtonItem(image: UIImage(named: K.Images.refresh)!, style: .done, target: self, action: #selector(refresh))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: K.HomeScreenCellIdentifier)
        viewModel.delegate = self
        chatInputView.textView.delegate = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
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
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
