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
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let crossButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: K.Images.cross), for: .normal)
        button.backgroundColor = .clear
        return button
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
        button.setImage(UIImage(named: K.Images.weekly)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.setImage(UIImage(named: K.Images.selectedWeekly)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        
        button.backgroundColor = .blackBackgroundColor
        return button
    }()
    
    private let monthlyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.monthly)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.setImage(UIImage(named: K.Images.monthlySelected)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        button.backgroundColor = .blackBackgroundColor
        return button
    }()
    
    private let annualyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: K.Images.annualy)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: K.Images.selectedAnnual)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        button.backgroundColor = .blackBackgroundColor
        return button
    }()
    
    private let tryButton = CharmButton(title: "Try It Now")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackBackgroundColor
        let cross = UIBarButtonItem(image: UIImage(named: K.Images.cross), style: .done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = cross
        self.navigationItem.hidesBackButton = true
        setupUI()
   
    }
    
    @objc func buttonStates(_ sender: UIButton) {
        switch sender {
        case weeklyButton:
            if weeklyButton.isSelected == true {
                weeklyButton.isSelected = false
                monthlyButton.isSelected = false
                annualyButton.isSelected = false
            } else {
                weeklyButton.isSelected = true
                monthlyButton.isSelected = false
                annualyButton.isSelected = false
            }
        case monthlyButton:
            
            if monthlyButton.isSelected == true {
                weeklyButton.isSelected = false
                monthlyButton.isSelected = false
                annualyButton.isSelected = false
            } else {
                monthlyButton.isSelected = true
                weeklyButton.isSelected = false
               
                annualyButton.isSelected = false
            }
            
        case annualyButton:
            if annualyButton.isSelected == true {
                weeklyButton.isSelected = false
                monthlyButton.isSelected = false
                annualyButton.isSelected = false
            } else {
                annualyButton.isSelected = true
                weeklyButton.isSelected = false
                monthlyButton.isSelected = false
            }
            
        default:
            print("no such button")
        }
       
    }
    @objc func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        
        let lockView = UIImageView(image: UIImage(named: K.Icons.lock))
        let unlockLabel = UILabel()
        unlockLabel.text = "Unlock to continue"
        unlockLabel.textAlignment = .left
        unlockLabel.font = UIFont(name: "Inter-Bold", size: 15)
        unlockLabel.textColor = .labelColor
        let termsofuseImage = UIImageView(image: UIImage(named: K.Images.termsofuse))
        weeklyButton.addTarget(self, action: #selector(buttonStates), for: UIControl.Event.touchUpInside)
        monthlyButton.addTarget(self, action: #selector(buttonStates), for: UIControl.Event.touchUpInside)
        annualyButton.addTarget(self, action: #selector(buttonStates), for: UIControl.Event.touchUpInside)
       
        
        let stack = UIStackView(arrangedSubviews: [weeklyButton,monthlyButton,annualyButton])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        
        
      //  view.addSubview(crossButton)
        view.addSubview(lockView)
        view.addSubview(unlockLabel)
        view.addSubview(titleImage)
        view.addSubview(titleLabel)
        view.addSubview(stack)
        view.addSubview(tryButton)
        view.addSubview(termsofuseImage)
        
//        crossButton.snp.makeConstraints { make in
//            make.top.equalToSuperview { view in
//                view.safeAreaLayoutGuide
//            }.offset(-30)
//            make.trailing.equalToSuperview().offset(-20)
//            make.width.height.equalTo(50)
//        }
        
        titleImage.snp.makeConstraints { make in
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.leading.equalToSuperview().offset(130)
            make.trailing.equalToSuperview().offset(-130)
            make.height.equalTo(titleImage.snp.width).multipliedBy(0.15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
        
        lockView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(titleImage.snp.leading).offset(-30)
        }
       
        
        unlockLabel.snp.makeConstraints { make in
            make.leading.equalTo(lockView.snp.trailing).inset(5)
            make.centerY.equalTo(lockView.snp.centerY)
            make.width.equalTo(183)
            make.height.equalTo(50)
            
        }
       
        termsofuseImage.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.bottom.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        
        tryButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(tryButton.snp.width).multipliedBy(0.2)
            make.bottom.equalTo(termsofuseImage.snp.top).offset(-16)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(unlockLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(tryButton.snp.top).offset(-8)
        }
        
        
        
    }
}
