//
//  HomeTitleNavButton.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/28.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class HomeTitleNavButton: UIButton {
    var title:String?

    class func button(title: String) -> HomeTitleNavButton {
        
        let btn = HomeTitleNavButton()
        
        btn.titleLabel?.font = UIFont.systemFontOfSize(17.0)
        btn.setTitle(title + " ", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "timeline_card_middle_background_highlighted"), forState: UIControlState.Highlighted)
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        btn.sizeToFit()
        
        return btn
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var tFrame = titleLabel!.frame
        tFrame.origin.x = 0
        titleLabel!.frame = tFrame
        // titleLabel?.frame.offset(dx: 0, dy: 0)
        
        var iFrame = imageView!.frame
        iFrame.origin.x = tFrame.width
        imageView!.frame = iFrame
    }

}
