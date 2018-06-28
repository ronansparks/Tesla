//
//  LargeNavigationBar.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

class LargeNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with title: String) {
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight: CGFloat = 140
        
        let viewFrame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        self.init(frame: viewFrame)
        prepareView(title: title)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 140)
    }
    
    func prepareView(title: String) {
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        titleLabel.font = UIFont.setGotham(.large, weight: .bold)
        titleLabel.textColor = UIColor.themeDarkGray()
        titleLabel.text = title
        
        let leftButton = UIButton()
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.left.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        leftButton.titleLabel?.text = "Back"
        
    }
}
