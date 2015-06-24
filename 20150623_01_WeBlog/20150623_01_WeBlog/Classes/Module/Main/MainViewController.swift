//
//  MainViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
        
        let tabBar = MainTabBar()
        setValue(tabBar, forKey: "tabBar")
    }
    
    private func setupControllers() {
        var vc:UIViewController = HomeTableViewController()
        vc.title = "首页"
        vc.tabBarItem.image = UIImage(imageLiteral: "tabbar_home")
        var nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
        vc = MessageTableViewController()
        vc.title = "消息"
        vc.tabBarItem.image = UIImage(imageLiteral: "tabbar_message_center")
        nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
        vc = DiscoverTableViewController()
        vc.title = "发现"
        vc.tabBarItem.image = UIImage(imageLiteral: "tabbar_discover")
        nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
        vc = ProfileTableViewController()
        vc.title = "我"
        vc.tabBarItem.image = UIImage(imageLiteral: "tabbar_profile")
        nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
    }

}
