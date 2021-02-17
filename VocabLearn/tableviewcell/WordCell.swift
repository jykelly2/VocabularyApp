//
//  WordCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-23.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var wordTitle: UILabel!
    @IBOutlet weak var wordType: UILabel!
    @IBOutlet weak var wordDefinition: UILabel!
    @IBOutlet weak var wordSentence: UILabel!
    @IBOutlet weak var wordCategory: UILabel!    
   // @IBOutlet weak var wordDate: UILabel!
    @IBOutlet weak var wordID: UILabel!
    
    
    func setWord(word: Word){
        wordTitle.text = word.title
        wordType.text = word.wordType
        wordDefinition.text = word.definition
        wordSentence.text = word.sentence
        wordCategory.text = word.category
//        wordDate.text = String(describing: word.date)
        
    }
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
