//
//  Section.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-24.
//  Copyright © 2020 Jun K. All rights reserved.
//

import Foundation

struct  Section {
    var day: String!
    var words: [Word]!
    var expanded: Bool!
    
    init(day: String, words: [Word], expanded: Bool) {
        self.day = day
        self.words = words
        self.expanded = expanded
    }
}
