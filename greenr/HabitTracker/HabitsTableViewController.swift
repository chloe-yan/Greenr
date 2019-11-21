//
//  FourthViewController.swift
//  greenr
//
//  Created by Chloe Yan on 10/3/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit
import GameKit

var myIndex = 0

class HabitsTableViewController: UITableViewController, GKGameCenterControllerDelegate {
    
    @IBAction func personalHabitsTapped(_ sender: Any) {
    }
    
    @IBAction func leaderboardButtonTapped(_ sender: Any) {
        saveHighestStreak()
        showLeaderboard()
    }
    
    @IBOutlet weak var personalHabitsButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    // Integrating persistence layer
    private var persistence = PersistenceLayer()

    // Returns the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistence.habits.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        let habit = persistence.habits[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.configure(habit)
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        persistence.setNeedsToReloadHabits()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        persistence.setNeedsToReloadHabits()
        tableView.register(HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        leaderboardButton.layer.cornerRadius = 18
        personalHabitsButton.layer.cornerRadius = 18
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        authPlayer()
    }
    
    func authPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            }
            else {
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
    }
        
    func saveHighestStreak() {
        if GKLocalPlayer.local.isAuthenticated {
            // Commuting
            let scoreReporterCommuting = GKScore(leaderboardIdentifier: "org.chloeyan.greenr.leaderboard")
            scoreReporterCommuting.value = Int64(persistence.habits[0].currentStreak)
            let scoreArrayCommuting: [GKScore] = [scoreReporterCommuting]
            GKScore.report(scoreArrayCommuting, withCompletionHandler: nil)
            
            // Reusable Water Bottle
            let scoreReporterReusableWaterBottle = GKScore(leaderboardIdentifier: "org.chloeyan.greenr.leaderboardreusablewaterbottle")
            scoreReporterReusableWaterBottle.value = Int64(persistence.habits[1].currentStreak)
            let scoreArrayReusableWaterBottle: [GKScore] = [scoreReporterReusableWaterBottle]
            GKScore.report(scoreArrayReusableWaterBottle, withCompletionHandler: nil)
            
            // Reduce Meat Consumption
            let scoreReporterReduceMeatConsumption = GKScore(leaderboardIdentifier: "org.chloeyan.greenr.leaderboardreducemeatconsumption")
            scoreReporterReduceMeatConsumption.value = Int64(persistence.habits[2].currentStreak)
            let scoreArrayReduceMeatConsumption: [GKScore] = [scoreReporterReduceMeatConsumption]
            GKScore.report(scoreArrayReduceMeatConsumption, withCompletionHandler: nil)
            
            // Reduce Dairy Consumption
            let scoreReporterReduceDairyConsumption = GKScore(leaderboardIdentifier: "org.chloeyan.greenr.leaderboardreducedairyconsumption")
            scoreReporterReduceDairyConsumption.value = Int64(persistence.habits[3].currentStreak)
            let scoreArrayReduceDairyConsumption: [GKScore] = [scoreReporterReduceDairyConsumption]
            GKScore.report(scoreArrayReduceDairyConsumption, withCompletionHandler: nil)
            
            // Ditch Plastic Packaging
            let scoreReporterDitchPlasticPackaging = GKScore(leaderboardIdentifier: "org.chloeyan.greenr.leaderboardditchplasticpackaging")
            scoreReporterDitchPlasticPackaging.value = Int64(persistence.habits[4].currentStreak)
            let scoreArrayDitchPlasticPackaging: [GKScore] = [scoreReporterDitchPlasticPackaging]
            GKScore.report(scoreArrayDitchPlasticPackaging, withCompletionHandler: nil)
            
            // Purchase Locally Grown Foods
            let scoreReporterPurchaseLocallyGrownFoods = GKScore(leaderboardIdentifier: "org.chloeyan.greenr.leaderboardpurchaselocallygrownfoods")
            scoreReporterPurchaseLocallyGrownFoods.value = Int64(persistence.habits[5].currentStreak)
            let scoreArrayPurchasePlasticPackaging: [GKScore] = [scoreReporterPurchaseLocallyGrownFoods]
            GKScore.report(scoreArrayPurchasePlasticPackaging, withCompletionHandler: nil)
        }
    }
        
    func showLeaderboard() {
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        viewController?.present(gcvc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

extension HabitsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "habitSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "habitSegue" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
            let habit = persistence.habits[indexPath.row]
            cell.configure(habit)
            
            if let habitDetailVC = segue.destination as? HabitDetailViewController {
                habitDetailVC.habit = habit
                habitDetailVC.habitIndex = indexPath.row
            }
        }
    }
}
