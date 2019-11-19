//
//  PersonalPersistenceLayer.swift
//  greenr
//
//  Created by Chloe Yan on 10/30/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import Foundation

struct PersonalPersistenceLayer {
    // MARK: -VARS
    
    private(set) var habits: [Habit] = [
    ]
    
    private static let userDefaultsHabitsKeyValue = "PERSONAL_HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    private mutating func loadHabits() {
        let userDefaults = UserDefaults.standard
        guard
            let habitData = userDefaults.data(forKey: PersonalPersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }
        self.habits = habits
    }
    
    @discardableResult
    mutating func createNewHabit(name: String) -> Habit {
        let newHabit = Habit(title: name)
        self.habits.append(newHabit)
        self.saveHabits()
        return newHabit
    }
    
    // Saves habits
    private func saveHabits() {
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("Could not encode list of habits.")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersonalPersistenceLayer.userDefaultsHabitsKeyValue)
    }
    
    // Deletes habits
    mutating func delete(_ habitIndex: Int) {
        self.habits.remove(at: habitIndex)
        self.saveHabits()
    }
    
    // Marks a complete habit
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        var updatedHabit = self.habits[habitIndex]
        guard updatedHabit.hasCompletedForToday == false else { return updatedHabit }
        updatedHabit.numberOfCompletions += 1
        
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        }
        else {
            updatedHabit.currentStreak = 1
        }
        
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        
        let now = Date()
        updatedHabit.lastCompletionDate = now
        
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
        self.loadHabits()
        
        return updatedHabit
    }
    
    // Swaps habits
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
}