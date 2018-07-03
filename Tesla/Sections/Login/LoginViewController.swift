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
    
    var viewModel: LoginViewModel?
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let country = CountryModel(englishName: "china", abbriviation: "cn", code: "+86")
        let model = LoginModel(splashName: "splash", title: "Join Tesla", country: country, numberPlaceholder: "Input any digits", nextName: "login_next", alternativeText: "Login using another way")
        viewModel = LoginViewModel(model: model)
        
        let scrollView = LoginScrollView(frame: self.view.bounds)
        self.view.addSubview(scrollView)
        scrollView.splashImageView.image = viewModel?.splashImage
        scrollView.titleLabel.text = viewModel?.title
        scrollView.countryButton.setImage(viewModel?.countryFlag, for: .normal)
        scrollView.countryButton.setTitle(viewModel?.countryCode, for: .normal)
        scrollView.nextButton.setImage(viewModel?.nextImage, for: .normal)
        scrollView.alternativeButton.setTitle(viewModel?.alternativeText, for: .normal)
        scrollView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let phoneCodeVC = PhoneCodeViewController()
                self?.navigationController?.pushViewController(phoneCodeVC, animated: true)
            })
            .disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    deinit {
        print("LoginViewController deinit")
    }
}
