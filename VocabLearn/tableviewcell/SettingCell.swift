//
//  SettingCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-14.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
   let isPhone = UIDevice.isPhone
    
   let label: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .left
           label.minimumScaleFactor = 0.1
           label.adjustsFontSizeToFitWidth = true
           label.numberOfLines = 1
            label.textColor = .lightGray
        return label
    }()
    let learnedCount: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .left
           label.minimumScaleFactor = 0.1
           label.adjustsFontSizeToFitWidth = true
           label.numberOfLines = 1
        label.textColor = .teal
        return label
    }()
    
    let favouritedCount: UILabel = {
              let label = UILabel()
              label.translatesAutoresizingMaskIntoConstraints = false
              label.textAlignment = .left
              label.minimumScaleFactor = 0.1
              label.adjustsFontSizeToFitWidth = true
              label.numberOfLines = 1
        label.textColor = .teal
           return label
       }()
    
    let addedCount: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .left
           label.minimumScaleFactor = 0.1
           label.adjustsFontSizeToFitWidth = true
           label.numberOfLines = 1
        label.textColor = .teal
        return label
    }()
    
    let img: UIImageView = {
              let img = UIImageView()
              img.translatesAutoresizingMaskIntoConstraints = false
              img.contentMode = .scaleAspectFit
              return img
    }()
    
    func setUpSetting(title:String, image: UIImage){
        var favourited = false
        var added = false
        var learned = false
       // var legal = false
        label.text = title
        img.image = image

        if (title == "Words Favourited"){
            favourited = true
        }
        if (title == "Words Added"){
            added = true
        }
        if (title == "Words Learned"){
            learned = true
        }
      /*  if (title == "Terms of Service" || title == "Privacy Policy"){
            legal = true
            img.image?.withTintColor(.clear)
        }*/
        img.tintColor = .teal
        
        let contentHeight = contentView.frame.height
        let contentWidth = contentView.frame.width
     
        if learned{
            let dbWordController = DbWordController()
            learnedCount.text = String(dbWordController.getLearnedWordsCount())
            contentView.addSubview(learnedCount)
            learnedCount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        if favourited{
            let dbWordController = DbWordController()
            favouritedCount.text = String(dbWordController.getFavouritedWordsCount())
            contentView.addSubview(favouritedCount)
            favouritedCount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        if added{
            let dbWordController = DbWordController()
            addedCount.text = String(dbWordController.getAddedWordsCount())
            contentView.addSubview(addedCount)
            addedCount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        if isPhone{
             contentView.addSubview(label)
            if learned{
       
               // learnedCount.font = UIFont(name: "Helvetica-Bold", size: countSize)
                //learnedCount.bounds = CGRect(x: 0.0, y: 0.0, width: countSize, height: countSize)
               // learnedCount.layer.cornerRadius = countSize / 2
               // learnedCount.layer.borderWidth = 1.0
                //learnedCount.layer.backgroundColor = UIColor.clear.cgColor
                //learnedCount.layer.borderColor = UIColor.green.cgColor
              learnedCount.font = UIFont(name: "Helvetica-Bold", size: 20)
              learnedCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38).isActive = true
                 //learnedCount.layer.cornerRadius = 0.5 * learnedCount.bounds.size.width
               // contentView.addSubview(label)
               //label.leadingAnchor.constraint(equalTo: learnedCount.trailingAnchor, constant: contentWidth/30).isActive = true
            }
            else if favourited {
                favouritedCount.font = UIFont(name: "Helvetica-Bold", size: 20)
                favouritedCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38).isActive = true
                //contentView.addSubview(label)
               // label.leadingAnchor.constraint(equalTo: favouritedCount.trailingAnchor, constant: contentWidth/30).isActive = true
            }
           else if added {
                addedCount.font = UIFont(name: "Helvetica-Bold", size: 20)
                addedCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38).isActive = true
                //-contentWidth/10
            }
           // else if !legal{
             contentView.addSubview(img)
                    img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26).isActive = true
               // -contentWidth/5
                   // label.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: contentWidth/30).isActive = true
                
                img.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.09).isActive=true
               img.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.09).isActive=true
                img.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            //}

        }else{
            //label.font = UIFont(name: "Helvetica", size: contentView.frame.width/22)
                      contentView.addSubview(label)
                       label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23).isActive = true
                   
                       contentView.addSubview(img)
                         img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
                          img.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.05).isActive=true
                         img.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.05).isActive=true
        }
        label.font = UIFont(name: "Helvetica", size: 18)
         label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
       
    }

}
