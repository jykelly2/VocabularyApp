//
//  DisplayView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-04.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices

class DisplayView: UIViewController, UIViewControllerTransitioningDelegate{
    
       let isPhone = UIDevice.isPhone
   let wordController = WordController()
    var wordFavourited = false
    var wordLearned = false
    
    let wordTitle: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .left
        label.textColor = .darkerGray
         return label
     }()
    
    let wordType: UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
        label.textColor = .darkerGray
            return label
        }()
    let wordCategory : UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
    let wordDefinition: UILabel = {
           let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
        label.textColor = .darkerGray
            return label
        }()
    let wordSentence : UILabel = {
          let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
        label.textColor = .darkerGray
            return label
        }()

    let searchView : UIView = {
             let view = UIView()
                 view.translatesAutoresizingMaskIntoConstraints = false
             view.backgroundColor = .white
             return view
      }()
    
    
    let shareView : UIView = {
             let view = UIView()
                 view.translatesAutoresizingMaskIntoConstraints = false
             view.backgroundColor = .white
             return view
      }()
    
    let favouriteView : UIView = {
             let view = UIView()
                 view.translatesAutoresizingMaskIntoConstraints = false
             view.backgroundColor = .white
             return view
      }()
    
    let learnedView : UIView = {
             let view = UIView()
                 view.translatesAutoresizingMaskIntoConstraints = false
             view.backgroundColor = .white
             return view
      }()
    
    let searchLbL: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.text = "Search"
        label.textColor = .darkerGray
        return label
    }()
    let shareLbL: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
          label.textAlignment = .left
         label.minimumScaleFactor = 0.1
         label.adjustsFontSizeToFitWidth = true
         label.numberOfLines = 1
        label.text = "Share"
         label.textColor = .darkerGray
         return label
     }()
    let favouriteLbL: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.text = "Favourite"
        label.textColor = .darkerGray
        return label
    }()
    let learnedLbL: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.text = "Learned"
        label.textColor = .darkerGray
        return label
    }()
    
    let actionLbL: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
           label.minimumScaleFactor = 0.1
           label.adjustsFontSizeToFitWidth = true
           label.numberOfLines = 1
           label.text = "Action"
           label.textColor = .darkerGray
           return label
       }()
    
   
    lazy var closeBtn: UIButton = {
             let btn = UIButton.init(type: .system)
                btn.translatesAutoresizingMaskIntoConstraints = false
          let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
           btn.clipsToBounds = true
           btn.layer.backgroundColor = UIColor.lightGrey.cgColor
        btn.tintColor = .lightGray
          btn.setImage(img, for: .normal)
                return btn
    }()
    let saveBtn: UIButton = {
        let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Save", for: .normal)
            btn.isUserInteractionEnabled = true
            btn.layer.backgroundColor = UIColor.teal.cgColor
            btn.setTitleColor(UIColor.white, for: .normal)
           // btn.addTarget(self, action: #selector(premiumTapped), for: .touchUpInside)
        return btn
    }()
    let saveImg: UIImageView = {
           let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.image = UIImage(named: "save")
           img.contentMode = .scaleAspectFit
           return img
       }()
     
    let searchImg: UIImageView = {
             let img = UIImageView()
             img.translatesAutoresizingMaskIntoConstraints = false
             img.image = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysTemplate)
             img.contentMode = .scaleAspectFit
            img.tintColor = .teal
             return img
         }()
    let shareImg: UIImageView = {
                   let img = UIImageView()
                   img.translatesAutoresizingMaskIntoConstraints = false
                   img.image = UIImage(named: "shareIcon")?.withRenderingMode(.alwaysTemplate)
                img.tintColor = .teal
                   img.contentMode = .scaleAspectFit
                   return img
    }()
    let speakerImg: UIImageView = {
                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
                img.image = UIImage(named: "speakerIcon")?.withRenderingMode(.alwaysTemplate)
                img.tintColor = .teal
                img.contentMode = .scaleAspectFit
                return img
            }()
    let learnedImg: UIImageView = {
                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
              //  img.image = UIImage(named: "save")
                img.contentMode = .scaleAspectFit
                return img
            }()
    let favouriteImg: UIImageView = {
                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
              //  img.image = UIImage(named: "save")
                img.contentMode = .scaleAspectFit
                return img
    }()

    let containerView : UIView = {
               let view = UIView()
                   view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .white//UIColor.teal.withAlphaComponent(0.4)
               return view
       }()

    @objc func close(){
        self.navigationController?.popViewController(animated: true)
    }
    let screenScale = UIScreen.main.scale
        let screenBounds = UIScreen.main.bounds
           
     var currentWord : WordEntity!

     override func viewDidLoad() {
         super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubview(closeBtn)
        containerView.addSubview(wordTitle)
        containerView.addSubview(wordType)
        containerView.addSubview(wordCategory)
        containerView.addSubview(wordDefinition)
        containerView.addSubview(wordSentence)
        containerView.addSubview(speakerImg)
        containerView.addSubview(actionLbL)
        containerView.addSubview(saveBtn)
        
        containerView.addSubview(searchView)
        searchView.addSubview(searchLbL)
        searchView.addSubview(searchImg)
        
        containerView.addSubview(shareView)
        shareView.addSubview(shareLbL)
        shareView.addSubview(shareImg)
        
       containerView.addSubview(favouriteView)
       favouriteView.addSubview(favouriteLbL)
       favouriteView.addSubview(favouriteImg)
        
        containerView.addSubview(learnedView)
       learnedView.addSubview(learnedLbL)
        learnedView.addSubview(learnedImg)
        
        let closeTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(closeTapGestureRecognizer)
        closeTapGestureRecognizer.title = "Close"
      
        let saveTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
             saveBtn.isUserInteractionEnabled = true
             saveBtn.addGestureRecognizer(saveTapGestureRecognizer)
             saveTapGestureRecognizer.title = "Save"
        
         let speakerTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        speakerImg.isUserInteractionEnabled = true
        speakerImg.addGestureRecognizer(speakerTapGestureRecognizer)
        speakerTapGestureRecognizer.title = "Speaker"
        
         let searchTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        searchView.isUserInteractionEnabled = true
        searchView.addGestureRecognizer(searchTapGestureRecognizer)
        searchTapGestureRecognizer.title = "Search"
        
        let shareTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        shareView.isUserInteractionEnabled = true
        shareView.addGestureRecognizer(shareTapGestureRecognizer)
        shareTapGestureRecognizer.title = "Share"
        
        let favouriteTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favouriteView.isUserInteractionEnabled = true
        favouriteView.addGestureRecognizer(favouriteTapGestureRecognizer)
        favouriteTapGestureRecognizer.title = "Favourite"
        
        let learnedTapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        learnedView.isUserInteractionEnabled = true
        learnedView.addGestureRecognizer(learnedTapGestureRecognizer)
        learnedTapGestureRecognizer.title = "Learned"
   
        //self.view.backgroundColor = .clear
        self.view.backgroundColor = .veryLightGray//UIColor(patternImage: UIImage(named: "displayBGEmotion")!)
     }
    
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    
       // self.presentingViewController?.modalPresentationStyle = .fullScreen
       // self.presentingViewController?.modalPresentationStyle = .popover
        animateIn()
    }
    
    @objc func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            self.view.alpha = 0
        }
        ){(complete) in
            if complete {
                self.view.removeFromSuperview()
            }
            
        }
    }
   /* @objc func animateIn(){
        //come from the top
        self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
            self.view.transform = .identity
            self.view.alpha = 1
        })
    }*/

    @objc func animateIn(){
           //come from the top
        self.view.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  1, initialSpringVelocity: 0.1 , options: .curveEaseInOut,animations: {
               self.view.transform = .identity
            
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1
           })
       }
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
         let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        let safeAreaHeight = safeArea.layoutFrame.height
        wordFavourited = currentWord.favourited
        wordLearned = currentWord.learned
        wordTitle.text = currentWord.title
        wordType.text = "\(currentWord.category!) (\(currentWord.wordType!))"
        wordDefinition.text = currentWord.definition
        wordSentence.text = " \"\(currentWord.sentence!)\" "
        
        favouriteImg.image = favouriteImg.colorFavouritePicture(imageView: favouriteImg, liked: wordFavourited)

        learnedImg.image = learnedImg.colorLearnedPicture(imageView: learnedImg, liked: wordLearned)
        
        if isPhone{
        wordTitle.font = UIFont(name: "Helvetica-Bold", size:safeAreaHeight/30 )
        wordType.font = UIFont(name: "AvenirNext-UltraLightItalic", size: safeAreaHeight/50)
        wordDefinition.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/40)
        wordSentence.font = UIFont(name: "AvenirNext-Italic", size: safeAreaHeight/40)

        saveBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/55)
         learnedLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        searchLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        shareLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        favouriteLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        actionLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/40)
  
        // -------------------Anchor Views----------------------------//
        
        containerView.layer.cornerRadius = safeAreaHeight/50
        containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/70).isActive = true
        containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/70).isActive = true
        containerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.95).isActive=true
        containerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive=true
        containerView.addShadow()
        
        closeBtn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: safeAreaWidth/40).isActive = true
        closeBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
        closeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
        closeBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: safeAreaWidth/50).isActive = true
        
        saveBtn.layer.cornerRadius = safeAreaHeight/50
        //saveBtn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: safeAreaHeight/80).isActive = true
        saveBtn.centerYAnchor.constraint(equalTo: closeBtn.centerYAnchor).isActive = true
         saveBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.2).isActive = true
         saveBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.08).isActive = true
         saveBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -safeAreaHeight/80).isActive = true
        
        closeBtn.layer.cornerRadius = 0.5 * closeBtn.bounds.size.width
        closeBtn.imageEdgeInsets = UIEdgeInsets(
                              top: closeBtn.frame.size.height/5,
                              left: closeBtn.frame.size.width/5,
                              bottom: closeBtn.frame.size.height/5,
                              right: closeBtn.frame.size.width/5)
  
        wordTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: safeAreaHeight/10).isActive = true
        wordTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:safeAreaHeight/40).isActive = true

        speakerImg.centerYAnchor.constraint(equalTo: wordTitle.centerYAnchor).isActive = true
        speakerImg.leadingAnchor.constraint(equalTo: wordTitle.trailingAnchor, constant:safeAreaHeight/40).isActive = true
        speakerImg.widthAnchor.constraint(equalTo:safeArea.widthAnchor, multiplier:0.06).isActive = true
        speakerImg.heightAnchor.constraint(equalTo:safeArea.widthAnchor, multiplier:0.06).isActive = true

        wordType.topAnchor.constraint(equalTo: wordTitle.bottomAnchor, constant: 10).isActive = true
        wordType.leadingAnchor.constraint(equalTo: wordTitle.leadingAnchor).isActive = true
      
        wordDefinition.topAnchor.constraint(equalTo: wordType.bottomAnchor, constant: safeAreaHeight/30).isActive = true
        wordDefinition.leadingAnchor.constraint(equalTo: wordTitle.leadingAnchor).isActive = true
        wordDefinition.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,  constant: -safeAreaHeight/60).isActive=true
      
         wordSentence.topAnchor.constraint(equalTo: wordDefinition.bottomAnchor, constant: safeAreaHeight/20).isActive = true
        wordSentence.leadingAnchor.constraint(equalTo: wordTitle.leadingAnchor).isActive = true
         wordSentence.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -safeAreaHeight/30).isActive=true

        actionLbL.topAnchor.constraint(equalTo: wordSentence.bottomAnchor, constant: safeAreaHeight/20).isActive = true
        actionLbL.leadingAnchor.constraint(equalTo: wordTitle.leadingAnchor).isActive = true
        actionLbL.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,  constant: -safeAreaHeight/60).isActive=true
        
        //searchView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -safeAreaWidth/5).isActive = true
        //searchView.bottomAnchor.constraint(equalTo: learnedView.topAnchor, constant: -safeAreaHeight/20).isActive = true
        //, constant: safeAreaWidth/60
        searchView.leadingAnchor.constraint(equalTo: wordTitle.leadingAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: actionLbL.bottomAnchor, constant: safeAreaHeight/40).isActive = true
        searchView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.4).isActive = true
        searchView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive = true
        searchView.backgroundColor = .lightGrey
        
        
        //searchImg.centerXAnchor.constraint(equalTo: searchView.centerXAnchor).isActive = true
        //searchImg.bottomAnchor.constraint(equalTo: searchLbL.topAnchor, constant: -safeAreaHeight/80).isActive = true
        searchImg.topAnchor.constraint(equalTo: searchView.topAnchor, constant: safeAreaHeight/80).isActive = true
        searchImg.widthAnchor.constraint(equalTo: searchView.widthAnchor,  multiplier:0.2).isActive = true
        searchImg.heightAnchor.constraint(equalTo:searchView.widthAnchor,  multiplier:0.2).isActive = true
        searchImg.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: safeAreaHeight/80).isActive = true
        searchLbL.centerYAnchor.constraint(equalTo: searchImg.centerYAnchor).isActive = true
        searchLbL.leadingAnchor.constraint(equalTo: searchImg.trailingAnchor, constant: safeAreaWidth/30).isActive = true
        searchLbL.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -safeAreaWidth/80).isActive = true
        
        //shareView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: safeAreaWidth/5).isActive = true
        shareView.leadingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: safeAreaWidth/30).isActive = true
        shareView.topAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
        shareView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.4).isActive = true
        shareView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive = true
         shareView.backgroundColor = .lightGrey
        
         shareImg.topAnchor.constraint(equalTo: shareView.topAnchor, constant: safeAreaHeight/80).isActive = true
         shareImg.widthAnchor.constraint(equalTo: shareView.widthAnchor,  multiplier:0.2).isActive = true
         shareImg.heightAnchor.constraint(equalTo:shareView.widthAnchor,  multiplier:0.2).isActive = true
         shareImg.leadingAnchor.constraint(equalTo: shareView.leadingAnchor, constant: safeAreaHeight/80).isActive = true
         shareLbL.centerYAnchor.constraint(equalTo: shareImg.centerYAnchor).isActive = true
         shareLbL.leadingAnchor.constraint(equalTo: shareImg.trailingAnchor, constant: safeAreaWidth/30).isActive = true
         shareLbL.trailingAnchor.constraint(equalTo: shareView.trailingAnchor, constant: -safeAreaWidth/80).isActive = true
        
        learnedView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor).isActive = true
        learnedView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: safeAreaHeight/30).isActive = true
        learnedView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.4).isActive = true
        learnedView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive = true
        learnedView.backgroundColor = .lightGrey
        
       learnedImg.topAnchor.constraint(equalTo: learnedView.topAnchor, constant: safeAreaHeight/80).isActive = true
        learnedImg.widthAnchor.constraint(equalTo: learnedView.widthAnchor,  multiplier:0.2).isActive = true
        learnedImg.heightAnchor.constraint(equalTo: learnedView.widthAnchor,  multiplier:0.2).isActive = true
        learnedImg.leadingAnchor.constraint(equalTo: learnedView.leadingAnchor, constant: safeAreaHeight/80).isActive = true
        learnedLbL.centerYAnchor.constraint(equalTo: learnedImg.centerYAnchor).isActive = true
        learnedLbL.leadingAnchor.constraint(equalTo: learnedImg.trailingAnchor, constant: safeAreaWidth/30).isActive = true
        learnedLbL.trailingAnchor.constraint(equalTo: learnedView.trailingAnchor, constant: -safeAreaWidth/80).isActive = true
        
        favouriteView.leadingAnchor.constraint(equalTo: shareView.leadingAnchor).isActive = true
        favouriteView.topAnchor.constraint(equalTo: learnedView.topAnchor).isActive = true
        favouriteView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.4).isActive = true
        favouriteView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive = true
        favouriteView.backgroundColor = .lightGrey
         
       favouriteImg.topAnchor.constraint(equalTo: favouriteView.topAnchor, constant: safeAreaHeight/80).isActive = true
        favouriteImg.widthAnchor.constraint(equalTo: favouriteView.widthAnchor,  multiplier:0.2).isActive = true
        favouriteImg.heightAnchor.constraint(equalTo: favouriteView.widthAnchor,  multiplier:0.2).isActive = true
         favouriteImg.leadingAnchor.constraint(equalTo: favouriteView.leadingAnchor, constant: safeAreaHeight/80).isActive = true
         favouriteLbL.centerYAnchor.constraint(equalTo: favouriteImg.centerYAnchor).isActive = true
         favouriteLbL.leadingAnchor.constraint(equalTo: favouriteImg.trailingAnchor, constant: safeAreaWidth/30).isActive = true
         favouriteLbL.trailingAnchor.constraint(equalTo: favouriteView.trailingAnchor, constant: -safeAreaWidth/80).isActive = true

        searchView.layer.cornerRadius = safeAreaHeight/40
        shareView.layer.cornerRadius = safeAreaHeight/40
        favouriteView.layer.cornerRadius = safeAreaHeight/40
        learnedView.layer.cornerRadius = safeAreaHeight/40
        }else{
            
        }
       /* searchView.layer.cornerRadius = searchView.frame.size.width/2
        searchView.clipsToBounds = true
        searchView.layer.borderColor = UIColor.white.cgColor
        searchView.layer.borderWidth = 5.0
        
        shareView.layer.cornerRadius = shareView.frame.size.width/2
        shareView.clipsToBounds = true
        shareView.layer.borderColor = UIColor.white.cgColor
        shareView.layer.borderWidth = 5.0
        
        learnedView.layer.cornerRadius = learnedView.frame.size.width/2
        learnedView.clipsToBounds = true
        learnedView.layer.borderColor = UIColor.white.cgColor
        learnedView.layer.borderWidth = 5.0
        
        favouriteView.layer.cornerRadius = favouriteView.frame.size.width/2
        favouriteView.clipsToBounds = true
        favouriteView.layer.borderColor = UIColor.white.cgColor
        favouriteView.layer.borderWidth = 5.0*/
        
       /* searchImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -(screenSize.width * 0.12)).isActive = true
        
      //  searchImg.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        //searchImg.topAnchor.constraint(equalTo: wordSentence.bottomAnchor, constant: 150).isActive = true
        //searchImg.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,  constant: 30).isActive = true
        //searchImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -250).isActive=true
        searchImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive = true
        searchImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.07).isActive = true
        
        searchImg.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/7).isActive = true
        
        // shareImg.topAnchor.constraint(equalTo: wordSentence.bottomAnchor, constant: 147).isActive = true
        //shareImg.leadingAnchor.constraint(equalTo: searchImg.trailingAnchor,  constant: screenSize.width * 0.03).isActive = true
        shareImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: -(screenSize.width * 0.04)).isActive = true
        // shareImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -250).isActive=true
        // shareImg.widthAnchor.constraint(equalToConstant: 35).isActive = true
        // shareImg.heightAnchor.constraint(equalToConstant: 35).isActive = true
        shareImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.10).isActive=true
        shareImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
        shareImg.bottomAnchor.constraint(equalTo: searchImg.bottomAnchor).isActive = true
        /*view.addSubview(seperater)
                     
        // seperater.topAnchor.constraint(equalTo: wordSentence.bottomAnchor, constant: 142).isActive = true
         seperater.leadingAnchor.constraint(equalTo: shareImg.trailingAnchor,  constant:  screenSize.width * 0.02).isActive = true
         seperater.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -(screenSize.height * 0.02)).isActive = true
      
        
        // favouriteImg.topAnchor.constraint(equalTo: wordSentence.bottomAnchor, constant: 147).isActive = true
        favouriteImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: (screenSize.width * 0.04)).isActive = true
          //favouriteImg.leadingAnchor.constraint(equalTo: shareImg.trailingAnchor,  constant:  screenSize.width * 0.03).isActive = true
               // shareImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -250).isActive=true
        favouriteImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive = true
        favouriteImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.07).isActive = true
         favouriteImg.bottomAnchor.constraint(equalTo:searchImg.bottomAnchor).isActive = true
       
        learnedImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: (screenSize.width * 0.12)).isActive = true
         //learnedImg.topAnchor.constraint(equalTo: wordSentence.bottomAnchor, constant: 147).isActive = true
         // learnedImg.leadingAnchor.constraint(equalTo: favouriteImg.trailingAnchor,  constant: screenSize.width * 0.03).isActive = true
                      // shareImg.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -250).isActive=true
        learnedImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive = true
          learnedImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.07).isActive = true
         learnedImg.bottomAnchor.constraint(equalTo:searchImg.bottomAnchor).isActive = true*/

        */
    }
    
    @objc func imageTapped(tapGestureRecognizer: MyTapGesture)
    {
        switch tapGestureRecognizer.title {
        case "Close":
            closeView()
        case "Speaker":
            playAudio()
        case "Search":
            searchWord()
        case "Share":
            shareWord()
        case "Favourite":
            favouriteWord()
        case "Save":
            saveWord()
        default:
            learnedWord()
        }
    }
    
    func saveWord(){
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
        let pickListView = mainSB.instantiateViewController(identifier: "PickListView") as! PickListView
        pickListView.word = currentWord
        pickListView.modalPresentationStyle = .overFullScreen
        present(pickListView, animated: false, completion: nil)
    }
    
    func closeView(){
        dismiss(animated: true, completion: nil)
               // animateOut()
    }
    func playAudio(){
        let utterance = AVSpeechUtterance(string: wordTitle.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    func searchWord(){
        let url = "https://www.google.com/search?client=safari&channel=mac_bm&ei=4YXQXvPsHKiIgge75L2oDA&q="+wordTitle.text! + "+definition"
       showSafariVC(for: url)
    }
    
    //share not working on ipad
    func shareWord(){
        let shareUrl = "https://apps.apple.com/app/id1084540807?fbclid=IwAR1ctXGVKLXubpvHB9GCJ-tGzpfhCHyfyRLi6dRSIKJFViAVKTmdyZC6uJU"
        let screenShot = self.view.takeScreenshot()
        let activityVC = UIActivityViewController(activityItems: [screenShot], applicationActivities: nil)
        activityVC.isModalInPresentation = true
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil) 
    }
    
    func favouriteWord(){
        wordController.checkFavourited(title: wordTitle.text!)
        wordFavourited = !wordFavourited
        favouriteImg.image = favouriteImg.colorFavouritePicture(imageView: favouriteImg, liked: wordFavourited)


       /* if wordFavourited == true{
            favouriteImg.image = (UIImage(named: "Favourite")?.withRenderingMode(.alwaysTemplate))!
                 favouriteImg.tintColor = .red
        }else{
            favouriteImg.image = (UIImage(named: "Favourite")?.withRenderingMode(.alwaysOriginal))!
                    }*/
       }
    
    func learnedWord(){
        wordController.checkLearned(title: wordTitle.text!)
        wordLearned = !wordLearned
        
        learnedImg.image = learnedImg.colorLearnedPicture(imageView: learnedImg, liked: wordLearned)
       }
    
    func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url:url)
        present(safariVC, animated: true)
    }
}
class MyTapGesture: UITapGestureRecognizer {
    var title = String()
}
class MyTappedGesture: UITapGestureRecognizer {
    var list = String()
}
extension UIView {
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil{
            return image!
        }
        return UIImage()
    }
}

/*extension DisplayView: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       print("here")
        return AnimationController(animationDuration: 3.5, animationType: .present)
    }
}*/
