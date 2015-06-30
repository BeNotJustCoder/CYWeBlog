//
//  QRCodeViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/29.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var scanLineBottomConstrain: NSLayoutConstraint!
    
    @IBAction func onCloseBarBtnClicked(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

//        self.scanLineBottomConstrain.constant = -20
//        self.scanView.layoutIfNeeded()
    }
    
    override func viewDidAppear(animated: Bool) {
        startScanLineAnimation()
    }
    
    func startScanLineAnimation() {
        
        UIView.animateWithDuration(2.0) { () -> Void in
            // 重复次数需要放在内部
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineBottomConstrain.constant = 2 * self.scanView.bounds.height
            self.scanView.layoutIfNeeded()
        }
    }

    deinit {
        print("\(self)88")
    }

}
