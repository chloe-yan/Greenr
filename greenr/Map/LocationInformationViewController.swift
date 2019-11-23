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
