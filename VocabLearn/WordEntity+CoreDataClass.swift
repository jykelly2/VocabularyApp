//
//  WordEntity+CoreDataClass.swift
//  VocabLearn
//
//  Created by Jun K on 2020-08-31.
//  Copyright © 2020 Jun K. All rights reserved.
//
//

import UIKit
import CoreData

@objc(WordEntity)
public class WordEntity: NSManagedObject {
    var lists: [ListEntity]? {
        return self.rawLists?.array as? [ListEntity]
    }
    convenience init?(title: String, wordType: String , definition: String,sentence: String, category:String, favourited: Bool, added:Bool, learned:Bool) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext  else {
            return nil
        }
        self.init(entity: WordEntity.entity(), insertInto: context)
        self.title = title
        self.wordType = wordType
        self.definition = definition
        self.sentence = sentence
        self.category = category
        self.favourited = favourited
        self.added = added
        self.learned = learned
    }
}
