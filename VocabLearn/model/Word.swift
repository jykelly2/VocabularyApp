//
//  Word.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-21.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import Foundation

public class Word {

        public var title: String
        public var wordType: String
        public var definition: String
        public var sentence: String
        public var category: String
       // public var date: Date
        public var favourited : Bool
    public var added : Bool
    public var learned : Bool

    // public var jobDescription: String
    
    /* init(title: String, wordType: String , definition: String,sentence: String, category:String, date:Date){
        self.Id = 0
           self.title = title
           self.wordType = wordType
           self.definition = definition
           self.sentence = sentence
           self.category = category
           self.date = date
     }*/

        
    init(title: String, wordType: String , definition: String,sentence: String, category:String, favourited: Bool, added:Bool, learned:Bool){
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


