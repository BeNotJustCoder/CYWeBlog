//
//  WeStatus.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/30.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import SDWebImage

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
    var pic_urls: [[String: String]]? {
        didSet {
            thumbImageURLs = [NSURL]()
            for dict in pic_urls! {
                thumbImageURLs?.append(NSURL(string: dict["thumbnail_pic"]!)!)
            }
        }
    }
    
    /// 微博作者的用户信息字段
    var user: User?
    /// 属性数组
    private static let properties = ["created_at", "id", "text", "source", "pic_urls", "user"]
    
    /// 预览图片的URL数组
    var thumbImageURLs:[NSURL]?
    
    init(dict:[String : AnyObject]) {
        super.init()
        
        for key in WeStatus.properties {
            if dict[key] == nil || key == "user" {
                continue
            }
            
            if dict[key] != nil {
                setValue(dict[key], forKey: key)
            }
            
            if let userDict = dict["user"] as? [String: AnyObject] {
                user = User(dict: userDict)
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
//            print(array)
            for dict in array {
                statuses.append(WeStatus(dict: dict))
            }
            
            // 缓存缩略图
            cacheThumbnailImages(statuses, finished: finished)
            
            }) { (_, error) -> Void in
//                print(error)
                finished(weStatus: nil, error: error)
        }
    }
    
    private class func cacheThumbnailImages(statuses: [WeStatus], finished: (weStatus:[WeStatus]?, error:NSError?)->()) {
        
        let group = dispatch_group_create()
        // 遍历微博数组，缓存所有的 URL
        for s in statuses {
            // 判断数组是否为空
            if s.thumbImageURLs == nil {
                continue
            }
            
            // 遍历 URL 数组
            for url in s.thumbImageURLs! {
                // 进入调度组
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) in
                    // 离开调度组
                    dispatch_group_leave(group)
                })
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            print("缓存结束 \(NSHomeDirectory())")
            finished(weStatus: statuses, error: nil)
        }
        
    }

}
