//
//  WeStatus.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/30.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit


class WeStatus: NSObject {
    
    /// 创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: String]]?
    /// 微博作者的用户信息字段
    var user: User?
    /// 属性数组
    private static let properties = ["created_at", "id", "text", "source", "pic_urls", "user"]
    
    init(dict:[String : AnyObject]) {
        super.init()
        for key in WeStatus.properties {
            if dict[key] != nil {
                setValue(dict[key], forKey: key)
            }
        }
    }
    
    override var description:String {
        let dict = dictionaryWithValuesForKeys(WeStatus.properties)
        return "\(dict)"
    }
    
    class func loadStatus(finished: (weStatus:[WeStatus]?, error:NSError?)->() ){
        
        let param = ["access_token" : shareUserAccount!.access_token]
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        NetworkTools.sharedNetworkTools().GET(url, parameters: param, success: { (_, jsonData) -> Void in
//            print(jsonData)
            
            let array = jsonData["statuses"] as! [[String : AnyObject]]
            var statuses = [WeStatus]()
            
            for dict in array {
                statuses.append(WeStatus(dict: dict))
            }
            
            finished(weStatus: statuses, error: nil)
            
            }) { (_, error) -> Void in
//                print(error)
                finished(weStatus: nil, error: error)
        }
    }

}
