//
//  BaseModuleViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/24.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class BaseModuleViewController: UITableViewController {
    
    var isUserLogin:Bool = false
    
    var visitorView:VisitorLoginView?
    
    override func loadView() {
        
//        isUserLogin = shareUserAccount != nil
        isUserLogin = true
        
        if isUserLogin == true {
            super.loadView()
        }
        else {
            setupVisitorView()
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "onLeftBarBtnClicked")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "onRightBarBtnClicked")

        }
    }
    
//    func setNavBarItemTitle(leftTitle:String, rightTitle:String) {
//        navigationItem.leftBarButtonItem?.title = leftTitle
//        navigationItem.rightBarButtonItem?.title = rightTitle
//    }

    func setupVisitorView() {
        visitorView = VisitorLoginView()
//        visitorView?.backgroundColor = UIColor.blueColor()
        view = visitorView
    }
    
    
    func onLeftBarBtnClicked() {
        print("注册")
    }

    func onRightBarBtnClicked() {
        print("登录")
        let oauthVc = OAuthViewController()
        let nav = UINavigationController(rootViewController: oauthVc)
        
        presentViewController(nav, animated: true, completion: nil)
    }
}
