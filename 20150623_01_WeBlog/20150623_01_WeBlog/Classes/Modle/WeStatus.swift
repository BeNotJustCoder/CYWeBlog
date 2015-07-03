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
    private static let properties = ["created_at", "id", "text", "source", "pic_urls", "user", "retweeted_status"]
    
    /// 预览图片的URL数组
    private var thumbImageURLs:[NSURL]?
    
    /// 计算型属性
    var imgURLs:[NSURL]? {
        return retweeted_status == nil ? thumbImageURLs : retweeted_status?.thumbImageURLs
    }
    
    /// 被转发的原微博信息字段，当该微博为转发微博时返回
    var retweeted_status: WeStatus?
    
    init(dict:[String : AnyObject]) {
        super.init()
        
        for key in WeStatus.properties {
            if dict[key] == nil || key == "user" || key == "retweeted_status" {
                continue
            }
            
            setValue(dict[key], forKey: key)
            
        }
        if let userDict = dict["user"] as? [String: AnyObject] {
            user = User(dict: userDict)
        }
        
        // 判断字典中是否包含 retweeted_status
        if let retweetedDict = dict["retweeted_status"] as? [String: AnyObject] {
            retweeted_status = WeStatus(dict: retweetedDict)
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
                let status:WeStatus = WeStatus(dict: dict)
                statuses.append(status)
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
            if (s.imgURLs == nil || s.imgURLs?.isEmpty == true){
                continue
            }
            
            // 遍历 URL 数组
            for url in s.imgURLs! {
                // 进入调度组
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) in
                    // 离开调度组
                    dispatch_group_leave(group)
                })
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) {
//            print("缓存结束 \(NSHomeDirectory())")
            finished(weStatus: statuses, error: nil)
        }
        
    }

}
