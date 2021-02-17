//
//  Result.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-22.
//  Copyright © 2020 Jun K. All rights reserved.
//

import Foundation

public class Result {

            let question: String
            let correctAns: String
            let selectedAns : String
            let isCorrect: Bool
    
    init(question:String, correctAns:String, selectedAns:String, isCorrect: Bool) {
        self.question = question
        self.correctAns = correctAns
        self.selectedAns = selectedAns
        self.isCorrect = isCorrect
        
    }

}
