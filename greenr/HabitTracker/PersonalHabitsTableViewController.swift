//
//  PersonalHabitsTableViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/30/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
// asdf asdf asdf 

import UIKit


class PersonalHabitsTableViewController: UITableViewController {
    
    // Integrating persistence layer
    private var personalPersistence = PersonalPersistenceLayer()

    // Returns the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalPersistence.habits.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        let habit = personalPersistence.habits[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.configure(habit)
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personalPersistence.setNeedsToReloadHabits()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension PersonalHabitsTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let habitIndexToDelete = indexPath.row
            
            self.personalPersistence.delete(habitIndexToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
        break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "personalHabitSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personalHabitSegue" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
            let habit = personalPersistence.habits[indexPath.row]
            cell.configure(habit)
            
            if let personalHabitsDetailVC = segue.destination as? PersonalHabitsDetailViewController {
                personalHabitsDetailVC.habit = habit
                personalHabitsDetailVC.habitIndex = indexPath.row
            }
        }
    }
}

extension UIAlertController {
    convenience init(habitTitle: String, confirmHandler: @escaping () -> Void) {
        self.init(title: "Delete Habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) {_ in
            confirmHandler()
        }
        self.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
    }
}
