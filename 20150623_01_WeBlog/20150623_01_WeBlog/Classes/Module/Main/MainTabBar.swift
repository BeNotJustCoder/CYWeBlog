//
//  MainTabBar.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {
    
    private let itemCount = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //调整barItem的位置
        let w = bounds.width/CGFloat(itemCount)
        let baseFrame = CGRectMake(0, 0, w, bounds.height)
        
        var index = 0
        for subView in subviews {
            if subView is UIControl && !(subView is UIButton) {
                subView.frame = CGRectOffset(baseFrame, w * CGFloat(index), 0)
                index += (index == 1 ? 2 : 1)
            }
        }
        
        //调整自己添加按钮的位置
        newBtn.frame = CGRectOffset(baseFrame, w * 2, 0)
    }
    
    //中间按钮懒加载
    lazy var newBtn:UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setBackgroundImage(UIImage(imageLiteral: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(imageLiteral: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.setImage(UIImage(imageLiteral: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setImage(UIImage(imageLiteral: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        self.addSubview(btn)
        
        return btn
    }()
    
    

}
