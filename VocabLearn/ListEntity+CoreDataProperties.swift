//
//  ListEntity+CoreDataProperties.swift
//  VocabLearn
//
//  Created by Jun K on 2020-08-31.
//  Copyright © 2020 Jun K. All rights reserved.
//
//

import Foundation
import CoreData


extension ListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntity> {
        return NSFetchRequest<ListEntity>(entityName: "ListEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var custom: Bool
    @NSManaged public var category: String?
    @NSManaged public var rawWords: NSOrderedSet?

}

// MARK: Generated accessors for rawWords
extension ListEntity {

    @objc(insertObject:inRawWordsAtIndex:)
    @NSManaged public func insertIntoRawWords(_ value: WordEntity, at idx: Int)

    @objc(removeObjectFromRawWordsAtIndex:)
    @NSManaged public func removeFromRawWords(at idx: Int)

    @objc(insertRawWords:atIndexes:)
    @NSManaged public func insertIntoRawWords(_ values: [WordEntity], at indexes: NSIndexSet)

    @objc(removeRawWordsAtIndexes:)
    @NSManaged public func removeFromRawWords(at indexes: NSIndexSet)

    @objc(replaceObjectInRawWordsAtIndex:withObject:)
    @NSManaged public func replaceRawWords(at idx: Int, with value: WordEntity)

    @objc(replaceRawWordsAtIndexes:withRawWords:)
    @NSManaged public func replaceRawWords(at indexes: NSIndexSet, with values: [WordEntity])

    @objc(addRawWordsObject:)
    @NSManaged public func addToRawWords(_ value: WordEntity)

    @objc(removeRawWordsObject:)
    @NSManaged public func removeFromRawWords(_ value: WordEntity)

    @objc(addRawWords:)
    @NSManaged public func addToRawWords(_ values: NSOrderedSet)

    @objc(removeRawWords:)
    @NSManaged public func removeFromRawWords(_ values: NSOrderedSet)

}
