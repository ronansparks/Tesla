//
//  LoginBottomView.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

class LoginBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.themeBackgroundColor()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        // 标题
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(UNIVERSAL_MARGIN)
            
        }
        titleLabel.font = UIFont.setGotham(.large, weight: .bold)
        titleLabel.text = "Join Tesla"
        
        // 国旗和区号
        let countryButton = UIButton()
        self.addSubview(countryButton)
        countryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.left.equalToSuperview().offset(UNIVERSAL_MARGIN)
            make.width.equalTo(99)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
        }
        countryButton.backgroundColor = UIColor.themeLightGray()
        countryButton.setImage(UIImage(named: "flag_china"), for: .normal)
        countryButton.setTitle("+86", for: .normal)
        countryButton.setTitleColor(UIColor.themeDarkGray(), for: .normal)
        countryButton.titleLabel?.font = UIFont.setGotham(.middle)
        countryButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -UNIVERSAL_MARGIN_COMPACT)
        countryButton.imageEdgeInsets = UIEdgeInsetsMake(0, -UNIVERSAL_MARGIN_COMPACT, 0, 0)
        
        // 手机号
        let numberTextField = UITextField()
        self.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(countryButton)
            make.left.equalTo(countryButton.snp.right).offset(UNIVERSAL_MARGIN)
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
        }
        numberTextField.backgroundColor = UIColor.themeLightGray()
        numberTextField.font = UIFont.setGotham(.middle)
        numberTextField.placeholder = "Phone Number"
        
        // 发送验证码
        let msgButton = UIButton()
        self.addSubview(msgButton)
        msgButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
        }
        msgButton.setImage(UIImage(named: "send_message"), for: .normal)
        
        // 选择其他方式登录
        let socialButton = UIButton()
        self.addSubview(socialButton)
        socialButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(UNIVERSAL_MARGIN)
            make.top.equalTo(msgButton.snp.bottom).offset(UNIVERSAL_MARGIN)
        }
        socialButton.setTitle("Connect using another way", for: .normal)
        socialButton.titleLabel?.font = UIFont.setGotham(.small, weight: .light)
        socialButton.setTitleColor(UIColor.themeDarkGray(), for: .normal)
    }
}
