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

}
