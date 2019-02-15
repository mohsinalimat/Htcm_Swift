//
//  PBWebViewController.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit
import WebKit

class PBWebViewController: BaseController,WKUIDelegate,WKNavigationDelegate {
    
    
    //控制器标题
    var titleString:NSString?
    //网页地址
    var urlString:NSString?
    //网页视图
    var webView:WKWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setNavgaionTitle(string: titleString!)
        
        webView = WKWebView.init()
        webView?.frame = CGRect.init(x: 0, y: SafeAreaTop_Height, width: SCREEN_Width, height: MainViewSub_Height)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.backgroundColor = UIColor.clear
        view.addSubview(webView!)
        
        
//        _ = urlString!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        let url = NSURL.init(string: urlString! as String)
        let request:NSMutableURLRequest = NSMutableURLRequest.init(url: url! as URL)
        webView?.load(request as URLRequest)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
}
