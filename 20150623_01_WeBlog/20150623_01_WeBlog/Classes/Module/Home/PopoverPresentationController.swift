//
//  PopoverPresentationController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/28.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    var presentFrame:CGRect = CGRectZero
    
    lazy var dummyView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.frame = self.containerView!.bounds
//        view.frame.origin.y = 56
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTapDummyView"))
        
        return view
    }()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        containerView?.insertSubview(dummyView, belowSubview: presentedView()!)
        
        presentedView()!.frame = presentFrame
    }
    
    func onTapDummyView() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit {
        print("\(self)88")
    }

}
