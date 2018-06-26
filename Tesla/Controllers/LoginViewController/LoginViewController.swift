//
//  LoginViewController.swift
//  Tesla
//
//  Created by Ronan on 6/26/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let bottomViewHeight: CGFloat = 255
    let margin: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        setupTopView()
        setupBottomView()
        
        let families = UIFont.familyNames
        print("fonts: \(families)")
        
        let fonts = UIFont.fontNames(forFamilyName: "gotham")
        print("Gotham: \(fonts)")
    
    }
    
    // setup top logo view
    func setupTopView() {
        
    }

    // setup bottom login view
    func setupBottomView() {
        // container
        let container = UIView()
        container.backgroundColor = .white
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.size.height.equalTo(bottomViewHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        // title
        let titleLabel = UILabel()
        titleLabel.text = "Join Tesla"
        titleLabel.font = UIFont.setGotham(.large, weight: .bold)
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(margin)
            make.left.equalTo(margin)
        }
        // country
        // phone number
        // next
        // alternative
    }
}
