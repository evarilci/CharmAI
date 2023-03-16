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
        chatInputView.delegate = self
    }
    //MARK: BUTTON METHODS
    @objc func goSettings() {
     let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func refresh() {
        print("refresh")
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
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
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
        
        cell.chat = viewModel.chatForRow(at: indexPath.row)
        cell.layoutIfNeeded()
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
        
    }
}

extension ChatViewController : ChatInputDelegate {
    func inputView(_ view: ChatInputView, input: String) {
        self.chatInputView.sendAction = { [self] in
            self.view.endEditing(true)
            DispatchQueue.main.async {
                self.viewModel.getResponse(input: input) { result in
                    switch result {
                    case .success(let model):
                        print(model)
                    case.failure(let error):
                        print(error)
                        
                    }
                }
            }
           
        }
    }
    
}
