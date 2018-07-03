//
//  HomeViewController.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ARKit

class HomeViewController: UIViewController {

//    let topHeight: CGFloat = 225
//    let CellHeight: CGFloat = 56
//    let imageWidth: CGFloat = 56
    
    var homeView: HomeView!
    
    var myCar: Car!
    var viewModel: HomeViewModel!
    
//    var topContainerView: UIView!
//    var batteryView: BatteryView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeBackgroundColor()
        navigationItem.title = "Model S"
        
        myCar = Car(model: .s, totalDistance: 570)
        myCar.availableDistance = 320
        
        viewModel = HomeViewModel(carModel: myCar)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if homeView == nil {
            setupSubviews()
        }
    }
    
    func setupSubviews() {
        homeView = HomeView(frame: self.view.bounds)
        self.view.addSubview(homeView)
        
        // AR
        if #available(iOS 11, *) {
            let arVC = ARViewController()
            homeView.sceneButton.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    self?.present(arVC, animated: true, completion: nil)
                })
                .disposed(by: bag)
        }
        
        homeView.distanceBackgroundColor = viewModel.distance.fillColor
        homeView.distanceText = viewModel.distance.text
        homeView.distancePercentage = viewModel.distance.fillPercentage
        
        myCar.insideDegree = 24
        homeView.insideDegree = viewModel.degree
        
        homeView.fanButton.rx.tap
            .subscribe(onNext: { _ in
                // 发送指令，打开空调
            })
            .disposed(by: bag)
        
        homeView.lockButton.rx.tap
            .subscribe(onNext: { _ in
                // 发送指令，解锁/上锁
            })
            .disposed(by: bag)
    }

    deinit {
        print("MainViewController deinit")
    }
}
