//
//  LoginScrollView.swift
//  Tesla
//
//  Created by Ronan on 7/2/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginScrollView: UIScrollView, UITextFieldDelegate {

    var splashImageView: UIImageView!
    var titleLabel: UILabel!
    var countryButton: UIButton!
    var numberTextField: UITextField!
    var nextButton: UIButton!
    var alternativeButton: UIButton!
    
    let bottomHeight: CGFloat = 275
    let bag = DisposeBag()
    let minimumNumber = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        if #available(iOS 11, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        
        setupSubviews()
        setupNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        let containerView = UIView(frame: self.bounds)
        self.addSubview(containerView)
        // 顶部启动图
        splashImageView = UIImageView()
        containerView.addSubview(splashImageView)
        splashImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(SCREEN_HEIGHT - bottomHeight)
        }
        splashImageView.contentMode = .scaleAspectFill
        
        titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(splashImageView.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.left.equalToSuperview().offset(UNIVERSAL_MARGIN)
        }
        titleLabel.font = UIFont.setGotham(.largeTitle, weight: .bold)
        
        countryButton = UIButton()
        containerView.addSubview(countryButton)
        countryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.left.equalToSuperview().offset(UNIVERSAL_MARGIN)
            make.width.equalTo(99)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
        }
        countryButton.backgroundColor = UIColor.themeLightGray()
        countryButton.setTitleColor(UIColor.themeDarkGray(), for: .normal)
        countryButton.titleLabel?.font = UIFont.setGotham(.title)
        countryButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -UNIVERSAL_MARGIN_COMPACT)
        countryButton.imageEdgeInsets = UIEdgeInsetsMake(0, -UNIVERSAL_MARGIN_COMPACT, 0, 0)
        
        numberTextField = UITextField()
        containerView.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(countryButton)
            make.left.equalTo(countryButton.snp.right).offset(UNIVERSAL_MARGIN)
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
        }
        numberTextField.backgroundColor = UIColor.themeLightGray()
        numberTextField.font = UIFont.setGotham(.title)
        numberTextField.keyboardType = .numberPad
        numberTextField.delegate = self
        numberTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.numberTextField.resignFirstResponder()
            })
            .disposed(by: bag)
        
        // 发送验证码
        nextButton = UIButton()
        containerView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(UNIVERSAL_MARGIN)
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
        }
        // 绑定，至少输入3位数字，可点击按钮
        let validNumber = numberTextField.rx.text.orEmpty
            .map { $0.count >= self.minimumNumber }
            .share(replay: 1)
        validNumber.bind(to: nextButton.rx.isEnabled)
            .disposed(by: bag)
        
        // 选择其他方式登录
        alternativeButton = UIButton()
        containerView.addSubview(alternativeButton)
        alternativeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(UNIVERSAL_MARGIN)
            make.top.equalTo(nextButton.snp.bottom).offset(UNIVERSAL_MARGIN)
        }
        alternativeButton.titleLabel?.font = UIFont.setGotham(.body, weight: .light)
        alternativeButton.setTitleColor(UIColor.themeMidGray(), for: .normal)
    }
    
    func setupNotification() {
        // 键盘弹出
        NotificationCenter.default.rx
            .notification(Notification.Name.UIKeyboardWillShow)
            .subscribe(onNext: { [weak self] notification in
                let keyboardRect: CGRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
                let moveHeight = keyboardRect.size.height
                self?.contentOffset = CGPoint(x: 0, y: moveHeight)
            })
            .disposed(by: bag)
        // 键盘收起
        NotificationCenter.default.rx
            .notification(Notification.Name.UIKeyboardWillHide)
            .subscribe(onNext: { [weak self] _ in
                self?.contentOffset = CGPoint(x: 0, y: 0)
            })
            .disposed(by: bag)
    }
    
}

extension LoginScrollView {
    // 过滤非数字
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 如果是删除符号，不处理
        if string.isEmpty {
            return true
        }
        let scan = Scanner(string: string)
        var intValue = 0
        let result = scan.scanInt(&intValue) && scan.isAtEnd
        return result
    }
}

