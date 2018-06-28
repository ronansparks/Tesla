//
//  PhoneCodeViewController.swift
//  Tesla
//
//  Created by Ronan on 6/28/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneCodeViewController: UIViewController {
    
    var resendButton: UIButton!
    var codeTextView: PhoneCodeView!
    var timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    
    let padding: CGFloat = 30
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Phone Code"
        view.backgroundColor = UIColor.themeLightGray()
        navigationController?.navigationBar.tintColor = UIColor.themeDarkGray()

        setupSubviews()
        startTimer()
    }

    func setupSubviews() {
        resendButton = UIButton()
        self.view.addSubview(resendButton)
        resendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-padding)
            make.centerY.equalToSuperview().offset(-UNIVERSAL_RADIUS_COMPACT)
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
            make.width.equalTo(142)
        }
        resendButton.setTitleColor(UIColor.themeGreen(), for: .normal)
        resendButton.setTitleColor(UIColor.themeRed(), for: .disabled)
        resendButton.titleLabel?.font = UIFont.setGotham(.body, weight: .book)
        resendButton.backgroundColor = UIColor.themeBackgroundColor()
        resendButton.layer.cornerRadius = UNIVERSAL_CORNER_RADIUS
        resendButton.layer.masksToBounds = true
        resendButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.startTimer()
            })
            .disposed(by: bag)
        
        codeTextView = PhoneCodeView()
        self.view.addSubview(codeTextView)
        codeTextView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UNIVERSAL_RADIUS_COMPACT)
            make.bottom.equalTo(resendButton.snp.top).offset(-padding)
        }
        codeTextView.textField.rx.text.orEmpty
            .subscribe(onNext: { [weak self] text in
                if text.count == 6 {
                    self?.succeedToLogin()
                }
            })
            .disposed(by: bag)
    }
    
    // 定时器
    func startTimer() {
        resendButton.isEnabled = false
        codeTextView.textField.text = ""
        
        var count = 60
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        timer.setEventHandler {
            count -= 1
            DispatchQueue.main.async {
                self.resendButton.setTitle("Resend (\(count)s)", for: .normal)
            }
//            print("timer: \(count)")
            if count <= 0 {
                self.timer.cancel()
                DispatchQueue.main.async {
                    self.resendButton.setTitle("Resend", for: .normal)
                    self.resendButton.isEnabled = true
                }
            }
        }
        timer.resume()
    }
    
    // 登录成功
    func succeedToLogin() {
        let tabController = TabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.cancel()
    }
    
    deinit {
        print("PhoneCodeViewController deinit")
    }
}

