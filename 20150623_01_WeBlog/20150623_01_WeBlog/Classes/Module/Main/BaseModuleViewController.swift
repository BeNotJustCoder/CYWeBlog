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
        if isUserLogin == true {
            super.loadView()
        }
        else {
            setupVisitorView()
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "onRegisterBtnClicked")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "onLoginBtnClicked")
        }
    }

    func setupVisitorView() {
        visitorView = VisitorLoginView()
        visitorView?.backgroundColor = UIColor.blueColor()
        view = visitorView
    }
    
    
    func onRegisterBtnClicked() {
        print("注册")
    }

    func onLoginBtnClicked() {
        print("登录")
    }

}
