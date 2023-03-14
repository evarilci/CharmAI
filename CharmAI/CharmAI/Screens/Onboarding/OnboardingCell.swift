//
//  OnboardingCell.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    
 
    
    let onboardingImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: K.Images.onboardingImage1)
        iv.clipsToBounds = true
        return iv
    }()
    private let titleLabelBeginning : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter", size: 27)
        label.text = "Lorem"
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private let titleLabelEnding : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter", size: 27)
        label.text = "Ipsum dolor sit"
        label.textAlignment = .left
        label.textColor = .accentColor
        return label
    }()
    
     let subtitleLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Inter", size: 18)
        label.text = "Ask the bot anything, It's always ready to help!"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
        let pageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: K.Images.slider1)
        iv.clipsToBounds = true
        return iv
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func setupUI() {
        let stack = UIStackView(arrangedSubviews: [titleLabelBeginning,titleLabelEnding])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        backgroundColor = .black
        
        addSubview(onboardingImage)
        addSubview(stack)
        addSubview(subtitleLabel)
      
    
        
        onboardingImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(onboardingImage.snp.width)
        }
        stack.snp.makeConstraints { make in
            make.top.equalTo(onboardingImage.snp.bottom).offset(16)
            make.centerX.equalTo(onboardingImage.snp.centerX)
            make.height.equalTo(50)
            
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
            make.width.equalTo(stack.snp.width)
        }
    
    }
    
    
    func setup(_ slide: OnboardingSlide) {
        onboardingImage.image = slide.image
        titleLabelBeginning.text = slide.beginningTitle
        titleLabelEnding.text = slide.EndingTitle
        subtitleLabel.text = slide.Subtitle
    }
    
}

