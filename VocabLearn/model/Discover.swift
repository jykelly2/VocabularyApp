//
//  Discover.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-03.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class Discover {
     public var title: String
     public var wordType: String
     public var definition: String
    public var featuredImage: UIImage
    public var color: UIColor
    
    init(title: String, wordType: String, definition: String, featuredImage: UIImage, color:UIColor) {
        
        self.title = title
        self.wordType = wordType
        self.definition = definition
        self.featuredImage = featuredImage
        self.color = color
    }
}
        
