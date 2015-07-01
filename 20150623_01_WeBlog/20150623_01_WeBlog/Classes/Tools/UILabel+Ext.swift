//
//  UILabel+Ext.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/1.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(color: UIColor, fontSize: CGFloat, mutiLines: Bool = false) {
        self.init()
        
        font = UIFont.systemFontOfSize(fontSize)
        textColor = color
        
        if mutiLines {
            numberOfLines = 0
        }
    }
}
