//
//  UserAccount.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/27.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

var shareUserAccount = UserAccount.loadAccount()

class UserAccount: NSObject,NSCoding {
    
    static var isUserLogin = false
    
    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String
    /// access_token的生命周期，单位是秒数(实际是数值！)5
    var expires_in: NSTimeInterval
    
    /// 过期日期
    /// 程序创建人有5年有效期，普通用户有效期三天
    var expiresDate: NSDate
    
    /// 当前授权用户的UID
    var uid: String
    
    /// 友好显示名称
    var name: String?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    init(dict: [String: AnyObject]) {
        access_token = dict["access_token"] as! String
        expires_in = dict["expires_in"] as! NSTimeInterval
        uid = dict["uid"] as! String
        
        expiresDate = NSDate(timeIntervalSinceNow: expires_in)
    }
    
    static let accountFilePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!.stringByAppendingPathComponent("userAccount")
    
    /// 从沙盒中读取
    class func loadAccount() -> UserAccount? {
//        return nil
        
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountFilePath) as? UserAccount {
            // 判断日期是否过期，根当前系统时间进行`比较`，低于当前系统时间，就认为过期
            // 过期日期`大于`当前日期，结果应该是降序
            print("读取用户数据\(account)")
            if account.expiresDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                UserAccount.isUserLogin = true
                
                return account
            }
        }
        print("读取用户数据:nil")
        return nil
    }
    
    /// 保存到沙盒
    func saveAccount() {
        
        let res = NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountFilePath)
        print("保存用户数据:\(res)")
    }
    
    
    func loadUserInfo(finished:(account:UserAccount?, error:NSError?) -> ()) {
        
        let params = [
            "access_token": access_token,"uid": uid
            ]
        
        NetworkTools.sharedNetworkTools().GET("2/users/show.json", parameters: params, success: { (_, jsonData) -> Void in
//            print(jsonData)
            
            let dict = jsonData as! [String: AnyObject]
            self.name = dict["name"] as? String
            self.avatar_large = dict["avatar_large"] as? String
            
            self.saveAccount()
            
            UserAccount.isUserLogin = true
            // 通知调用方，处理完成
            finished(account: self, error: nil)
            
            }) { (_, error) -> Void in
                print(error)
                finished(account: nil,error: error)
        }
        
    }
    
    //encoder/decoder方法
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as! String
        uid = aDecoder.decodeObjectForKey("uid") as! String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as! NSDate
        
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }

}
