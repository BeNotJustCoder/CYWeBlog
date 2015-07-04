//
//  UIButton+Ext.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/4.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit


extension UIButton {
    // 提示：方法的参数最好不要太多
    convenience init(title: String, imageName: String, fontSize: CGFloat, titleColor: UIColor = UIColor.darkGrayColor()) {
        
        self.init()
        
        setTitle(" " + title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        setTitleColor(titleColor, forState: UIControlState.Normal)
    }
    
    convenience init(title: String, fontSize: CGFloat, titleColor: UIColor = UIColor.whiteColor(), bgColor: UIColor = UIColor.brownColor()) {
        
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        setTitleColor(titleColor, forState: UIControlState.Normal)
        backgroundColor = bgColor
    }
}