//
//  OAuthViewController.swift
//  20150623_01_WeBlog
//
//  Created by lincy on 15/6/25.
//  Copyright © 2015年 lincy. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController,UIWebViewDelegate {
    
    private var ClientID = "551402599"//"3267255111"//"4158259006"
    private var RedirectURI = "https://www.baidu.com"//"http://benotjustcoder.github.io"
    private var RedirectURIs = "https://benotjustcoder.github.io"
    private var ClientSecret = "90fd6f14c49b2e253f3bbc97b52a34e3"//"2772be19049affc3a91faa7cf177048a"
    
    lazy var webView:UIWebView = {
        let webView = UIWebView()
        
        return webView
    }()
    
    override func loadView() {
        super.loadView()
        
        view = webView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "closeOAuth")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        
        loadOAuth()
    }

    func loadOAuth() {
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(ClientID)&response_type=code&redirect_uri=\(RedirectURI)")
        
        webView.loadRequest(NSURLRequest(URL: url!))
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print("shouldStartLoadWithRequest")
//        print(request)
        
        //判断是否是返回的结果的url
        if !request.URL!.absoluteString.hasPrefix(RedirectURI) {
            print("不是授权结果")
            return true//继续加载
        }
        
        print("返回授权结果")
        
        //获得Code
        let query = request.URL!.query
        print(query)
        
        if query!.hasPrefix("code=") {
            let code = query?.substringFromIndex(advance("code=".endIndex, 0))
            
//            let url = NSURL(string: "https://api.weibo.com/oauth2/access_token?client_id=\(ClientID)&client_secret=\(ClientSecret)&grant_type=authorization_code&redirect_uri=\(RedirectURI)&code="+code!)
//            webView.loadRequest(NSURLRequest(URL: url!))
            
            loadAccessToken(code!)
        }
        else {
            let error = NSError(domain: "没有得到token", code: 180501, userInfo: nil)
            closeOAuth(error)
        }
        return false //不继续加载
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    
    func loadAccessToken(code: String) {
        let urlString = "oauth2/access_token"
    
        let param = [ "client_id":ClientID,
            "client_secret":ClientSecret,
            "grant_type":"authorization_code",
            "code":code,
            "redirect_uri":RedirectURI
             ]
        
        NetworkTools.sharedNetworkTools().POST(urlString, parameters: param, success: { (_, jsonData) -> Void in
//            print(jsonData)
            UserAccount(dict:jsonData as! [String : AnyObject]).loadUserInfo({ (account, error) -> () in
                if account != nil {
//                    print(account)
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootVCNotification, object: false)
                    self.closeOAuth(nil)
                    
                }
                else {
                    
//                    print(error)
                    self.closeOAuth(error)
                }
            })
            
            }) { (_, error) -> Void in
//                print(error)
                
                self.closeOAuth(error)
        }
    }
    
    
    
    func closeOAuth(error:NSError?){
        
        
        if error == nil {
            SVProgressHUD.showSuccessWithStatus("登录成功!")
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        print(error)
        SVProgressHUD.showInfoWithStatus("您的网络不给力")
        dismissViewControllerAnimated(true, completion: nil)
    }

}
