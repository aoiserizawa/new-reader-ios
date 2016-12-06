//
//  WebViewController.swift
//  NewsReader
//
//  Created by Alvin Joseph Valdez on 07/12/2016.
//  Copyright © 2016 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(URLRequest(url:URL(string: url!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
