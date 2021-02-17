//
//  ExploreCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-12.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
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
    
    let exploreImg: UIImageView = {
        let img = UIImageView()
          img.translatesAutoresizingMaskIntoConstraints = false
          img.contentMode = .scaleAspectFit
        return img
    }()
    
    func setExploreList(explore: Explore, index: Int){
        let containerHeight = contentView.frame.height
        let containerWidth = contentView.frame.width
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(descriptionLbl)
        contentView.addSubview(exploreImg)
        
        titleLbl.text = explore.title
        descriptionLbl.text = explore.description
        
        var images = UIImage()
        switch index {
        case 1:
           images = explore.image.withTintColor(.teal)
        case 2:
            images = explore.image.withTintColor(.lightRed)
        case 3:
            images = explore.image.withTintColor(.lightOrange)
        case 4:
            images = explore.image.withTintColor(.lightPurple)
        default:
            images = explore.image.withTintColor(.Green)
        }
         
        exploreImg.image = images
        
        //contentView.backgroundColor = UIColor(patternImage: explore.image)
        
        //contentView.layer.cornerRadius = contentView.frame.height/30
        //contentView.addShadow()
        
        if isPhone{
        titleLbl.font = UIFont(name: "Helvetica-Bold", size: containerHeight/7)
        descriptionLbl.font = UIFont(name: "Helvetica", size: containerHeight/9)
       
          /*  exploreImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerWidth/70).isActive = true
            exploreImg.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.35).isActive=true
            exploreImg.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.35).isActive=true*/
         
            descriptionLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -containerHeight/15).isActive = true
            descriptionLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerWidth/10).isActive = true
            descriptionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerWidth/10).isActive = true
            
            titleLbl.bottomAnchor.constraint(equalTo: descriptionLbl.topAnchor,constant: containerHeight/50).isActive = true
            titleLbl.leadingAnchor.constraint(equalTo: descriptionLbl.leadingAnchor).isActive = true
            titleLbl.trailingAnchor.constraint(equalTo: descriptionLbl.trailingAnchor).isActive = true
            
            exploreImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerWidth/10).isActive = true
            exploreImg.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.35).isActive=true
            exploreImg.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.35).isActive=true
            exploreImg.bottomAnchor.constraint(equalTo: titleLbl.topAnchor,constant: -containerHeight/20).isActive = true
            exploreImg.topAnchor.constraint(equalTo: contentView.topAnchor,constant: containerHeight/20).isActive = true
            
     
        }else{
            
        }
        // titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive=true
        // titleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive=true
        //exploreImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive=true
        
        
    }

}
