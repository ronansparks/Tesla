//
//  PhoneCodeValidView.swift
//  Tesla
//
//  Created by Ronan on 7/2/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneCodeValidView: UIView, UITextFieldDelegate {
    
    var codeTextField: UITextField!
    var resendButton: UIButton!
    
    let codeCount = 6
    let bag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.themeLightGray()
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        print(self.bounds)
        resendButton = UIButton()
        self.addSubview(resendButton)
        resendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.centerY.equalToSuperview().offset(-UNIVERSAL_MARGIN)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
            make.width.equalTo(142)
        }
        resendButton.setTitleColor(UIColor.themeGreen(), for: .normal)
        resendButton.setTitleColor(UIColor.themeRed(), for: .disabled)
        resendButton.titleLabel?.font = UIFont.setGotham(.body, weight: .book)
        resendButton.backgroundColor = UIColor.themeBackgroundColor()
        resendButton.layer.cornerRadius = UNIVERSAL_CORNER_RADIUS
        resendButton.layer.masksToBounds = true
        
        let totalWidth = SCREEN_WIDTH - UNIVERSAL_MARGIN * 2
        codeTextField = UITextField()
        self.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { make in
            make.width.equalTo(totalWidth)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
            make.bottom.equalTo(resendButton.snp.top).offset(-UNIVERSAL_RADIUS_COMPACT)
            make.centerX.equalToSuperview()
        }
        codeTextField.textAlignment = .center
        codeTextField.font = UIFont.setGotham(.title)
        codeTextField.keyboardType = .numberPad
        codeTextField.backgroundColor = UIColor.themeBackgroundColor()
        codeTextField.becomeFirstResponder()
        codeTextField.delegate = self
        codeTextField.rx.controlEvent(UIControlEvents.editingChanged)
            .subscribe(onNext: { [weak self] _ in
                if let text = self?.codeTextField.text {
                    if text.count >= (self?.codeCount)! {
                        let str = String(text[text.startIndex..<String.Index(encodedOffset: 6)])
                        self?.codeTextField.text = str
                        self?.codeTextField.resignFirstResponder()
                    }
                    let attr = [NSAttributedStringKey.kern: 20]
                    self?.codeTextField.attributedText = NSAttributedString(string: (self?.codeTextField.text)!, attributes: attr)
                }
            })
            .disposed(by: bag)
        
        
        
    }
}

extension PhoneCodeValidView {
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
