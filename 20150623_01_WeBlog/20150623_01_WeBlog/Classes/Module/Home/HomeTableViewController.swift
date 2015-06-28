//
//  HomeTableViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseModuleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setVisitorViewInfo("visitordiscover_feed_image_house", message: "关注一些人，回到这里看看有什么惊喜", isHome: true)
        
        setupNavigationBar()
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
        btn.frame = CGRectMake(0, 0, 30, 30)
        btn.setImage(UIImage(named: "navigationbar_friendsearch"), forState: UIControlState.Normal);
        btn.setImage(UIImage(named: "navigationbar_friendsearch_highlighted"), forState: UIControlState.Highlighted)
        
        return btn
    }()
    
    lazy var rightNavBtn:UIButton = {
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 30, 30)
        btn.setImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal);
        btn.setImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
        
        return btn
    }()
    
    lazy var titleNavBtn:UIButton = {
        let userName = "用户名"//shareUserAccount!.name!
        let btn = HomeTitleNavButton()
        btn.frame = CGRectMake(0, 0, 10, 30)
        btn.setTitle(userName + " ", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "timeline_card_middle_background_highlighted"), forState: UIControlState.Highlighted)
//        btn.setBackgroundImage(UIImage(named: "timeline_card_middle_background"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "onTitleNavBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private var isSelected:Bool = false
    func onTitleNavBtnClicked(btn:HomeTitleNavButton) {
        btn.imageView?.transform = isSelected ? CGAffineTransformMakeRotation(CGFloat(M_PI)) : CGAffineTransformMakeRotation(0)
        isSelected = !isSelected
        
        presentTitlePopoverView()
    }
    
    private func presentTitlePopoverView() {
        let sb = UIStoryboard(name: "TitlePopoverViewController", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TitlePopoverViewControllerSB")
        
        presentViewController(vc, animated: true, completion: nil)
    }

}
