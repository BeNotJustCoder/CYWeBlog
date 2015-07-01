//
//  UIBarButtonItem+Ext.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/30.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // convenience 方便的
    // 为了满足导航按钮有高亮图片的需求，同时如果美工按照 高亮图片命名 _highlighted，程序能够更加简单！
    convenience init(imageName: String, highlightedImageName: String?) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal);
        // ?? 表示如果前面的内容为 nil，使用后面的内容
        let hImageName = highlightedImageName ?? imageName + "_highlighted"
        
        btn.setImage(UIImage(named: hImageName), forState: UIControlState.Highlighted)
        
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
}
