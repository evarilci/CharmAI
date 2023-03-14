//
//  ChatViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

final class ChatViewController: UIViewController {
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationItem.hidesBackButton = true
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: K.HomeScreenCellIdentifier)
    }
    
    @objc func goSettings() {
        print("settings")
    }
    @objc func refresh() {
        
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

