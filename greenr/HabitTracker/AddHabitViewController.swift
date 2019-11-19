//
//  AddHabitViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/14/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {

    @IBOutlet weak var habitNameInputField: UITextField!
    @IBOutlet weak var addHabitButton: UIButton!

    @IBAction func addHabitButtonTapped(_ sender: Any) {
        var ppl = PersonalPersistenceLayer()
        guard let habitText = habitNameInputField.text else { return }
        ppl.createNewHabit(name: habitText)
        navigationController?.popViewController(animated: true)
        let vc = PersonalHabitsDetailViewController()
        navigationController?.popToViewController(vc, animated: true)
        self.navigationController?.isNavigationBarHidden = false

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        addHabitButton.layer.cornerRadius = 18
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        self.navigationController?.isNavigationBarHidden = false
    }
}
