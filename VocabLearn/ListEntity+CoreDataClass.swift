//
//  ListEntity+CoreDataClass.swift
//  VocabLearn
//
//  Created by Jun K on 2020-08-31.
//  Copyright © 2020 Jun K. All rights reserved.
//
//

import UIKit
import CoreData

@objc(ListEntity)
public class ListEntity: NSManagedObject {
    var words: [WordEntity]? {
        return self.rawWords?.array as? [WordEntity]
      }
    convenience init?(name: String, custom: Bool, category: String) {
          
          let appDelegate = UIApplication.shared.delegate as? AppDelegate
          guard let context = appDelegate?.persistentContainer.viewContext  else {
              return nil
          }
          self.init(entity: ListEntity.entity(), insertInto: context)
          self.name = name
        self.custom = custom
        self.category = category
          
      }
}
