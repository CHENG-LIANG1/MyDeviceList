//
//  ViewController.swift
//  MyDeviceList
//
//  Created by 梁程 on 2021/8/23.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let homeVC = HomeViewController()
        let profileVC = AboutViewController()

        homeVC.tabBarItem = UITabBarItem.init(title: "My Devices", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), tag: 0)

        homeVC.tabBarItem.selectedImage = UIImage(named: "home.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(K.darkBlue)
        
        profileVC.tabBarItem = UITabBarItem.init(title: "About", image: UIImage(named: "info")?.withRenderingMode(.alwaysOriginal), tag: 0)

        profileVC.tabBarItem.selectedImage = UIImage(named: "info.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(K.darkBlue)

        tabBar.unselectedItemTintColor = .black
        UITabBar.appearance().barTintColor = .white
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
        
        let selectedColor   = K.darkBlue

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        let controllerArray = [homeVC, profileVC]
        self.viewControllers = controllerArray.map{(UINavigationController.init(rootViewController: $0))}
    }


}

