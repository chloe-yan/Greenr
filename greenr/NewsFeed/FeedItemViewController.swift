//
//  FeedItemViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/15/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit
import WebKit

class FeedItemViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var selectedFeedURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFeedURL = selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\t", with:"")
        webView.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
}
