//
//  PictureScanViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/4.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import SVProgressHUD

let WBPictureBrowserCellIdentifier = "WBPictureBrowserCellIdentifier"

class PictureScanViewController: UIViewController {
    
    var currentIndex: Int = 0
    var imageURLs: [NSURL]?
    
    init(urls: [NSURL], index: Int) {
        imageURLs = urls
        currentIndex = index
        
        super.init(nibName: nil, bundle: nil)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
        
        setupSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        prepareCollectionView()
        
        let indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }

    private func setupSubViews() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        collectionView.ff_Fill(view)
        closeButton.ff_AlignInner(ff_AlignType.BottomLeft, referView: view, size: CGSize(width: 60, height: 30), offset: CGPoint(x: 12, y: -12))
        saveButton.ff_AlignInner(ff_AlignType.BottomRight, referView: view, size: CGSize(width: 60, height: 30), offset: CGPoint(x: -12, y: -12))
        
        closeButton.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        saveButton.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
    ///  关闭
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    ///  保存
    func save() {
        let indexPath = collectionView.indexPathsForVisibleItems().last
        let cell = collectionView.cellForItemAtIndexPath(indexPath!) as! PictureViewCell
        
        let image = cell.imageView.image!
        
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    //- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:AnyObject) {
        if error != nil {
            SVProgressHUD.showErrorWithStatus("保存出错")
        } else {
            SVProgressHUD.showSuccessWithStatus("保存成功")
        }
    }
    
    private func prepareCollectionView() {
        collectionView.registerClass(PictureViewCell.self, forCellWithReuseIdentifier: WBPictureBrowserCellIdentifier)
        collectionView.dataSource = self
        
        layout.itemSize = collectionView.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView.pagingEnabled = true
    }
    
    ///  关闭按钮
    private lazy var closeButton: UIButton = UIButton(title: "关闭", fontSize: 15, titleColor: UIColor.whiteColor(), bgColor: UIColor.brownColor())
    ///  保存按钮
    private lazy var saveButton: UIButton = UIButton(title: "保存", fontSize: 15, titleColor: UIColor.whiteColor(), bgColor: UIColor.brownColor())
    
    // MARK: - 懒加载控件
    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layout)
}

extension PictureScanViewController : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(WBPictureBrowserCellIdentifier, forIndexPath: indexPath) as! PictureViewCell
        cell.imageView.image = nil
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
        cell.imageURL = imageURLs![indexPath.item]
        return cell
    }
}

