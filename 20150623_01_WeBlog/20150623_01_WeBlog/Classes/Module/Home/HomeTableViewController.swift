//
//  HomeTableViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/23.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

let WBReuseIdentifierForNormalCell = "WBReuseIdentifierForNormalCell"
let WBReuseIdentifierForForwardCell = "WBReuseIdentifierForForwardCell"

class HomeTableViewController: BaseModuleViewController {
    var isTitlePresenting:Bool = false
    var statuses:[WeStatus]?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    // 定义行高缓存 [statusId: 行高]
    lazy var rowHeightCache:[Int: CGFloat] = [Int: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setVisitorViewInfo("visitordiscover_feed_image_house", message: "关注一些人，回到这里看看有什么惊喜", isHome: true)
        print(WeStatusCell.self)
        
        
        if UserAccount.isUserLogin {
            
            tableView.registerClass(WeStatusForwardCell.self, forCellReuseIdentifier: WBReuseIdentifierForForwardCell)
            tableView.registerClass(WeStatusNormalCell.self, forCellReuseIdentifier: WBReuseIdentifierForNormalCell)
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            refreshControl = WBRefreshControl()
//            let refreshView = UIView()
//            refreshControl?.backgroundColor = UIColor.redColor()
//            refreshControl?.addSubview(refreshView)
            refreshControl!.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
            
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
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let status = statuses![indexPath.row]
        let reuseID = status.retweeted_status == nil ? WBReuseIdentifierForNormalCell : WBReuseIdentifierForForwardCell
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as! WeStatusCell
//        cell.textLabel?.text = statuses![indexPath.row].text
        cell.status = statuses![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // 1. 取到对象
        let status = statuses![indexPath.row]
        
        // 1.1 判断是否缓存了行高，如果有直接返回
//        if rowHeightCache[status.id] != nil {
//            print("返回缓存行高...")
//            return rowHeightCache[status.id]!
//        }
        
        // 2. 获取 cell
        let reuseID = status.retweeted_status == nil ? WBReuseIdentifierForNormalCell : WBReuseIdentifierForForwardCell
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID) as! WeStatusCell
        
        // 3. 返回行高
        let height = cell.statusCellHeight(status)
//        rowHeightCache[status.id] = height
        return height    }
    
    
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
    
    

}
