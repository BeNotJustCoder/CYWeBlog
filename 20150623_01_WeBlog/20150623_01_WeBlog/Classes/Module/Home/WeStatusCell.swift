//
//  WeStatusCell.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/1.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import SDWebImage

private let CYPictureCellReuseIdentifier = "pictureCell"
private let layoutMargin:CGFloat = 12

class WeStatusCell: UITableViewCell, UICollectionViewDataSource {
    var picViewWidthCons:NSLayoutConstraint?
    var picViewHeightCons:NSLayoutConstraint?
    
    // 页脚视图
    lazy var footerView: StatusFooterView = StatusFooterView()

    // MARK: - 数据模型
    /// 设置数据模型
    var status:WeStatus?{
        didSet{
            let user = status!.user!
            
            iconView.sd_setImageWithURL(NSURL(string: (user.profile_image_url)!))
            nameLabel.text = user.name
            
            // 是否是认证用户
            if user.verified {
                memberIconView.image = UIImage(named: "common_icon_membership")
            }
            
            //认证用户类型
            switch user.verified_type {
            case 0:
                vipIconView.image = UIImage(named: "avatar_vip")
                break
            case 2,3,5:
                vipIconView.image = UIImage(named: "avatar_enterprise_vip")
                break
            case 220:
                vipIconView.image = UIImage(named: "avatar_grassroot")
                break
            default:
                break
            }
            
            // 时间和来源
            timeLabel.text = "昨天 13:40  来自 微博 weibo.com"
//            timeLabel.text = "\(status!.created_at)  \(status!.source)"
            
            commentLabel.text = status?.text
            
            // 设置图片预览视图的大小
            let result = calcPictureViewSize(status!)
            picViewHeightCons?.constant = result.viewSize.height
            picViewWidthCons?.constant = result.viewSize.width
            pictureLayout.itemSize = result.itemSize
            
            pictureView.reloadData()
        }
    }
    
    
    // MARK: - 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 屏幕宽度
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        // 顶部视图
        let topView = UIView()
        topView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        addSubview(topView)
        topView.ff_AlignInner(ff_AlignType.TopLeft, referView: self, size: CGSize(width: screenWidth, height: 10))
        
        addSubview(iconView)        // 头像
        addSubview(nameLabel)       // 用户名
        addSubview(memberIconView)  // 是否是会员
        addSubview(vipIconView)     // 认证类型
        addSubview(timeLabel)       // 时间和来源
        addSubview(commentLabel)    // 评论
        addSubview(pictureView)     // 配图视图
        preparePictureView()
        addSubview(footerView)
        footerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        iconView.ff_AlignInner(ff_AlignType.TopLeft, referView: self, size: CGSize(width: 34, height: 34), offset: CGPoint(x: 12, y: 22))
        nameLabel.ff_AlignHorizontal(ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        memberIconView.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: nameLabel, size: nil, offset: CGPoint(x: 4, y: 0))
        vipIconView.ff_AlignInner(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 8))
        timeLabel.ff_AlignHorizontal(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        commentLabel.ff_AlignVertical(ff_AlignType.BottomLeft, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 12))
        commentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 16
        
        // 配图视图
//        let cons = pictureView.ff_AlignVertical(ff_AlignType.BottomLeft, referView: commentLabel, size: CGSize(width: 290, height: 90), offset: CGPoint(x: 0, y: 12))
//        // 记录宽高约束
//        picViewWidthCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
//        picViewHeightCons = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
        // 页脚视图
        footerView.ff_AlignVertical(ff_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: screenWidth, height: 44), offset: CGPoint(x: -12, y: 12))
        
        selectionStyle = UITableViewCellSelectionStyle.None
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /// collectionView 的数据源方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(status?.thumbImageURLs?.count ?? 0)
        return status?.imgURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CYPictureCellReuseIdentifier, forIndexPath: indexPath)
        
        let imgURL = status!.imgURLs![indexPath.item]
        let imageView: UIImageView = UIImageView()
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_setImageWithURL(imgURL)
        
        cell.backgroundView = imageView
        
        return cell
    }
    
    /// 计算方法
    func statusCellHeight(status: WeStatus) -> (CGFloat) {
        
        self.status = status
        
        layoutIfNeeded()
        
        return CGRectGetMaxY(footerView.frame)
    }
    
    ///  根据微博模型计算图片是的大小
    /**
    0. 没有图片，返回zero
    1. 单图会按照图片等比例显示
    2. 多图的图片大小固定
    3. 多图如果是4张，会按照 2 * 2 显示
    4. 多图其他数量，按照 3 * 3 九宫格显示
    */
    private func calcPictureViewSize(status: WeStatus) -> (viewSize: CGSize, itemSize: CGSize) {
        
        // 0. 获取图片数量
        let count = status.imgURLs?.count ?? 0
        let itemSize = CGSize(width: 90, height: 90)
        let margin: CGFloat = 4
        
        // 1. 没有图片
        if count == 0 {
            return (CGSizeZero, itemSize)
        }
        
        // 2. 单图
        if count == 1 {
            // 1> 从缓存`拿到`并且创建 image
            // key 就是 url 的完整字符串，sdwebimage缓存图片文件名是对 url 的完整字符串 md5
            let key = status.imgURLs![0].absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            
            print("单张图片 \(key) \(image.size)")
            
            // 2> 返回 image.size
            return (image.size, image.size)
        }
        
        // 3. 4张图片
        if count == 4 {
            let w = itemSize.width * 2 + margin
            return (CGSize(width: w, height: w),itemSize)
        }
        
        // 4. 多张图片
        // 每行图片数量
        let rowCount = 3
        // 1> 计算行数
        // 2,3 -> 1
        // 5,6 -> 2
        // 7,8,9 -> 3
        let row = (count - 1) / rowCount + 1
        let w = itemSize.width * CGFloat(rowCount) + CGFloat(rowCount - 1) * margin
        let h = itemSize.height * CGFloat(row) + CGFloat(row - 1) * margin
        
        return (CGSize(width: w, height: h), itemSize)
    }
    
    ///  准备配图视图图
    private func preparePictureView() {
        // 1. 设置背景颜色
        pictureView.backgroundColor = UIColor.whiteColor()
        // 2. 数据源
        pictureView.dataSource = self
        
        // 3. 注册可重用cell
        pictureView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: CYPictureCellReuseIdentifier)
        // 4. 设置 layout
        pictureLayout.minimumInteritemSpacing = 4
        pictureLayout.minimumLineSpacing = 4
    }

    // MARK: - 私有属性和成员变量
    /// 懒加载
    lazy var iconView = UIImageView()
    lazy var nameLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14)
    lazy var memberIconView = UIImageView()
    lazy var vipIconView = UIImageView()
    lazy var timeLabel = UILabel(color: UIColor.orangeColor(), fontSize: 10)
    lazy var commentLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 15, mutiLines: true)
    
    // 图像视图 - UICollectionView
    lazy var pictureLayout = UICollectionViewFlowLayout()
    lazy var pictureView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.pictureLayout)
    
    
}

/// 页脚视图
class StatusFooterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(forwardBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        
        // 布局，水平平铺
        ff_HorizontalTile([forwardBtn, commentBtn, likeBtn], insets: UIEdgeInsetsZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var forwardBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("转发", forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "timeline_icon_retweet"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        return btn
        }()
    
    lazy var commentBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("评论", forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "timeline_icon_comment"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        return btn
        }()
    
    lazy var likeBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("点赞", forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "timeline_icon_unlike"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        return btn
        }()
}
