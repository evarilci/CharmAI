//
//  SettingsTableViewCell.swift
//  CharmAI
//
//  Created by Eymen Varilci on 16.03.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    var setting: Settings? {
        didSet {
            configure(stting: setting!)
        }
    }
    
    var iconImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: K.Images.restorepurchase)
        return iv
    }()
    
    
    var label : UILabel = {
       let label = UILabel()
        label.text = "Restore Purchases"
        label.font = UIFont(name: "Inter-Medium", size: 15)
        label.textColor = .labelColor
        return label
    }()
    
    
    let arrowView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: K.Images.rightArrow)
         return iv
     }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(iconImageView)
        addSubview(label)
        addSubview(arrowView)
        
        
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(32)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(25)
            make.width.equalTo(120)
            
        }
        
        
    }
    
    
    func configure(stting: Settings) {
        self.label.text = setting!.label
        self.iconImageView.image = setting!.image
        
        
    }
    
}
