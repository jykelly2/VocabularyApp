//
//  WordEntity+CoreDataProperties.swift
//  VocabLearn
//
//  Created by Jun K on 2020-08-31.
//  Copyright © 2020 Jun K. All rights reserved.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var added: Bool
    @NSManaged public var category: String?
    @NSManaged public var definition: String?
    @NSManaged public var favourited: Bool
    @NSManaged public var learned: Bool
    @NSManaged public var sentence: String?
    @NSManaged public var title: String?
    @NSManaged public var wordType: String?
    @NSManaged public var rawLists: NSOrderedSet?

}

// MARK: Generated accessors for rawLists
extension WordEntity {

    @objc(insertObject:inRawListsAtIndex:)
    @NSManaged public func insertIntoRawLists(_ value: ListEntity, at idx: Int)

    @objc(removeObjectFromRawListsAtIndex:)
    @NSManaged public func removeFromRawLists(at idx: Int)

    @objc(insertRawLists:atIndexes:)
    @NSManaged public func insertIntoRawLists(_ values: [ListEntity], at indexes: NSIndexSet)

    @objc(removeRawListsAtIndexes:)
    @NSManaged public func removeFromRawLists(at indexes: NSIndexSet)

    @objc(replaceObjectInRawListsAtIndex:withObject:)
    @NSManaged public func replaceRawLists(at idx: Int, with value: ListEntity)

    @objc(replaceRawListsAtIndexes:withRawLists:)
    @NSManaged public func replaceRawLists(at indexes: NSIndexSet, with values: [ListEntity])

    @objc(addRawListsObject:)
    @NSManaged public func addToRawLists(_ value: ListEntity)

    @objc(removeRawListsObject:)
    @NSManaged public func removeFromRawLists(_ value: ListEntity)

    @objc(addRawLists:)
    @NSManaged public func addToRawLists(_ values: NSOrderedSet)

    @objc(removeRawLists:)
    @NSManaged public func removeFromRawLists(_ values: NSOrderedSet)

}
