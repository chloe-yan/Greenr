//
//  PersonalHabitsViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/30/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit
import GameKit

class PersonalHabitsDetailViewController: UIViewController {
   
    // MARK: - VARS
    var habit: Habit!
    var habitIndex: Int!
    private var persistence = PersonalPersistenceLayer()
    
    // MARK: - IBACTIONS + IBOUTLETS
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailStreakLabel: UILabel!
    @IBOutlet weak var detailBestStreakLabel: UILabel!
    @IBOutlet weak var detailTotalCompletionsLabel: UILabel!
    @IBOutlet weak var markedAsCompletedButton: UIButton!
    @IBAction func markedAsCompleted(_ sender: Any) {
        habit = persistence.markHabitAsCompleted(habitIndex)
        updateUI()
    }
    
    //MARK: - CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func updateUI() {
        detailTitleLabel.text = habit.title
        if habit.currentStreak == 1 {
           detailStreakLabel.text = "Current Streak: \(habit.currentStreak) day"
           detailBestStreakLabel.text = "Best Streak: \(String(habit.bestStreak)) day"
        }
        else {
            detailStreakLabel.text = "Current Streak: \(habit.currentStreak) days"
            detailBestStreakLabel.text = "Best Streak: \(String(habit.bestStreak)) days"
        }
        detailTotalCompletionsLabel.text = "Total Number of Completions: \(String(habit.numberOfCompletions))"
        
        if habit.hasCompletedForToday {
            markedAsCompletedButton.setTitle("Completed for Today!", for: .normal)
        }
        else {
            markedAsCompletedButton.setTitle("Mark as Completed", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markedAsCompletedButton.layer.cornerRadius = 18
    }
}
