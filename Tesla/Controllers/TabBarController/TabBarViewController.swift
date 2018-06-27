//
//  TabBarViewController.swift
//  Tesla
//
//  Created by Ronan on 6/27/18.
//  Copyright © 2018 Ronan. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController()
    }
    
    private func addChildViewController() {
        setChildViewController(MainViewController(), imageName: "tabbar_home")
        setChildViewController(ControlViewController(), imageName: "tabbar_control")
        setChildViewController(ProfileViewController(), imageName: "tabbar_profile")
    }
    
    private func setChildViewController(_ controller: UIViewController, title: String = "", imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        
        let navigationVC = RootNavigationViewController(rootViewController: controller)
        addChildViewController(navigationVC)
    }
    
}

//private func setChildViewController(_ childViewController: UIViewController, title: String, imageName: String) {
//    if UserDefaults.standard.bool(forKey: kIsNight) {
//        setNightChildController(controller: childViewController, imageName: imageName)
//    }
//    else {
//        setDayChildController(controller: childViewController, imageName: imageName)
//    }
//    childViewController.title = title
//    childViewController.tabBarItem.title = ""
//
//    let navVC = RootNavigationController(rootViewController: childViewController)
//    addChildViewController(navVC)
//}
