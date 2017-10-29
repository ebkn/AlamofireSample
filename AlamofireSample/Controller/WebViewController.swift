//
//  WebViewController.swift
//  AlamofireSample
//
//  Created by Ebinuma Kenichi on 2017/10/29.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
  var selectedShop: Shop?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let webView = WKWebView()
    webView.frame = self.view.frame
    self.view.addSubview(webView)
    
    let url = URL(string: (selectedShop?.url!)!)
    let urlRequest = URLRequest(url: url!)
    webView.load(urlRequest)
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
