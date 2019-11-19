//
//  DateExtensions.swift
//  greenr
//
//  Created by Chloe Yan on 10/14/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import Foundation
extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
}
