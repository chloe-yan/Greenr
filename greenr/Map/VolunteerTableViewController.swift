//
//  VolunteerTableViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/29/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit

var selectedVolunteerFeedURL: String = ""
var myVolunteerFeed : NSArray = []
var VolunteerURL: URL!
var counter = 0

class VolunteerTableViewController: UITableViewController, XMLParserDelegate {
    
    var cityName: String?
    var stateName: String?
    
    let object = VolunteerTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.register(VolunteerTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        print("COUNTER: \(counter)")
        if (counter < 1) {
            locationLoadData()
            counter += 1
            print("COUNTER CHECK")
        }
    }
    
    func locationLoadData() {
        print("LOADDATA \(cityName ?? "San Francisco")")
        print(cityName)
        print("CITY NAME COMPONENTS: \(cityName?.components(separatedBy: " "))")
        let cityNameArray = cityName!.components(separatedBy: " ")
        var customString = ""
        if (cityNameArray.count > 1) {
            for i in 0...(cityNameArray.count-1) {
                customString += cityNameArray[i]
                customString += "+"
            }
            customString.remove(at: customString.index(before: customString.endIndex))
        }
        customString += "%2C+"
        var stateNameArray = Array(stateName!)
        var updatedStateName = ""
        var stateNameArrayLength = stateNameArray.count
        for i in 0...stateNameArrayLength-1 {
            if (stateNameArray[i] == " ") {
                stateNameArray.remove(at: i)
                print(stateNameArrayLength)
                stateNameArrayLength -= 1
            }
            else {
                updatedStateName += String(stateNameArray[i])
            }
        }
        customString += updatedStateName
        customString += "%2C+USA"
        var myURL = "https://www.volunteermatch.org/search/index.jsp?rss=true&aff=&includeOnGoing=true&r=20.0&categories=13&l="
        myURL += customString
        print(myURL)
        url = URL(string: myURL)!
        loadRss(url);
    }

    func loadRss(_ data: URL) {

        // XmlParserManager instance/object/variable.
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager

        // Put feed in array
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openVolunteerSegue", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openVolunteerSegue" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            selectedFeedURL = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
            if let mapURLVC = segue.destination as? MapURLViewController {
                mapURLVC.selectedMapURL = selectedFeedURL
            }
        }
    }
}
        // MARK: - Table view data source.

extension VolunteerTableViewController {
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  VolunteerTableViewCell
        cell.volunteerEventLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
