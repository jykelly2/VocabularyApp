//
//  Category.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-24.
//  Copyright © 2020 Jun K. All rights reserved.
//

import Foundation
import UIKit

public class Category {

            public var title: String
            public var image: UIImage
            public var color: UIColor
            public var bgColor: UIColor
    
    init(title:String, image:UIImage,color: UIColor, bgColor:UIColor) {
        self.title = title
         self.image = image
        self.color = color
        self.bgColor = bgColor
    }

}
