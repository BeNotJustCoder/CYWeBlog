//
//  WelcomeViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/27.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    var imgWidth:Float = 85
    var iconConstraintY:NSLayoutConstraint?
    
    lazy var backgroundImgView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "ad_background"))
        
        self.view.addSubview(imgView)
        
        return imgView
        }()
    
    lazy var iconView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "avatar_default_big"))
        self.view.addSubview(imgView)
        imgView.layer.cornerRadius = CGFloat(self.imgWidth / 2)
        imgView.layer.masksToBounds = true
        imgView.alpha = 0
        return imgView
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "欢迎回来"
        label.alpha = 0
        self.view.addSubview(label)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImgView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : backgroundImgView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : backgroundImgView]))
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        iconConstraintY = NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        view.addConstraint(iconConstraintY!)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(imgWidth)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: ["imgWidth" : imgWidth], views: ["subView" : iconView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(imgWidth)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: ["imgWidth" : imgWidth], views: ["subView" : iconView]))
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20))
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        iconConstraintY?.constant = -150
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.iconView.alpha = 1
            }) { (_) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.nameLabel.alpha = 1
                    }, completion: { (_) -> Void in
                     NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootVCNotification, object: true)
                })
        }
    }

    
}
