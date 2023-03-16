//
//  InAppViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 16.03.2023.
//

import UIKit

final class InAppViewController: UIViewController {
    
    private let titleImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: K.Images.titleIcon)
        iv.sizeToFit()
        return iv
    }()
    
    
    let titleLabel : UILabel = {
      let label = UILabel()
       label.font = UIFont(name: "Inter-Medium", size: 20)
       label.text = "Unlimited chat with gpt for only, \n Try It Now."
       label.textAlignment = .center
       label.numberOfLines = 2
       label.textColor = .labelColor
       return label
   }()
    
    private let weeklyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.weekly), for: .normal)
        button.backgroundColor = .blackBackgroundColor
        return button
    }()
    
    private let monthlyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.monthly), for: .normal)
        button.backgroundColor = .blackBackgroundColor
        return button
    }()
    
    private let annualyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.annualy), for: .normal)
        button.backgroundColor = .blackBackgroundColor
        return button
    }()
    
    private let tryButton = CharmButton(title: "Try It Now")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackBackgroundColor
        setupUI()
   
    }
    
    
    func setupUI() {
        
        let lockView = UIImageView(image: UIImage(named: K.Icons.lock))
        let unlockLabel = UILabel()
        unlockLabel.text = "Unlock to continue"
        unlockLabel.textAlignment = .left
        unlockLabel.font = UIFont(name: "Inter-Bold", size: 15)
        unlockLabel.textColor = .labelColor
       
        view.addSubview(lockView)
        view.addSubview(unlockLabel)
        view.addSubview(titleImage)
        view.addSubview(titleLabel)
  
        view.addSubview(weeklyButton)
        view.addSubview(monthlyButton)
        view.addSubview(annualyButton)
        view.addSubview(tryButton)
        
        
        titleImage.snp.makeConstraints { make in
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.leading.equalToSuperview().offset(130)
            make.trailing.equalToSuperview().offset(-130)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
        
        lockView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalTo(titleImage.snp.leading).offset(-30)
        }
       
        
        unlockLabel.snp.makeConstraints { make in
            make.leading.equalTo(lockView.snp.trailing).inset(5)
            make.centerY.equalTo(lockView.snp.centerY)
            make.width.equalTo(183)
            make.height.equalTo(50)
            
        }
        
        weeklyButton.snp.makeConstraints { make in
            make.top.equalTo(lockView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(106)
        }
        weeklyButton.layer.cornerRadius = 20
        
        monthlyButton.snp.makeConstraints { make in
            make.top.equalTo(weeklyButton.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(106)
        }
        monthlyButton.layer.cornerRadius = 20
        
        
    
        annualyButton.snp.makeConstraints { make in
            make.top.equalTo(monthlyButton.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(106)
        }
        
        annualyButton.layer.cornerRadius = 20
        
    
        
        tryButton.snp.makeConstraints { make in
            make.top.equalTo(annualyButton.snp.bottom).offset(30)
            make.leading.equalTo(annualyButton.snp.leading).offset(8)
            make.trailing.equalTo(annualyButton.snp.trailing).offset(-8)
            make.height.equalTo(60)
        }
    }
    
    
}
