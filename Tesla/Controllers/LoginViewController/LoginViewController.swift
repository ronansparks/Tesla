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
    
    var scrollView: UIScrollView!
    var containerView: UIView!
    
    let bottomViewHeight: CGFloat = 275
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.isHidden = true
        
        scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .yellow
        scrollView.addSubview(containerView)
        
        setupTopView()
        setupBottomView()
        setupNotification()
    
    }
    
    // setup top logo view
    func setupTopView() {
        let topView = UIView()
        containerView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT - bottomViewHeight)
        }
        
        let imageView = UIImageView()
        topView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.image = UIImage(named: "welcome")
        imageView.contentMode = .scaleAspectFill
    }

    // setup bottom login view
    func setupBottomView() {
        let bottomView = LoginBottomView(frame: CGRect.zero)
        containerView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(bottomViewHeight)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bottomView.countryButton.rx.tap
            .subscribe(onNext: { _ in
                print("click on country flag")
            })
            .disposed(by: bag)
        
        bottomView.msgButton.rx.tap
            .subscribe(onNext: { _ in
                print("jump")
                let tabController = TabBarViewController()
                UIApplication.shared.keyWindow?.rootViewController = tabController
            })
            .disposed(by: bag)
    }
    
    func setupNotification() {
        // 键盘弹出
        NotificationCenter.default.rx
            .notification(Notification.Name.UIKeyboardWillShow)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { [weak self] notification in
                let keyboardRect: CGRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
                let moveHeight = keyboardRect.size.height
                self?.scrollView.contentOffset = CGPoint(x: 0, y: moveHeight)
            })
            .disposed(by: bag)
        // 键盘收起
        NotificationCenter.default.rx
            .notification(Notification.Name.UIKeyboardWillHide)
            .subscribe(onNext: { [weak self] _ in
                self?.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            })
            .disposed(by: bag)
    }
    
    deinit {
        print("view ye  deinit")
    }
}
