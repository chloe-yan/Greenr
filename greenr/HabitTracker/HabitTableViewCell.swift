//
//  HabitTableViewCell.swift
//  greenr
//
//  Created by Chloe Yan on 10/14/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellStreakLabel: UILabel!
    
    let globalHabitList = ["Commute by walking/biking", "Use a resuable water bottle", "Reduce meat consumption", "Reduce dairy consumption", "Ditch plastic packaging", "Purchase locally grown foods"]
    
    static let identifier = "habit cell"
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var persistence = PersistenceLayer()
    var personalPersistence = PersonalPersistenceLayer()
    
    func configure(_ habit: Habit) {
        shadowAndBorderForCell(yourTableViewCell: HabitTableViewCell())
        
        // Formatting date
        let now = Date()
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd"
        let currentDate = format.string(from: now)
        let currentDateParts = currentDate.components(separatedBy: "-")
        let currentYear = Int(currentDateParts[0])!
        let currentMonth = Int(currentDateParts[1])!
        let currentDay = Int(currentDateParts[2])!
        
        print("CONFIGURE: Habit name: \(habit.title)")
        print("Current date: \(currentDate)")
        print("Last completion date: \(habit.lastCompletionDate)")
        self.cellTitleLabel.text = habit.title
        if habit.lastCompletionDate == nil {
            print("LCD = NIL")
            self.cellStreakLabel.text = "Streak: 0 days"
        }
            
        // Ran when lastCompletionDate is not nil
        else {
            let completionDateFormatted = format.string(from: habit.lastCompletionDate!)
            print("COMPLETION DATE FORMATTED \(completionDateFormatted)")
            let parts = completionDateFormatted.components(separatedBy: "-")
            let lastCompletionDateYear = Int(parts[0])!
            let lastCompletionDateMonth = Int(parts[1])!
            let lastCompletionDateDay = Int(parts[2])!
            print("last completion date day: \(lastCompletionDateDay)")
            print("current day: \(currentDay)")
            let numOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            if (currentDay > (lastCompletionDateDay + 1)) || (currentMonth > lastCompletionDateMonth && (lastCompletionDateDay <= (currentDay-2) + numOfDaysInMonth[lastCompletionDateMonth-1])) || (currentYear > lastCompletionDateYear && (lastCompletionDateDay <= (currentDay-2) + numOfDaysInMonth[lastCompletionDateMonth-1])) {
                print("RESETTING BECAUSE LOST STREAK")
                if (!(self.cellStreakLabel.text == "Streak: 0 days") && globalHabitList.contains(habit.title)) {
                    persistence.resetHabit(habit)
                }
                else if (!(self.cellStreakLabel.text == "Streak: 0 days") && !(globalHabitList.contains(habit.title))) {
                    personalPersistence.resetHabit(habit)
                }
                self.cellStreakLabel.text = "Streak: \(habit.currentStreak) days"
            }
            else if habit.currentStreak == 1 {
                self.cellStreakLabel.text = "Streak: \(habit.currentStreak) day"
            }
            else if habit.currentStreak >= 1 {
                self.cellStreakLabel.text = "Streak: \(habit.currentStreak) days"
            }
            else {
                self.cellStreakLabel.text = "Streak: 0 days"
        }
    }
        if habit.hasCompletedForToday {
            self.accessoryType = .checkmark
        }
        else {
            self.accessoryType = .disclosureIndicator
        }
    }
    
    func configureStreakUpdates(_ habit: Habit) {
        if habit.hasCompletedForToday {
            self.accessoryType = .checkmark
        }
        else {
            self.accessoryType = .disclosureIndicator
        }
    }
}

extension HabitTableViewCell {
func shadowAndBorderForCell(yourTableViewCell : UITableViewCell){
yourTableViewCell.contentView.layer.cornerRadius = 5
yourTableViewCell.contentView.layer.borderWidth = 0.5
yourTableViewCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
yourTableViewCell.contentView.layer.masksToBounds = true
yourTableViewCell.layer.shadowColor = UIColor.gray.cgColor
yourTableViewCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
yourTableViewCell.layer.shadowRadius = 2.0
yourTableViewCell.layer.shadowOpacity = 1.0
yourTableViewCell.layer.masksToBounds = false
yourTableViewCell.layer.shadowPath = UIBezierPath(roundedRect:yourTableViewCell.bounds, cornerRadius:yourTableViewCell.contentView.layer.cornerRadius).cgPath
}
}
