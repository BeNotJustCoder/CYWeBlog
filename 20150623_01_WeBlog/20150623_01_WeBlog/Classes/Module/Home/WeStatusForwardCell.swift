//
//  WeStatusForwardCell.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/3.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class WeStatusForwardCell: WeStatusCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        forwardLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14, mutiLines: true)
        insertSubview(forwardLabel!, atIndex: 0)
        
        insertSubview(forwardButton, atIndex: 0)
        
        // 自动布局
        forwardLabel!.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 16
        forwardLabel!.ff_AlignInner(ff_AlignType.TopLeft, referView: forwardButton, size: nil, offset: CGPoint(x: 12, y: 12))
        
        // 背景按钮
        forwardButton.ff_AlignVertical(ff_AlignType.BottomLeft, referView: commentLabel, size: nil, offset: CGPoint(x: -12, y: 12))
        forwardButton.ff_AlignVertical(ff_AlignType.TopRight, referView: footerView, size: nil)
        
        // 重新设置配图视图
        let cons = pictureView.ff_AlignVertical(ff_AlignType.BottomLeft, referView: forwardLabel!, size: CGSizeMake(290, 90), offset: CGPoint(x: 0, y: 12))
        // 记录宽高约束
        picViewWidthCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        picViewHeightCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy var forwardButton:UIButton = {
        let btn = UIButton(type: UIButtonType.System)
        btn.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        return btn
    }()

}
