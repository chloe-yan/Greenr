//
//  Habit.swift
//  greenr
//
//  Created by Chloe Yan on 10/13/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import Foundation
import UIKit

struct Habit: Codable {
    var title: String
    var currentStreak: Int32 = 0
    var bestStreak: Int32 = 0
    var lastCompletionDate: Date?
    var numberOfCompletions: Int32 = 0
    var hasCompletedForToday: Bool {
        return lastCompletionDate?.isToday ?? false
    }
    init(title: String) {
        self.title = title
    }
}
