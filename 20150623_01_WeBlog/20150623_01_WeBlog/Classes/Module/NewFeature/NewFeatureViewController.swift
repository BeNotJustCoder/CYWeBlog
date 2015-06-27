//
//  NewFeatureViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/27.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
let SwitchRootVCNotification = "SwitchRootVCNotification"

class NewFeatureViewController: UICollectionViewController {

    let layout = UICollectionViewFlowLayout()
    
    init () {
        super.init(collectionViewLayout: layout)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(NewFeatureCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置布局
        layout.itemSize = view.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        // 设置分页
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newFeatureImages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCollectionViewCell
    
        // Configure the cell
        cell.newFeatureImage = newFeatureImages[indexPath.item]
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath)
        let indexPath = collectionView.indexPathsForVisibleItems().last!
        
        if indexPath.item == 3 {
            let cell:NewFeatureCollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! NewFeatureCollectionViewCell
            cell.showStartBtn()
        }
    }
    
    var newFeatureImages:[UIImage]! = {
        var imgs:[UIImage] = [UIImage]()
        
        for i in 1...4 {
            imgs.append(UIImage(named:"new_feature_\(i)")!)
        }
        
        return imgs
    }()

}

class NewFeatureCollectionViewCell : UICollectionViewCell{
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var startBtn:UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        
        btn.setTitle("开始体验", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: "onStartBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    var newFeatureImage:UIImage?{
        didSet {
            imageView.image = newFeatureImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView = imageView
        
        self.addSubview(startBtn)
        
        startBtn.hidden = true
        
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -100))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(105)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : startBtn]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(36)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : startBtn]))
    }

    required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    func showStartBtn() {
        // 动画
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        startBtn.hidden = false
        startBtn.userInteractionEnabled = false
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.startBtn.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                print("OK")
                self.startBtn.userInteractionEnabled = true
        })
    }
    
    func onStartBtnClicked() {
        NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootVCNotification, object: true)
    }
    
}
