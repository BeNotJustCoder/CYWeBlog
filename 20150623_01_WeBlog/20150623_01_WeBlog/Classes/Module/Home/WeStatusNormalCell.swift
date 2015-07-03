//
//  WeStatusNormalCell.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/4.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class WeStatusNormalCell: WeStatusCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        // 配图视图
        let cons = pictureView.ff_AlignVertical(ff_AlignType.BottomLeft, referView: commentLabel, size: CGSize(width: 290, height: 90), offset: CGPoint(x: 0, y: 12))
        // 记录宽高约束
        picViewWidthCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        picViewHeightCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
