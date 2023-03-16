//
//  SettingsViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 16.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    let goPremiumButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.goPremium)!.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    func setupUI() {
        view.addSubview(goPremiumButton)
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
        
        
    }
    
    
    
}
