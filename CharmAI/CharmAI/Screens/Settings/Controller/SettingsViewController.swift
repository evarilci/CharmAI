//
//  SettingsViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 16.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    
    let settings = [Settings(image: UIImage(named: K.Images.icon_rateus)!, label: "Rate Us"), Settings(image: UIImage(named: K.Images.icon_contactus)!, label: "Contact Us"), Settings(image: UIImage(named: K.Images.icon_privacypolicy)!, label: "Privacy Policy"), Settings(image: UIImage(named: K.Images.icon_termsofuse)!, label: "Terms of Use"), Settings(image: UIImage(named: K.Images.icon_restorepurchase)!, label: "Restore Purchase") ]
    
    
    let goPremiumButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.goPremium)!.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let tableView: UITableView = {
        let tb = UITableView()
       
        tb.layer.borderWidth = 0.2
        tb.layer.borderColor = UIColor.accentColor.cgColor
        
         return tb
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: K.settingsTableViewIdentifier)
        tableView.isScrollEnabled = false
            
    }
    
    
    
    func setupUI() {
        view.addSubview(goPremiumButton)
        view.addSubview(tableView)
        let goPre = UIAction { _ in
            let vc = InAppViewController()
            self.show(vc, sender: nil)
        }
        goPremiumButton.addAction(goPre, for: .touchUpInside)
        view.backgroundColor = .blackBackgroundColor
        self.navigationItem.backButtonDisplayMode = .minimal
        goPremiumButton.snp.makeConstraints { make in
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }.offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.height.equalTo(76)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(goPremiumButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(360)
        }
        tableView.rowHeight = 72
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 22
    }
    
    
    
}


//MARK:  UITableViewDelegate, UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.settingsTableViewIdentifier, for: indexPath)  as! SettingsTableViewCell
        cell.setting = self.settings[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
