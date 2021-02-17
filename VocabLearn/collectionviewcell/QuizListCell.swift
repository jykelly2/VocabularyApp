//
//  QuizListCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-25.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class QuizListCell: UICollectionViewCell {

    let isPhone = UIDevice.isPhone
   // var delegate: CellProtocol?
    let titleLbl: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 1
        label.textColor = .lightGray
            return label
    }()
    
    let descriptionLbl: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 0
        label.textColor = .lightGray
            return label
    }()
    
    let quizImg: UIImageView = {
        let img = UIImageView()
          img.translatesAutoresizingMaskIntoConstraints = false
          img.contentMode = .scaleAspectFit
        return img
    }()
    
    func setQuizList(title: String,description: String, image: UIImage){
        let containerHeight = contentView.frame.height
        let containerWidth = contentView.frame.width
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(descriptionLbl)
        contentView.addSubview(quizImg)
        
        titleLbl.text = title
        descriptionLbl.text = description
        quizImg.image = image
        //contentView.addBackground(width: Float(containerWidth/2), height: Float(containerHeight/2), image: image)
     
       // quizImg.frame = CGRect(x: containerWidth/3, y: 0, width: containerWidth, height: containerHeight)

        if isPhone{
        titleLbl.font = UIFont(name: "Helvetica-Bold", size: containerHeight/8)
        descriptionLbl.font = UIFont(name: "Helvetica", size: containerHeight/12)

        descriptionLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -containerHeight/12).isActive = true
        descriptionLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerWidth/6).isActive = true
        descriptionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerWidth/30).isActive = true
            
        titleLbl.bottomAnchor.constraint(equalTo: descriptionLbl.topAnchor, constant: -containerHeight/40).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: descriptionLbl.leadingAnchor).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: descriptionLbl.trailingAnchor).isActive = true
            
        quizImg.topAnchor.constraint(equalTo: contentView.topAnchor,constant: containerHeight/40).isActive = true
        quizImg.bottomAnchor.constraint(equalTo: titleLbl.topAnchor,constant: -containerHeight/40).isActive = true
        quizImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerWidth/20).isActive = true
        quizImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerWidth/20).isActive = true
       // quizImg.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.55).isActive=true
  
        }else{
            
        }
        // titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive=true
        // titleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive=true
       // quizImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive=true
        
        
    }

}
