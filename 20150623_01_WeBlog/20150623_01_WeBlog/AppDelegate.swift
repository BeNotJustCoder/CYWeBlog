//
//  AppDelegate.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = defaultRootViewController()
        window?.makeKeyAndVisible()
        
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchViewController:", name: SwitchRootVCNotification, object: nil)
        
        //设置网络
        setupNetwork()
        
        setupApperance()
        
        let isUpdate = isAppUpdate()
        print("是否更新: \(isUpdate)")
        return true
    }
    
    /// 设置全局外观
    private func setupApperance() {
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    /// 设置网络
    private func setupNetwork() {
        // 设置网路指示器
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        // 设置网络缓存
        let urlCache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        NSURLCache.setSharedURLCache(urlCache)
    }
    
    func defaultRootViewController()->UIViewController {
        if isAppUpdate() {
            return NewFeatureViewController()
        }
        return shareUserAccount != nil ?  WelcomeViewController() : MainViewController()
    }
    
    func switchViewController(notification:NSNotification) {
        if notification.object as! Bool == true {
            window?.rootViewController = MainViewController()
        }
    }
    
    /// 是否新版本
    private func isAppUpdate() -> Bool {
        
        // 1. 获取应用程序`当前版本`
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        print(currentVersion)
        
        // 2. 获取应用程序`之前的版本`，从用户偏好中读取
        let versionKey = "preVersion"
        let preVersion = NSUserDefaults.standardUserDefaults().objectForKey(versionKey)
        print(preVersion)
        
        // 3. 将`当前版本`写入用户偏好
        NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionKey)
        
        if preVersion == nil {
            return true
        }
        
        return currentVersion != preVersion as! String
    }

}

