//
//  Explore.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-12.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
public class Explore {

            let title: String
            let description: String
            let image : UIImage
            let list: ListEntity
    
    init(title:String, description:String, image:UIImage, list: ListEntity) {
        self.title = title
        self.description = description
        self.image = image
        self.list = list
        
    }

}
