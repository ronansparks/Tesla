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
    
    var timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    var codeView: PhoneCodeValidView!
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Phone Code"
        view.backgroundColor = UIColor.themeLightGray()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if codeView == nil {
            setupSubviews()
            startTimer()
        }
    }
    
    func setupSubviews() {
        codeView = PhoneCodeValidView(frame: self.view.bounds)
        self.view.addSubview(codeView)
        codeView.resendButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.startTimer()
            })
            .disposed(by: bag)
        
        codeView.codeTextField.rx.text.orEmpty
            .subscribe(onNext: { [weak self] text in
                if text.count == 6 {
                    self?.succeedToLogin()
                }
            })
            .disposed(by: bag)
    }

    // 定时器
    func startTimer() {
        codeView.resendButton.isEnabled = false
        codeView.codeTextField.text = ""
        
        var count = 60
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        timer.setEventHandler {
            count -= 1
            DispatchQueue.main.async {
                self.codeView.resendButton.setTitle("Resend (\(count)s)", for: .normal)
            }
            if count <= 0 {
                self.timer.cancel()
                DispatchQueue.main.async {
                    self.codeView.resendButton.setTitle("Resend", for: .normal)
                    self.codeView.resendButton.isEnabled = true
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

