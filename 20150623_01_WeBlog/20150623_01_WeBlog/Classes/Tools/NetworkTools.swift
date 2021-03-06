//
//  NetworkTools.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/27.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    private static let instance: NetworkTools = {
        // baseURL 要以 `/` 结尾
        let urlString = "https://api.weibo.com/"
        let baseURL = NSURL(string: urlString)!
        
        let tools = NetworkTools(baseURL: baseURL)
        
        
        // 设置相应的默认反序列化格式
        tools.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set<String>
        
        return tools
        }()
    
    /// 全局访问方法
    class func sharedNetworkTools() -> NetworkTools {
        return instance
    }

}
