//
//  ControlViewController.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeDarkGray()
        navigationItem.title = "Control"
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        let imageView = UIImageView(image: UIImage(named: "control_bg"))
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let headlightButton = UIButton()
        self.view.addSubview(headlightButton)
        headlightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.top.equalToSuperview().offset(UNIVERSAL_MARGIN * 2)
        }
        headlightButton.setImage(UIImage(named: "control_headlight_normal"), for: .normal)
        headlightButton.setImage(UIImage(named: "control_headlight_highlighted"), for: .highlighted)
        
        let hornButton = UIButton()
        self.view.addSubview(hornButton)
        hornButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.top.equalTo(headlightButton.snp.bottom).offset(UNIVERSAL_MARGIN * 2)
        }
        hornButton.setImage(UIImage(named: "control_horn_normal"), for: .normal)
        hornButton.setImage(UIImage(named: "control_horn_highlighted"), for: .highlighted)
        
        let fanButton = UIButton()
        self.view.addSubview(fanButton)
        fanButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.top.equalTo(hornButton.snp.bottom).offset(UNIVERSAL_MARGIN * 2)
        }
        fanButton.setImage(UIImage(named: "control_fan_normal"), for: .normal)
        fanButton.setImage(UIImage(named: "control_fan_highlighted.pdf"), for: .highlighted)
        
        
        let summonButton = UIButton()
        self.view.addSubview(summonButton)
        summonButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.bottom.equalToSuperview().offset(-UNIVERSAL_MARGIN * 2)
        }
        summonButton.setImage(UIImage(named: "control_summon_normal"), for: .normal)
        summonButton.setImage(UIImage(named: "control_summon_highlighted"), for: .highlighted)
        
        let chargeButton = UIButton()
        self.view.addSubview(chargeButton)
        chargeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.bottom.equalTo(summonButton.snp.top).offset(-UNIVERSAL_MARGIN * 2)
        }
        chargeButton.setImage(UIImage(named: "control_charge_normal"), for: .normal)
        chargeButton.setImage(UIImage(named: "control_charge_highlighted"), for: .highlighted)
    }

}
