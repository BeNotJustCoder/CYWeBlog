//
//  PictureViewCell.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/6.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import SDWebImage

class PictureViewCell: UICollectionViewCell {
    var imageURL: NSURL? {
        didSet {
            
            SDWebImageManager.sharedManager().downloadImageWithURL(self.imageURL, options: SDWebImageOptions(rawValue: 0), progress: { (curValue, totalValue) -> Void in
                print("downloadImage:\(curValue)-\(totalValue)")
                }, completed: { (image, error, _, _, _) -> Void in
                    self.imageView.image = image
                    self.imageView.sizeToFit()
            })
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.frame = bounds
        //        scrollView.backgroundColor = UIColor.orangeColor()
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        imageView.ff_AlignInner(ff_AlignType.TopLeft, referView: scrollView, size: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView = UIScrollView()
    lazy var imageView = UIImageView()
}
