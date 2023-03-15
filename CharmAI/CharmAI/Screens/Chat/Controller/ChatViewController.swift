//
//  ChatViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

final class ChatViewController: UIViewController {
    let tableView = UITableView()
  
    private lazy var chatInputView = ChatInputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 65))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationItem.hidesBackButton = true
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: K.HomeScreenCellIdentifier)
        tableView.backgroundColor = .black
    }
    
    @objc func goSettings() {
        print("settings")
    }
    @objc func refresh() {
        print("refresh")
    }
    
    func setupUI() {
        let button = UIBarButtonItem(image: UIImage(named: K.Images.settings)!, style: .done, target: self, action: #selector(goSettings))
        let refresh = UIBarButtonItem(image: UIImage(named: K.Images.refresh)!, style: .done, target: self, action: #selector(refresh))
        
       
       
        
        
        navigationItem.rightBarButtonItem = button
        navigationItem.leftBarButtonItem = refresh
        navigationItem.titleView = BarView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        tableView.rowHeight = 60
    }
    override var inputAccessoryView: UIView? {
        
        get { return chatInputView }
    }
  
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.HomeScreenCellIdentifier, for: indexPath) as! ChatCell
        
        
        
        return cell
    }
}

