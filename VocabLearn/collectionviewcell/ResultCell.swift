//
//  ResultCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-22.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class ResultCell: UICollectionViewCell {
    
    let isPhone = UIDevice.isPhone
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
    
    let questionLbl: UILabel = {
           let Lbl = UILabel()
           Lbl.translatesAutoresizingMaskIntoConstraints = false
           Lbl.numberOfLines = 0
           Lbl.textAlignment = .left
        Lbl.adjustsFontSizeToFitWidth = true
        Lbl.adjustsFontForContentSizeCategory = true
           Lbl.textColor = .black
        return Lbl
       }()
    
    let correctAns: UILabel = {
             let Lbl = UILabel()
             Lbl.translatesAutoresizingMaskIntoConstraints = false
             Lbl.numberOfLines = 0
             Lbl.textAlignment = .left
        // Lbl.adjustsFontSizeToFitWidth = true
         // Lbl.adjustsFontForContentSizeCategory = true
             Lbl.textColor = .black
             return Lbl
         }()
    let selectedAns: UILabel = {
             let Lbl = UILabel()
             Lbl.translatesAutoresizingMaskIntoConstraints = false
             Lbl.numberOfLines = 0
             Lbl.textAlignment = .left
        //  Lbl.adjustsFontSizeToFitWidth = true
         // Lbl.adjustsFontForContentSizeCategory = true
             Lbl.textColor = .black
             return Lbl
         }()
    let correctLbl: UILabel = {
             let Lbl = UILabel()
             Lbl.translatesAutoresizingMaskIntoConstraints = false
             Lbl.numberOfLines = 0
             Lbl.textAlignment = .left
         // Lbl.adjustsFontSizeToFitWidth = true
            Lbl.text = "Correct Answer"
        //  Lbl.adjustsFontForContentSizeCategory = true
             Lbl.textColor = .darkGray
             return Lbl
         }()
    
    let selectedLbl: UILabel = {
        let Lbl = UILabel()
        Lbl.translatesAutoresizingMaskIntoConstraints = false
        Lbl.numberOfLines = 0
        Lbl.textAlignment = .left
     //Lbl.adjustsFontSizeToFitWidth = true
         Lbl.text = "Your Answer"
    // Lbl.adjustsFontForContentSizeCategory = true
        Lbl.textColor = .darkGray
        return Lbl
    }()
    
    let numberLbl: UILabel = {
         let Lbl = UILabel()
         Lbl.translatesAutoresizingMaskIntoConstraints = false
         Lbl.numberOfLines = 0
         Lbl.textAlignment = .center
      //Lbl.adjustsFontSizeToFitWidth = true
    //  Lbl.adjustsFontForContentSizeCategory = true
         Lbl.textColor = .black
         return Lbl
     }()
    
    let selectedView: UIView = {
          let view = UIView()
          view.translatesAutoresizingMaskIntoConstraints = false
       // view.backgroundColor = .green
          return view
      }()
    
    let correctView: UIView = {
          let view = UIView()
          view.translatesAutoresizingMaskIntoConstraints = false
       // view.backgroundColor = .red
          return view
      }()
    
  /*  let numberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .clear
        return view
    }()*/
    
    let resultImg: UIImageView = {
     let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
       img.contentMode = .scaleAspectFit
     return img
    }()
    
    var cellResult: Result!

    func setResult(result: Result, number: Int){
      let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        
        let safeAreaHeight = contentView.frame.height
        let safeAreaWidth = contentView.frame.width

        cellResult = result
       // questionLbl.numberOfLines = 0

       // questionLbl.minimumScaleFactor = 0.1
             //  questionLbl.adjustsFontSizeToFitWidth = true
        selectedLbl.minimumScaleFactor = 0.1
                      selectedLbl.adjustsFontSizeToFitWidth = true
                     selectedLbl.numberOfLines = 1
        selectedAns.minimumScaleFactor = 0.1
                      selectedAns.adjustsFontSizeToFitWidth = true
                     selectedAns.numberOfLines = 1
        correctLbl.minimumScaleFactor = 0.1
                      correctLbl.adjustsFontSizeToFitWidth = true
                     correctLbl.numberOfLines = 1
        correctAns.minimumScaleFactor = 0.1
                      correctAns.adjustsFontSizeToFitWidth = true
                     correctAns.numberOfLines = 1
        questionLbl.font = UIFont(name: "Helvetica", size: safeAreaHeight/8.1)
        questionLbl.text = result.question //"In earlier times, castigation specifically meant restoring one to a religiously pure state, called chastity hghghgh ghghghg hghghg"
        
       numberLbl.font = UIFont(name: "Helvetica", size: screenSize.width * 0.03)
        numberLbl.text = String(number)

        selectedLbl.font = UIFont(name: "Helvetica", size: safeAreaHeight/8.3)
          
      
        selectedAns.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/8.2)
        selectedAns.text = result.selectedAns//"Conspicuouslydjn"
        
        correctLbl.font = UIFont(name: "Helvetica", size: safeAreaHeight/8.3)

        correctAns.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/8.2)
        correctAns.text = result.correctAns //"Conspicuouslydjn"//result.correctAns

        if result.selectedAns == result.correctAns{
         resultImg.image = UIImage(named: "correct")
            contentView.backgroundColor = .lightBlue//UIColor.systemGreen.withAlphaComponent(0.3)
        }else{
            resultImg.image = UIImage(named: "close")
            contentView.backgroundColor = .lightRed//UIColor.red.withAlphaComponent(0.3)
        }
        contentView.layer.cornerRadius = safeAreaHeight/20
        
         contentView.addSubview(resultImg)
        resultImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeAreaHeight/40).isActive = true
        resultImg.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.07).isActive = true
        resultImg.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.07).isActive = true
         resultImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeAreaWidth/40).isActive = true
              
       contentView.addSubview(questionLbl)
        questionLbl.topAnchor.constraint(equalTo:contentView.topAnchor, constant: safeAreaHeight/30).isActive = true
        //questionLbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3).isActive = true
        questionLbl.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: safeAreaWidth/30).isActive = true
        questionLbl.trailingAnchor.constraint(equalTo:resultImg.leadingAnchor).isActive = true
 
        selectedView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width/2, height: contentView.frame.height/3)
        contentView.addSubview(selectedView)
        selectedView.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: safeAreaHeight/7).isActive = true
        selectedView.addSubview(selectedLbl)
        selectedLbl.topAnchor.constraint(equalTo: selectedView.topAnchor).isActive = true
        selectedLbl.leadingAnchor.constraint(equalTo:selectedView.leadingAnchor, constant: safeAreaWidth/30).isActive = true
       // selectedLbl.heightAnchor.constraint(equalTo:contentView.heightAnchor, multiplier: 0.1).isActive = true
            //selectedLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
       
       selectedView.addSubview(selectedAns)
        selectedAns.topAnchor.constraint(equalTo: selectedLbl.bottomAnchor,constant: safeAreaHeight/60).isActive = true
        // selectedAns.heightAnchor.constraint(equalTo:contentView.heightAnchor, multiplier: 0.15).isActive = true
        selectedAns.leadingAnchor.constraint(equalTo:selectedView.leadingAnchor, constant: safeAreaWidth/30).isActive = true
        //selectedAns.bottomAnchor.constraint(equalTo:selectedView.bottomAnchor, constant: 3).isActive = true
        selectedAns.trailingAnchor.constraint(equalTo: selectedView.trailingAnchor, constant: -safeAreaWidth/40).isActive = true
        // selectedAns.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
     
        correctView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width/2.5, height: contentView.frame.height/3)
        contentView.addSubview(correctView)
        correctView.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: safeAreaHeight/7).isActive = true
          // correctView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
         correctView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width/2).isActive = true
        //correctView.leadingAnchor.constraint(equalTo: selectedView.trailingAnchor, constant: screenSize.width/60).isActive = true
        
      correctView.addSubview(correctLbl)
        correctLbl.topAnchor.constraint(equalTo:correctView.topAnchor).isActive = true
        correctLbl.leadingAnchor.constraint(equalTo: correctView.leadingAnchor).isActive = true
        // correctLbl.heightAnchor.constraint(equalTo:contentView.heightAnchor, multiplier: 0.1).isActive = true
           //   correctLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
       // correctLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: ).isActive = true
           
          correctView.addSubview(correctAns)
           correctAns.topAnchor.constraint(equalTo: correctLbl.bottomAnchor , constant: safeAreaHeight/60).isActive = true
         correctAns.leadingAnchor.constraint(equalTo: correctView.leadingAnchor).isActive = true
        //correctAns.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
       /* numberView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width/2.5, height: contentView.frame.height/3)
               contentView.addSubview(numberView)
         numberView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenSize.width/60).isActive = true
        numberView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width-(screenSize.width/40)).isActive = true
        
        numberView.addSubview(resultImg)
        resultImg.topAnchor.constraint(equalTo: numberView.topAnchor).isActive = true
        resultImg.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.07).isActive = true
        resultImg.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.07).isActive = true
        //resultImg.leadingAnchor.constraint(equalTo: numberView.leadingAnchor).isActive = true*/
        

        
    }
    

}
