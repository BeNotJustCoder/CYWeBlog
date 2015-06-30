//
//  PopoverPresentationController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/28.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
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
        
        presentedView()!.frame = CGRectMake(100, 56, 200, 300)
    }
    
    func onTapDummyView() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit {
        print("\(self)88")
    }

}
