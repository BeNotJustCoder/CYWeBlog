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
    
    
    /// 设置子控制器
    private func setupControllers() {
        
        var data:NSData?
        let url = NSBundle.mainBundle().URLForResource("ControllersSetting.json", withExtension: nil)
        do {
            data = try NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached)
        }
        catch {
            print(error)
        }
 
        do {
            let array = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            for dict in array as! [[String:String]] {
                print(dict)
                setupSubController(dict["vcName"]!, vcTitle: dict["vcTitle"]!, vcItemImg: dict["vcItemImage"]!)
            }
        }
        catch {
            print(error)
            setupSubController("HomeTableViewController", vcTitle: "首页", vcItemImg: "tabbar_home")
            setupSubController("MessageTableViewController", vcTitle: "消息", vcItemImg: "tabbar_message_center")
            setupSubController("DiscoverTableViewController", vcTitle: "发现", vcItemImg: "tabbar_discover")
            setupSubController("ProfileTableViewController", vcTitle: "我", vcItemImg: "tabbar_profile")
        }
        
    }
    
    private func setupSubController(vcName:String, vcTitle:String, vcItemImg:String) {
//        print(NSBundle.mainBundle().infoDictionary)
        
        let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        print(namespace)
        let clsName = "_0150623_01_WeBlog"+"."+vcName
        let cls:AnyClass = NSClassFromString(clsName)!
        
//        print(cls)
        let vc:UIViewController = cls.alloc() as! UIViewController
        
//        let vc:UIViewController = HomeTableViewController()
        vc.title = vcTitle
        vc.tabBarItem.image = UIImage(imageLiteral: vcItemImg)
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
    }

}
