//
//  WeStatusCell.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/1.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class WeStatusCell: UITableViewCell {
    
    var status:WeStatus?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 懒加载
    lazy var iconView = UIImageView()
}
