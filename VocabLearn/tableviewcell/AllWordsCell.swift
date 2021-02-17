//
//  AllWordsCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-10.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class AllWordsCell: UITableViewCell {
    let title: UILabel = {
                     let label = UILabel()
                     label.translatesAutoresizingMaskIntoConstraints = false
                     label.textAlignment = .left
                     //label.minimumScaleFactor = 0.1
                    //  label.adjustsFontSizeToFitWidth = true
                    //  label.numberOfLines = 1
                     return label
          }()
    
   
    /*let addBtn: UIButton = {
           let btn = UIButton.init(type: .system)
              btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "plusicon")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(img, for: .normal)
        btn.clipsToBounds = true
        btn.layer.backgroundColor = UIColor.lightGrey.cgColor
        btn.addTarget(self, action: #selector(AddWordView.addTapped), for: .touchUpInside)
              return btn
    }()*/
    
    func setWord(word: WordEntity){
        title.textColor = .lightGray
        title.text = word.title
      //  title.font = UIFont(name: "Helvetica-Bold", size: 25)
        
        contentView.addSubview(title)
        // title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/50).isActive = true
          title.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
                    //  title.centerXAnchor.constraint(equalTo:contentView.centerXAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width/30).isActive = true
        
          //title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -10).isActive=true
    }
}
