//
//  WeStatusCell.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/1.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import SDWebImage


class WeStatusCell: UITableViewCell {
    
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
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        
        iconView.ff_AlignInner(ff_AlignType.TopLeft, referView: self, size: CGSize(width: 34, height: 34), offset: CGPoint(x: 12, y: 12))
        nameLabel.ff_AlignHorizontal(ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
        memberIconView.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: nameLabel, size: nil, offset: CGPoint(x: 4, y: 0))
        vipIconView.ff_AlignInner(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 8))
        timeLabel.ff_AlignHorizontal(ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 12, y: 0))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 懒加载
    lazy var iconView = UIImageView()
    lazy var nameLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14)
    lazy var memberIconView = UIImageView()
    lazy var vipIconView = UIImageView()
    lazy var timeLabel = UILabel(color: UIColor.orangeColor(), fontSize: 10)
}
