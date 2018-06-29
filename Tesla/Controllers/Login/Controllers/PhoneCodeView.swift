//
//  PhoneCodeView.swift
//  Tesla
//
//  Created by Ronan on 6/28/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneCodeView: UIView, UITextFieldDelegate {
    
    var borderColor: UIColor!
    var codeCount: Int!
    let padding: CGFloat = 10
    let width: CGFloat = 44
    
    var textField: UITextField!
    let bag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        borderColor = UIColor.themeDarkGray()
        codeCount = 6
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        let totalWidth = (width + padding) * CGFloat(codeCount) - CGFloat(codeCount)
        textField = UITextField()
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.width.equalTo(totalWidth)
            make.height.equalTo(width)
            make.center.equalToSuperview()
        }
        textField.textAlignment = .center
        textField.font = UIFont.setGotham(.title)
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor.themeBackgroundColor()
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.rx.controlEvent(UIControlEvents.editingChanged)
            .subscribe(onNext: { [weak self] _ in
                if let text = self?.textField.text {
                    if text.count >= (self?.codeCount)! {
                        let str = String(text[text.startIndex..<String.Index(encodedOffset: 6)])
                        self?.textField.text = str
                        self?.textField.resignFirstResponder()
                    }
                    let attr = [NSAttributedStringKey.kern: 20]
                    self?.textField.attributedText = NSAttributedString(string: (self?.textField.text)!, attributes: attr)
                }
            })
            .disposed(by: bag)
    }
}

extension PhoneCodeView {
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

