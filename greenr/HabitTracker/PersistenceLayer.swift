//
//  PersistenceLayer.swift
//  greenr
//
//  Created by Chloe Yan on 10/14/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import Foundation

struct PersistenceLayer {
    // MARK: -VARS
    
    private(set) var habits: [Habit] = [
        Habit(title: "Commute by walking/biking"),
        Habit(title: "Use a resuable water bottle"),
        Habit(title: "Reduce meat consumption"),
        Habit(title: "Reduce dairy consumption"),
        Habit(title: "Ditch plaxstic packaging"),
        Habit(title: "Purchase locally grown foods")
    ]
    
    let globalHabitList = ["Commute by walking/biking", "Use a resuable water bottle", "Reduce meat consumption", "Reduce dairy consumption", "Ditch plastic packaging", "Purchase locally grown foods"]
    
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    
    private mutating func loadHabits() {
        let userDefaults = UserDefaults.standard
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }
        self.habits = habits
    }
    
    // Saves habits
    private func saveHabits() {
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("Could not encode list of habits.")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
    }
    
    // Resets habit values to 0
    mutating func resetHabit(_ habit: Habit) -> Habit {
        print("IN THE RESET HABIT: \(habit.lastCompletionDate)")
        var updatedHabit = habit
        updatedHabit.currentStreak = 0

        let indexValue = globalHabitList.firstIndex(of: habit.title)
        print("Index value: \(indexValue)")
        if (indexValue != nil) {
            self.habits[indexValue!] = updatedHabit
        }
        //self.saveHabits()
        //self.loadHabits()
        
        return updatedHabit
    }
    
    // Marks a complete habit
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        var updatedHabit = self.habits[habitIndex]
        guard updatedHabit.hasCompletedForToday == false else { return updatedHabit }
        updatedHabit.numberOfCompletions += 1
        
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            print("LCD ISYESTERDAY (IF LET)\(lastCompletionDate.isYesterday)")
            updatedHabit.currentStreak += 1
        }
        else {
            //print("LCD ISYESTERDAY (ELSE)\(lastCompletionDate.isYesterday)")
            updatedHabit.currentStreak = 1
        }
        
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        
        let now = Date()
        updatedHabit.lastCompletionDate = now
        print("MARK HABIT: LAST COMPLETION DATE: \(updatedHabit.lastCompletionDate)")
        
        self.habits[habitIndex] = updatedHabit
        print("SAVED: habit: \(updatedHabit.title), habit index: \(habitIndex)")
        self.saveHabits()
        self.loadHabits()
        
        return updatedHabit
    }
    
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
}
