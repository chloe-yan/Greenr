//
//  LocationInformationViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/29/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.

import UIKit
import DropDown

var nameOfCity: String = ""
var nameOfState: String = ""

class LocationInformationViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var stateSearchBar: UISearchBar!
    var listOfStates = ["Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming"]
    var filteredStates: [String] = []
    var dropButton = DropDown()
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var stateName: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButtonTapped(_ sender: Any) {
        if (cityName.text?.isEmpty == false && stateName.text?.isEmpty == false) {
            errorMessageLabel.text = ""
            performSegue(withIdentifier: "searchSegue", sender: self)
        }
        else {
            errorMessageLabel.text = "Please enter the city name and state abbreviation."
        }
    }
    
    override func viewDidLoad() {
        counter = 0
        print("SETTING THE COUNTER: \(counter)")
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 18
        filteredStates = listOfStates
        dropButton.anchorView = stateSearchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().textFont = UIFont(name: "Poppins-Regular", size: 14)!
        DropDown.appearance().textColor = UIColor.darkGray
        DropDown.appearance().cellHeight = 35
        DropDown.appearance().cornerRadius = 10
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        dropButton.direction = .bottom
        dropButton.selectionAction = {[unowned self] (index: Int, item: String) in
            print("SELECTED ITEM: \(item) INDEX: \(index)")
            self.stateSearchBar.text = self.dropButton.selectedItem
        }
        stateSearchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStates = searchText.isEmpty ? listOfStates: listOfStates.filter({ (dat) -> Bool in dat.range(of: searchText, options: .caseInsensitive) != nil
        })
        dropButton.dataSource = filteredStates
        dropButton.show()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((stateSearchBar.subviews[0])).subviews { //used to be subview
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        filteredStates = listOfStates
        dropButton.hide()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            nameOfCity = cityName.text ?? "cityName"
            nameOfState = stateName.text ?? "stateName"
        }
        if let vtvc = segue.destination as? VolunteerTableViewController {
            vtvc.cityName = nameOfCity
            vtvc.stateName = nameOfState
            counter = 0
            print("SETTING THE COUNTER: \(counter)")
        }
    }
}
