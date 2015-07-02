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
    var statuses:[WeStatus]?{
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setVisitorViewInfo("visitordiscover_feed_image_house", message: "关注一些人，回到这里看看有什么惊喜", isHome: true)
        
        tableView.registerClass(WeStatusCell.self, forCellReuseIdentifier: "statusCell")
//        tableView.estimatedRowHeight = 200
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        if UserAccount.isUserLogin {
            setupNavigationBar()
            
            loadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        visitorView?.startAnimation()
    }
    
    /// 表格的数据源和代理方法
    
    func loadData() {
        WeStatus.loadStatus { (weStatus, error) -> () in
//            print(weStatus)
            self.statuses = weStatus
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("statusCell", forIndexPath: indexPath) as! WeStatusCell
//        cell.textLabel?.text = statuses![indexPath.row].text
        cell.status = statuses![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("statusCell") as! WeStatusCell
        
        return cell.statusCellHeight(statuses![indexPath.row])
    }
    
    
    /// 设置导航条
    private func setupNavigationBar() {
        
        // 设置左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", highlightedImageName: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", highlightedImageName: nil)
        
        // 添加 target
        let rightBtn = navigationItem.rightBarButtonItem!.customView as! UIButton
        rightBtn.addTarget(self, action: "presentQRscanViewController", forControlEvents: UIControlEvents.TouchUpInside)
        
        //设置中间标题
        let titleBtn = HomeTitleNavButton.button(shareUserAccount!.name!)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: "onTitleNavBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)

    }
    

    func onTitleNavBtnClicked(btn:HomeTitleNavButton) {
        btn.imageView?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        presentTitlePopoverView()
    }
    
    /// 设置弹出菜单的转场动画
//    let popoverAnimator = PopoverAnimator() 为什么这边这样不行？
    private lazy var popoverAnimator = PopoverAnimator()
    func presentTitlePopoverView() {
        let sb = UIStoryboard(name: "TitlePopoverViewController", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("TitlePopoverViewControllerSB")
        
        //设置转场代理和转场模式
        vc.transitioningDelegate = popoverAnimator//self
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        // 2. 设置视图的展现大小
        let x = (view.bounds.width - 200) * 0.5
        popoverAnimator.presentFrame = CGRectMake(x, 56, 200, 300)
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    /// 二维码扫描视图
    func presentQRscanViewController() {
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let qrVc = sb.instantiateInitialViewController()!
        
        presentViewController(qrVc, animated: true, completion: nil)
    }
    
    
    ///懒加载

}
