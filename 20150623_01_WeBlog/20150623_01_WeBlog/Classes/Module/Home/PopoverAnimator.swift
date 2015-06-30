//
//  PopoverAnimator.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/30.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    var isTitlePresenting:Bool = false
    
    var presentFrame:CGRect = CGRectZero
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let pc = PopoverPresentationController(presentedViewController: presented,presentingViewController: presenting);
        
        pc.presentFrame = presentFrame
        
        return pc
    }
    
    
    // 指定负责转场动画的控制器
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isTitlePresenting = true
        return self
    }
    
    //指定撤销的动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isTitlePresenting = false
        return self
    }
    
    // 转场动画时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if isTitlePresenting {
            return 0.5
        }
        return 0.2
    }

    // 自定义转场动画
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        print(toView)
        
        if isTitlePresenting {
            
            toView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            transitionContext.containerView()?.addSubview(toView!)
            
            toView?.transform = CGAffineTransformMakeScale(1, 0)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                toView?.transform = CGAffineTransformIdentity
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }
        else {
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            //动画不起作用？
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                fromView?.transform = CGAffineTransformMakeScale(1, 0.0001)
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
//                    self.titleNavBtn.imageView?.transform = CGAffineTransformMakeRotation(0)
            })
            
        }
        
    }

}
