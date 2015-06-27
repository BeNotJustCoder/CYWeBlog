//
//  VisitorLoginView.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/24.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class VisitorLoginView: UIView {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setVisitorViewInfo(centerImg:String, message:String, isHome:Bool) {
        registerBtn.hidden = isHome
        loginBtn.hidden = isHome
        followBtn.hidden = !isHome
        rotationView.hidden = !isHome
        
        messageLabel.text = message
        centerView.image = UIImage(named: centerImg)
    }
    
    
    func setupSubviews() {
        addSubview(rotationView)
        addSubview(maskImgView)
        addSubview(centerView)
        addSubview(messageLabel)
        addSubview(followBtn)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        setupConstrains()
    }
    
    func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 20
        
        anim.repeatCount = MAXFLOAT
        
        rotationView.layer.addAnimation(anim, forKey: nil)
    }
    
    private func setupConstrains() {
        // 添加旋转的图片约束
        rotationView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: rotationView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: rotationView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -100))
        
        // 添加小房子的约束
        centerView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: centerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: centerView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        
        // 添加文字约束
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: centerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 50))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(240)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": messageLabel]))
        
        // 添加关注按钮布局
        followBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: followBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -100))
        addConstraint(NSLayoutConstraint(item: followBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(120)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": followBtn]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(40)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": followBtn]))
        
        // 添加注册按钮布局
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -100))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: -70))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(120)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": registerBtn]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(40)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": registerBtn]))
        
        // 添加登录按钮布局
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -100))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 70))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(120)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": loginBtn]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(40)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView": loginBtn]))
        
        
        // 遮罩视图的布局
        maskImgView.translatesAutoresizingMaskIntoConstraints = false
        // 水平方向
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : maskImgView]))
        
        addConstraint(NSLayoutConstraint(item: maskImgView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskImgView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
    }
    
    ///控件懒加载
    
    // 旋转的图片
    lazy var rotationView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return imgView
        }()
    
    lazy var maskImgView:UIImageView = {
       let imgView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return imgView
    }()
    
    // 中间的小房子
    lazy var centerView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return imgView
    }()
    
    lazy var messageLabel:UILabel = {
       let label = UILabel()
        label.text = "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"
        label.sizeToFit()
//        self.addSubview(label)
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = NSTextAlignment.Center
//        label.preferredMaxLayoutWidth = 224
        // 最多两行，超出之后...
        label.numberOfLines = 2
        return label
    }()
    
    lazy var followBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("去关注", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        return btn
    }()
    
    lazy var registerBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        return btn
    }()
    
    lazy var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        return btn
    }()

}
