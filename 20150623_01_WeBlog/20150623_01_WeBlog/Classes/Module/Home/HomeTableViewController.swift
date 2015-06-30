//
//  HomeTableViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseModuleViewController {
    var isTitlePresenting:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setVisitorViewInfo("visitordiscover_feed_image_house", message: "关注一些人，回到这里看看有什么惊喜", isHome: true)
        
        if isUserLogin {
            setupNavigationBar()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        visitorView?.startAnimation()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftNavBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNavBtn)
        navigationItem.titleView = titleNavBtn
    }
    
    lazy var leftNavBtn:UIButton = {
        let btn = UIButton()
//        btn.frame = CGRectMake(0, 0, 30, 30)
        btn.setImage(UIImage(named: "navigationbar_friendsearch"), forState: UIControlState.Normal);
        btn.setImage(UIImage(named: "navigationbar_friendsearch_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        
        return btn
    }()
    
    lazy var rightNavBtn:UIButton = {
        let btn = UIButton()
//        btn.frame = CGRectMake(0, 0, 30, 30)
        btn.setImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal);
        btn.setImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: "presentQRscanViewController", forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
    lazy var titleNavBtn:UIButton = {
        let userName = shareUserAccount!.name!
        
        let btn = HomeTitleNavButton()
        btn.setTitle(userName + " ", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "timeline_card_middle_background_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "onTitleNavBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    func onTitleNavBtnClicked(btn:HomeTitleNavButton) {
        btn.imageView?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        presentTitlePopoverView()
    }
    
    
    private func presentTitlePopoverView() {
        let sb = UIStoryboard(name: "TitlePopoverViewController", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TitlePopoverViewControllerSB")
        
        //设置转场代理和转场模式
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    //二维码扫描视图
    func presentQRscanViewController() {
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let qrVc = sb.instantiateInitialViewController()!
        
        presentViewController(qrVc, animated: true, completion: nil)
    }

}


extension HomeTableViewController : UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return PopoverPresentationController(presentedViewController: presented,presentingViewController: presenting);
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
        return 0.5
    }
    
    // 自定义转场动画
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        print(toView)
        
        if isTitlePresenting {
            
            toView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            transitionContext.containerView()?.addSubview(toView!)
            
            toView?.transform = CGAffineTransformMakeScale(1, 0)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                toView?.transform = CGAffineTransformIdentity
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }
        else {
//            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            //动画不起作用？
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                toView?.transform = CGAffineTransformMakeScale(1, 0)
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
                    self.titleNavBtn.imageView?.transform = CGAffineTransformMakeRotation(0)
            })
            
        }
        
    }
}
