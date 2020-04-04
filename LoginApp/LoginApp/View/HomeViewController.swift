//
//  HomeViewController.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//

import UIKit
import WebKit
class HomeViewController: UIViewController,WKNavigationDelegate{
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.navigationDelegate = self
        // Do any additional setup after loading the view.
        let urlString = HelperClass.getUrlStringToLoad()
        guard let requestUrl = URL(string: urlString) else {
            return
        }
        self.wkWebView.load(URLRequest(url: requestUrl))
        self.wkWebView.allowsBackForwardNavigationGestures = true
    }
}
