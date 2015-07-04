//
//  WBRefreshControl.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/7/4.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit

class WBRefreshControl: UIRefreshControl {

    lazy var refreshView:WBRefreshView = {
        let refView = WBRefreshView(loadingImg: "tableview_loading", loadTip: "正在玩命加载", pullImg: "tableview_pull_refresh", pullTip: "下拉刷新数据", releaseTip: "释放刷新数据")
        return refView;
    }()
    
    override init() {
        super.init()
        
        addSubview(refreshView)
        refreshView.ff_AlignInner(ff_AlignType.CenterCenter, referView: self, size: CGSize(width: 156, height: self.frame.height))
        
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions(rawValue:0), context: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopLoadingAnimation()
        loadingFlag = false
    }
    
    /// 显示提示图标标记
    private var showTipFlag = false
    /// 正在加载标记
    private var loadingFlag = false
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [NSObject : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if frame.origin.y > 0 {
            return
        }
        
        if refreshing && !loadingFlag {
            refreshView.startLoadingAnimation()
            loadingFlag = true
            refreshView.setupState(RefreshViewState.Refreshing)
        }
        
        if frame.origin.y < -2*bounds.height && !showTipFlag {
//            print("翻过来")
            showTipFlag = true
            refreshView.rotateTipIcon(showTipFlag)
            refreshView.setupState(RefreshViewState.ToRelease)
        } else if frame.origin.y >= -bounds.height/9 && showTipFlag {
//            print("转过去")
            showTipFlag = false
            refreshView.rotateTipIcon(showTipFlag)
            refreshView.setupState(RefreshViewState.ToPull)
        }
    }
}

enum RefreshViewState : Int {
    
    case ToPull
    case ToRelease
    case Refreshing
}

class WBRefreshView : UIView {
    
    var loadingTip:String?
    var toPullingTip:String?
    var toReleaseTip:String?
    
    init(loadingImg:String, loadTip:String?, pullImg:String, pullTip:String?, releaseTip:String?) {
        super.init(frame: CGRectZero)
        
        backgroundColor = UIColor.whiteColor()
        
        loadingIconView.image = UIImage(named: loadingImg)
        pullingIconView.image = UIImage(named: pullImg)
        tipLabel.text = pullTip
        
        loadingTip = loadTip
        toPullingTip = pullTip
        toReleaseTip = releaseTip
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupState(state:RefreshViewState) {
        switch state {
        case RefreshViewState.Refreshing:
            loadingIconView.hidden = false
            pullingIconView.hidden = true
            tipLabel.text = loadingTip
            break
        case RefreshViewState.ToPull:
            loadingIconView.hidden = true
            pullingIconView.hidden = false
            tipLabel.text = toPullingTip
            break
        case RefreshViewState.ToRelease:
            loadingIconView.hidden = true
            pullingIconView.hidden = false
            tipLabel.text = toReleaseTip
            break
        }
    }
    
    func startLoadingAnimation() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.7
        loadingIconView.layer.addAnimation(anim, forKey: nil)
    }
    
    ///  旋转提示图标
    private func rotateTipIcon(clockWise: Bool) {
        
        var angle = M_PI
        angle += clockWise ? -0.01 : 0.01
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.pullingIconView.transform = CGAffineTransformRotate(self.pullingIconView.transform, CGFloat(angle))
        }
        
    }
    
    ///  停止动画
    private func stopLoadingAnimation() {
        loadingIconView.layer.removeAllAnimations()
    }
    
    lazy var loadingIconView:UIImageView = {
        let imgView = UIImageView()
        self.addSubview(imgView)
        
        imgView.ff_AlignInner(ff_AlignType.CenterLeft, referView: self, size: nil, offset: CGPoint(x: 8, y: 0))
        imgView.hidden = true
        
        return imgView
    }()
    
    lazy var pullingIconView:UIImageView = {
        let imgView = UIImageView()
        self.addSubview(imgView)
        
        imgView.ff_AlignInner(ff_AlignType.CenterLeft, referView: self, size: nil, offset: CGPoint(x: 8, y: 0))
        
        return imgView
    }()
    
    lazy var tipLabel:UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.ff_AlignHorizontal(ff_AlignType.CenterRight, referView: self.loadingIconView, size: nil, offset: CGPoint(x: 8, y: 0))
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
}
