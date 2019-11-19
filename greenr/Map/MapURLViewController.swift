//
//  MapURLViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/19/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit
import WebKit

class MapURLViewController: UIViewController {
    
    var selectedMapURL: String?
    @IBOutlet weak var mapWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedMapURL = selectedMapURL?.replacingOccurrences(of: " ", with:"")
        selectedMapURL = selectedMapURL?.replacingOccurrences(of: "http", with:"https")
        selectedMapURL =  selectedMapURL?.replacingOccurrences(of: "\n", with:"")
        selectedMapURL =  selectedMapURL?.replacingOccurrences(of: "\t", with:"")
        mapWebView.load(URLRequest(url: URL(string: selectedMapURL! as String)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
}
