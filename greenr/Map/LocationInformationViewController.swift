//
//  LocationInformationViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/29/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.

import UIKit

var nameOfCity: String = ""
var nameOfState: String = ""

class LocationInformationViewController: UIViewController {
    
    @IBOutlet weak var statePickerView: UIPickerView!
    var statePickerViewData: [String] = [String]()
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
    }
   /*     self.statePickerView.delegate = self as! UIPickerViewDelegate
        self.statePickerView.dataSource = self as! UIPickerViewDataSource
        statePickerViewData = ["Alaska",
        "Alabama",
        "Arkansas",
        "American Samoa",
        "Arizona",
        "California",
        "Colorado",
        "Connecticut",
        "District of Columbia",
        "Delaware",
        "Florida",
        "Georgia",
        "Guam",
        "Hawaii",
        "Iowa",
        "Idaho",
        "Illinois",
        "Indiana",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Massachusetts",
        "Maryland",
        "Maine",
        "Michigan",
        "Minnesota",
        "Missouri",
        "Mississippi",
        "Montana",
        "North Carolina",
        "North Dakota",
        "Nebraska",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "Nevada",
        "New York",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Puerto Rico",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Virginia",
        "Virgin Islands",
        "Vermont",
        "Washington",
        "Wisconsin",
        "West Virginia",
        "Wyoming"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_pickerView: UIPickerView, numberOfRowsInComponent component: Int) {
        
    }
    */
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
