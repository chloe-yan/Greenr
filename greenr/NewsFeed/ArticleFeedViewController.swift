//
//  ArticleFeedViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/15/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit
import CoreLocation

var selectedFeedURL: String = ""
var feedImgs: [AnyObject] = []
var myFeed : NSArray = []
var url: URL!

class ArticleFeedViewController: UITableViewController, XMLParserDelegate {
    
    let object = ArticleFeedTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.rowHeight = UITableView.automaticDimension
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.clipsToBounds = true
        tableView.estimatedRowHeight = 140
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.register(ArticleFeedTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        loadData()
    }
    
    @IBAction func refreshFeed(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        url = URL(string: "https://earth911.com/feed/")!
        loadRss(url);
    }

    func loadRss(_ data: URL) {

        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager

        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "openPage", sender: self)
     }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5
        return cellSpacingHeight
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPage" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            selectedFeedURL = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
            if let fivc = segue.destination as? FeedItemViewController {
                fivc.selectedFeedURL = selectedFeedURL
            }
        }
    }
    
    // MARK: - Table view data source.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func hexStringToUIColor (_ hex :String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension ArticleFeedViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  ArticleFeedTableViewCell
     cell.articleLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
     return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
