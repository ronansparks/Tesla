//
//  LoginViewController.swift
//  Tesla
//
//  Created by Ronan on 6/26/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
//
//    let margin: CGFloat = 20
//    let compactMargin: CGFloat = 10
    let bottomViewHeight: CGFloat = 275
    
//    let countryViewWidth: CGFloat = 117
//    let countryViewHeight: CGFloat = 39
//    let countryFlagWidth: CGFloat = 28
//    let countryFlagHeight: CGFloat = 18
    
//    let buttonSize: CGFloat = 44
    
//    var bottomContainer: UIView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.isHidden = true
        setupTopView()
        setupBottomView()
    
    }
    
    // setup top logo view
    func setupTopView() {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height - bottomViewHeight)
        }
        imageView.image = UIImage(named: "welcome")
        imageView.contentMode = .scaleAspectFill
    }

    // setup bottom login view
    func setupBottomView() {
        let frame = CGRect(x: 0, y: SCREEN_HEIGHT - bottomViewHeight, width: SCREEN_WIDTH, height: bottomViewHeight)
        let bottomView = LoginBottomView(frame: frame)
        view.addSubview(bottomView)
        // container
//        bottomContainer = UIView()
//        view.addSubview(bottomContainer)
//        bottomContainer.snp.makeConstraints { make in
//            make.height.equalTo(bottomViewHeight)
//            make.left.right.bottom.equalToSuperview()
//        }
//        bottomContainer.backgroundColor = .white
//
//
//        // title
//        let titleLabel = UILabel()
//        bottomContainer.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.left.top.equalTo(margin)
//        }
//        titleLabel.text = "Join Tesla"
//        titleLabel.font = UIFont.setGotham(.large, weight: .bold)
//
//
//        // country
//        let countryContainer = UIView()
//        bottomContainer.addSubview(countryContainer)
//        countryContainer.snp.makeConstraints { make in
//            make.height.equalTo(countryViewHeight)
//            make.width.equalTo(countryViewWidth)
//            make.left.equalToSuperview().offset(margin)
//            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
//        }
//        countryContainer.backgroundColor = UIColor.themeGray1()
//
//        let countryImageView = UIImageView()
//        countryContainer.addSubview(countryImageView)
//        countryImageView.snp.makeConstraints { make in
//            make.width.equalTo(countryFlagWidth)
//            make.height.equalTo(countryFlagHeight)
//            make.left.equalToSuperview().offset(compactMargin)
//            make.centerY.equalToSuperview()
//        }
//        countryImageView.image = UIImage(named: "china_flag")
//        countryImageView.contentMode = .scaleAspectFit
//
//        let countryCodeLabel = UILabel()
//        countryContainer.addSubview(countryCodeLabel)
//        countryCodeLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(countryImageView.snp.right).offset(compactMargin)
//        }
//        countryCodeLabel.font = UIFont.setGotham(.middle)
//        countryCodeLabel.text = "+86"
//
//        let arrowImageView = UIImageView()
//        countryContainer.addSubview(arrowImageView)
//        arrowImageView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(countryCodeLabel.snp.right).offset(compactMargin)
//        }
//        arrowImageView.image = UIImage(named: "arrow_down")
//
//        // phone number
//        let numberContainer = UIView()
//        bottomContainer.addSubview(numberContainer)
//        numberContainer.snp.makeConstraints { make in
//            make.height.equalTo(countryContainer)
//            make.top.equalTo(countryContainer)
//            make.left.equalTo(countryContainer.snp.right).offset(margin)
//            make.right.equalToSuperview().offset(-margin)
//
//        }
//        numberContainer.backgroundColor = UIColor.themeGray1()
//
//        let numberTextField = UITextField()
//        numberContainer.addSubview(numberTextField)
//        numberTextField.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.right.equalToSuperview().offset(compactMargin)
//        }
//        numberTextField.font = UIFont.setGotham(.middle)
//        numberTextField.keyboardType = .numberPad
//
//        // next
//        let nextButton = UIButton()
//        bottomContainer.addSubview(nextButton)
//        nextButton.snp.makeConstraints { make in
//            make.size.equalTo(buttonSize)
//            make.top.equalTo(numberContainer.snp.bottom).offset(margin)
//            make.right.equalToSuperview().offset(-margin)
//        }
//        nextButton.setImage(UIImage(named: "next"), for: .normal)
//        nextButton.rx.tap
//            .subscribe(onNext: {
//                let tabBarVC = TabBarViewController()
//                UIApplication.shared.keyWindow?.rootViewController = tabBarVC
//            })
//            .disposed(by: bag)
////        let numberValid = numberTextField.rx.text.orEmpty
////            .map { $0.count > 1}
////            .share(replay: 1)
////        numberValid.bind(to: nextButton.rx.isEnabled)
////            .disposed(by: bag)
//
//        // alternative
//        let alternativeLabel = UILabel()
//        bottomContainer.addSubview(alternativeLabel)
//        alternativeLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(margin)
//            if #available(iOS 11.0, *) {
//                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-margin)
//            } else {
//                // Fallback on earlier versions
//                make.bottom.equalToSuperview().offset(-margin)
//            }
//        }
//        alternativeLabel.font = UIFont.setGotham(.small, weight: .light)
//        alternativeLabel.text = "Connect using another way"
//
    }
}
