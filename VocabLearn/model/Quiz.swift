//
//  Quiz.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-21.
//  Copyright © 2020 Jun K. All rights reserved.
//
import UIKit
public class Quiz {

       // public var Id: Int
        public var type: String
        public var category: String
        public var list: String
        public var score: Int
        public var date : Date
   
    init(type:String, category:String, list:String, score:Int, date:Date) {
        self.type = type
        self.category = category
        self.list = list
        self.score = score
        self.date = date
    }

}
