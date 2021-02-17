//
//  WordListCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-11.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class WordListCell: UICollectionViewCell {
    let wordTitle = UILabel()
    let wordCategory = UILabel()
    let learnedBtn = UIButton()
    let favouriteBtn = UIButton()
    var favouriteImage = UIImageView()
    var learnedImage = UIImageView()
    let isPhone = UIDevice.isPhone
   // let contentView = UIView()
  //  var delegate: FavouriteCellDeleagte?
    let wordController = WordController()
    let dbWordController = DbWordController()
    
    var cellWord: WordEntity!
    
    func setWord(word: WordEntity){
         cellWord = word
 
      //  contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width + safeAreaLayoutGuide.layoutFrame.width/20, height: contentView.frame.height)
       // contentView.frame = contentView.bounds
        
        //contentView.addSubview(contentView)
       // contentView.bringSubviewToFront(contentView)
        //contentView.backgroundColor = .lightGray
        let learnedTapGestureRecognizer = MyTapGesture(target: self, action: #selector(btnTapped(tapGestureRecognizer:)))
               learnedBtn.isUserInteractionEnabled = true
               learnedBtn.addGestureRecognizer(learnedTapGestureRecognizer)
               learnedTapGestureRecognizer.title = "Learned"
               
       let favouriteTapGestureRecognizer = MyTapGesture(target: self, action: #selector(btnTapped(tapGestureRecognizer:)))
               favouriteBtn.isUserInteractionEnabled = true
               favouriteBtn.addGestureRecognizer(favouriteTapGestureRecognizer)
               favouriteTapGestureRecognizer.title = "Favourite"

         learnedBtn.translatesAutoresizingMaskIntoConstraints = false
      // learnedBtn.layer.borderWidth = 2
        //learnedBtn.clipsToBounds = true
        //learnedBtn.layer.borderColor = UIColor.link.cgColor
        learnedBtn.backgroundColor = .veryLightGray
        learnedImage.image = learnedImage.colorLearnedPicture(imageView: learnedImage, liked: word.learned)
        learnedBtn.tintColor = learnedImage.tintColor

        favouriteBtn.translatesAutoresizingMaskIntoConstraints = false
        favouriteBtn.backgroundColor = .veryLightGray
        favouriteImage.image = favouriteImage.colorFavouritePicture(imageView: favouriteImage, liked: word.favourited)
        favouriteBtn.tintColor = favouriteImage.tintColor
         
         learnedBtn.setImage(learnedImage.image, for: .normal)
        favouriteBtn.setImage(favouriteImage.image, for: .normal)
        wordTitle.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width/19)
        wordTitle.textColor = .darkerGray
        let  main_string = "\(word.title!)\n(\(word.category!))"
        let string_to_color = "(\(word.category!))"

        let range = (main_string as NSString).range(of: string_to_color)

        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica", size: contentView.frame.width/23)!, range: range)
       
        wordTitle.attributedText = attribute
        wordTitle.textAlignment = .left
        wordTitle.translatesAutoresizingMaskIntoConstraints = false
        wordTitle.numberOfLines = 0
        
        
        if isPhone{
           
            
            contentView.addSubview(wordTitle)
                      // wordTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant:5).isActive = true
            wordTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
            
            contentView.addSubview(learnedBtn)
                learnedBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
           // learnedBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
            learnedBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.1).isActive=true
            learnedBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1).isActive=true

            contentView.addSubview(favouriteBtn)
            favouriteBtn.trailingAnchor.constraint(equalTo: learnedBtn.leadingAnchor, constant: -20).isActive = true
            //favouriteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
            favouriteBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1).isActive=true
             favouriteBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1).isActive=true
        }
        
        else{
            wordTitle.font = UIFont(name: "Helvetica", size: contentView.frame.width/30)
            contentView.addSubview(wordTitle)
            wordTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant:20).isActive = true
            wordTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true

            contentView.addSubview(learnedBtn)
            learnedBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
            learnedBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.04).isActive=true
            learnedBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.04).isActive=true
        
            contentView.addSubview(favouriteBtn)
            favouriteBtn.trailingAnchor.constraint(equalTo: learnedBtn.leadingAnchor, constant: -50).isActive = true
            favouriteBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.04).isActive=true
            favouriteBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.04).isActive=true
        }
        
        let height = contentView.frame.width * 0.1
        drawCicle(button: favouriteBtn, height: height)
        drawCicle(button: learnedBtn, height: height)
        favouriteBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        wordTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        learnedBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
       // learnedBtn.topAnchor.constraint(equalTo: wordTitle.topAnchor).isActive = true
        //favouriteBtn.topAnchor.constraint(equalTo: wordTitle.topAnchor).isActive = true
        
       }
    
    func drawCicle(button: UIButton, height: CGFloat){
              button.layer.cornerRadius = 0.5 * height
              button.imageEdgeInsets = UIEdgeInsets(
                                    top: height/4,
                                    left: height/4,
                                    bottom: height/4,
                                    right: height/4)
       }
    
    @objc func btnTapped(tapGestureRecognizer: MyTapGesture)
      {
        switch tapGestureRecognizer.title {
        case "Learned":
            dbWordController.checkLearned(title: cellWord.title!)
            learnedImage.image = learnedImage.colorLearnedPicture(imageView: learnedImage, liked: cellWord.learned)
             learnedBtn.tintColor = learnedImage.tintColor
        default:
            dbWordController.favouriteWord(title: cellWord.title!)
            favouriteImage.image = favouriteImage.colorFavouritePicture(imageView: favouriteImage, liked: cellWord.favourited)
            favouriteBtn.tintColor = favouriteImage.tintColor
        }
    }
}

