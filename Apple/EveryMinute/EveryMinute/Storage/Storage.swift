//
//  Storage.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 16.01.25.
//

import Foundation
import CoreData

/// storage struct to load, store and control data of this app
internal struct Storage {
    
    /* LOAD DATA */
    
    /// Load Calendar entries from the disk.
    /// Either only load entries in the specified date range, or, if no arguments are passed, all entries. Respectively all entries before a date, or all entries after a date can be loaded
    internal static func loadCalendarEntries(
        _ context : NSManagedObjectContext,
        from startDate : Date? = nil,
        to endDate : Date? = nil,
        count : Int? = nil
    ) throws -> [CalendarEntry] {
        let fr : NSFetchRequest = CalendarEntry.fetchRequest()
        fr.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        var predicates : [NSPredicate] = []
        if let start = startDate {
            predicates.append(NSPredicate(format: "date >= %@", start as NSDate))
        }
        if let end = endDate {
            predicates.append(NSPredicate(format: "date <= %@", end as NSDate))
        }
        if let limit = count {
            fr.fetchLimit = limit
        }
        fr.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return try context.fetch(fr)
    }
    
    /// Loads the profiles from the storage
    internal static func loadProfiles(_ context : NSManagedObjectContext) throws -> [Profile] {
        let fr : NSFetchRequest = Profile.fetchRequest()
        return try context.fetch(fr)
    }
    
    /* SAVE DATA */
    
    /* DELETE DATA */
}
