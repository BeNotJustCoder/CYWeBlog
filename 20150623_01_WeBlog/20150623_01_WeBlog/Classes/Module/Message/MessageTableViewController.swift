//
//  MessageTableViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseModuleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setVisitorViewInfo("visitordiscover_image_message", message: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知", isHome: false)
        
    }

}