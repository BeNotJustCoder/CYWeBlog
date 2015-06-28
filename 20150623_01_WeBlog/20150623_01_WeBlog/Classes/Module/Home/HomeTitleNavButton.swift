//
//  HomeTitleNavButton.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/28.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class HomeTitleNavButton: UIButton {

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
