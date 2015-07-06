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
            resetScrollView()
            imageView.sd_setImageWithURL(self.imageURL, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), progress: { (curValue, totalValue ) -> Void in
                print("downloadImage:\(curValue)-\(totalValue)")
                }) { (image, error, _, _) -> Void in
                    self.calcImagePosition(image)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.frame = bounds
        //        scrollView.backgroundColor = UIColor.orangeColor()
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.5
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func displaySize(image: UIImage) -> CGSize {
        let scale = image.size.height / image.size.width
        return CGSize(width: bounds.width, height: bounds.width * scale)
    }
    
    private func calcImagePosition(image: UIImage) {
        let size = displaySize(image)
        
        imageView.frame = CGRect(origin: CGPointZero, size: size)
        
        // 长图
        if size.height > bounds.height {
            scrollView.contentInset = UIEdgeInsetsZero
            scrollView.contentSize = size
        } else {
            let top = (bounds.height - size.height) * 0.5
            scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
        }
    }
    
    ///  重设 scrollView 内容参数
    private func resetScrollView() {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.contentOffset = CGPointZero
        scrollView.contentSize = CGSizeZero
    }
    
    lazy var scrollView = UIScrollView()
    lazy var imageView = UIImageView()
}

extension PictureViewCell : UIScrollViewDelegate {
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        // 重新计算边距
        var offsetX = (scrollView.bounds.width - view!.frame.width) * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        var offsetY = (scrollView.bounds.height - view!.frame.height) * 0.5
        if offsetY < 0 {
            offsetY = 0
        }
        // 重新设置边距
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
//        print("\(__FUNCTION__)")
    }
}
