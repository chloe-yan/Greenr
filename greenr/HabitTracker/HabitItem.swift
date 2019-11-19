//
//  HabitItem.swift
//  greenr
//
//  Created by Chloe Yan on 10/13/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import Foundation
import CoreData

public class HabitItem: NSManagedObject, Identifiable {
    @NSManaged public var streak:Int32
    @NSManaged public var title:String
}

extension HabitItem {
    static func getAllHabitItems() -> NSFetchRequest<HabitItem> {
        let request:NSFetchRequest<HabitItem> = HabitItem.fetchRequest() as! NSFetchRequest<HabitItem>
        let sortDescriptor = NSSortDescriptor(key: "streak", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
