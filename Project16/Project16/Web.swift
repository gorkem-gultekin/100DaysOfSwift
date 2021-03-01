//
//  Web.swift
//  Project16
//
//  Created by Görkem Gültekin on 22.02.2021.
//

import UIKit
import WebKit
class Web: UIViewController, WKNavigationDelegate {

    var webAddress: String?
    var webView: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: webAddress!){
            webView?.load(URLRequest(url: url))
        }
    }
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }
}
