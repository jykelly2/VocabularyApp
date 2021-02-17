//
//  IntroductionViews.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-05.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UserNotifications
import UIKit



class IntroductionViews: UIViewController, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
  
    let isPhone = UIDevice.isPhone
    @IBOutlet var holderView: UIView!
   let scrollView = UIScrollView()

    let customizeLbl: UILabel = {
        let customizeLbl = UILabel()
        customizeLbl.translatesAutoresizingMaskIntoConstraints = false
        customizeLbl.numberOfLines = 0
        customizeLbl.textAlignment = .center
        customizeLbl.text = "Customize list"
        customizeLbl.textColor = .systemGreen
        return customizeLbl
    }()
    let deleteLbl: UILabel = {
        let deleteLbl = UILabel()
        deleteLbl.translatesAutoresizingMaskIntoConstraints = false
        deleteLbl.numberOfLines = 0
        deleteLbl.textAlignment = .center
        deleteLbl.text = "Delete Words"
        deleteLbl.textColor = .systemRed
        return deleteLbl
    }()
    let testLbl : UILabel = {
        let testLbl = UILabel()
        testLbl.translatesAutoresizingMaskIntoConstraints = false
        testLbl.numberOfLines = 0
        testLbl.textAlignment = .center
        testLbl.text = "Take Quizzes"
        testLbl.textColor = .systemOrange
        return testLbl
    }()
    let progressLbl : UILabel = {
        let progressLbl = UILabel()
        progressLbl.translatesAutoresizingMaskIntoConstraints = false
        progressLbl.numberOfLines = 0
        progressLbl.textAlignment = .center
        progressLbl.text = "Track Progress"
        progressLbl.textColor = .systemBlue
        return progressLbl
    }()
    
    //-------------- PAGE 1 --------------------------//
    
    lazy var titleLblOne: UILabel = {
         let titleLbl = UILabel()
              titleLbl.textAlignment = .center
            //  titleLbl.font = UIFont(name: "Helvetica", size: 32)
              titleLbl.translatesAutoresizingMaskIntoConstraints = false
              titleLbl.text = "V O C A L E"
              titleLbl.numberOfLines = 0
        titleLbl.textColor = .darkerGray
                 return titleLbl
    }()
    lazy var descLblOne: UILabel = {
             let descriptionLbl = UILabel()
        descriptionLbl.textAlignment = .center
             descriptionLbl.numberOfLines = 0
            //  descriptionLbl.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 14)
                descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
               descriptionLbl.text = "Explore new vocabularies"
        descriptionLbl.textColor = .lightGray
                   return descriptionLbl
    }()
    
    lazy var swipeLbl: UILabel = {
             let descriptionLbl = UILabel()
        descriptionLbl.textAlignment = .center
             descriptionLbl.numberOfLines = 0
             // descriptionLbl.font = UIFont(name: "AvenirNext", size: 12)
                descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
               descriptionLbl.text = "Swipe to begin"
        descriptionLbl.textColor = .lightGray
                   return descriptionLbl
    }()
    
    let logoImg: UIButton = {
           let img = UIButton()
           img.translatesAutoresizingMaskIntoConstraints = false
           let logo = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
           img.setImage(logo, for: .normal)
           return img
       }()
    
     //-------------- PAGE 2 --------------------------//
    
    lazy var titleLblTwo: UILabel = {
           let titleLbl = UILabel()
        titleLbl.textAlignment = .center
       // titleLbl.font = UIFont(name: "Helvetica-Bold", size: 32)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.text = "Explore varoius categories"
        titleLbl.numberOfLines = 0
        titleLbl.textColor = .darkerGray
           return titleLbl
       }()
       lazy var descLblTwo: UILabel = {
        let descriptionLbl = UILabel()
        //descriptionLbl.textAlignment = .center
         descriptionLbl.numberOfLines = 0
          descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        //descriptionLbl.text = "Explore new words and lists by categories and take a quizzes to track progress"
        let attributedString = NSMutableAttributedString(string: "Expand your knowledge by exploring new words and lists by various categories")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        descriptionLbl.attributedText = attributedString
        descriptionLbl.textColor = .lightGray
            return descriptionLbl
       }()
        
    let pageTwoImg: UIImageView = {
           let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.image = UIImage(named: "education9")
           img.contentMode = .scaleAspectFit
           return img
       }()
    
    //-------------- PAGE 3 --------------------------//
      
      lazy var titleLblThree: UILabel = {
             let titleLbl = UILabel()
          titleLbl.textAlignment = .center
         // titleLbl.font = UIFont(name: "Helvetica-Bold", size: 32)
          titleLbl.translatesAutoresizingMaskIntoConstraints = false
          titleLbl.text = "Create own list and test your knowledge"
          titleLbl.numberOfLines = 0
          titleLbl.textColor = .darkerGray
             return titleLbl
         }()
         lazy var descLblThree: UILabel = {
          let descriptionLbl = UILabel()
          //descriptionLbl.textAlignment = .center
           descriptionLbl.numberOfLines = 0
            descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
          //descriptionLbl.text = "Explore new words and lists by categories and take a quizzes to track progress"
          let attributedString = NSMutableAttributedString(string: "Build your own customizable list and take quizzes to track your progress")
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.lineSpacing = 8
          attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
          descriptionLbl.attributedText = attributedString
          descriptionLbl.textColor = .lightGray
              return descriptionLbl
         }()
          
      let pageThreeImg: UIImageView = {
             let img = UIImageView()
             img.translatesAutoresizingMaskIntoConstraints = false
             img.image = UIImage(named: "intro2")
             img.contentMode = .scaleAspectFit
             return img
         }()
    
    
     //-------------- PAGE 3 --------------------------//
    
    lazy var titleLblFour: UILabel = {
               let titleLbl = UILabel()
                     titleLbl.textAlignment = .center
                    // titleLbl.font = UIFont(name: "Helvetica-Bold", size: 32)
                     titleLbl.translatesAutoresizingMaskIntoConstraints = false
                     titleLbl.text = "Set up your time for daily notification"
                     titleLbl.numberOfLines = 0
                     titleLbl.textColor = .darkerGray
                        return titleLbl
       }()
    
       lazy var descLblFour: UILabel = {
            let descriptionLbl = UILabel()
              descriptionLbl.numberOfLines = 0
               descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
             let attributedString = NSMutableAttributedString(string: "Set up your daily notification time")
             let paragraphStyle = NSMutableParagraphStyle()
             paragraphStyle.lineSpacing = 8
             attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
             descriptionLbl.attributedText = attributedString
             descriptionLbl.textColor = .lightGray
                 return descriptionLbl
       }()
    
    let timePicker: UIDatePicker = {
                         let timepickers = UIDatePicker()
                         timepickers.translatesAutoresizingMaskIntoConstraints = false
                      timepickers.datePickerMode = UIDatePicker.Mode.time
                             //startTimeDiveTextField.inputView = timePicker
                          timepickers.addTarget(self, action: #selector(getTime(sender:)), for: .valueChanged)
                         return timepickers
      }()
    
    let notificationImg: UIImageView = {
           let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.image = UIImage(named: "notificationmsg")
           img.isUserInteractionEnabled = true
          img.contentMode = .scaleAspectFit
           return img
       }()
    
    let pageFourImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "intro4-4")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let skipBtn: UIButton = {
       let btn = UIButton.init(type: .system)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.setTitle("Skip", for: .normal)
           btn.isUserInteractionEnabled = true
           btn.layer.backgroundColor = UIColor.clear.cgColor
           btn.setTitleColor(UIColor.lightGray, for: .normal)
           btn.addTarget(self, action: #selector(openPremium), for: .touchUpInside)
        return btn
    }()
    
    let scheduleBtn: UIButton = {
           let btn = UIButton.init(type: .system)
               btn.translatesAutoresizingMaskIntoConstraints = false
               btn.setTitle("Set Time", for: .normal)
               btn.isUserInteractionEnabled = true
               btn.layer.backgroundColor = UIColor.teal.cgColor
               btn.setTitleColor(UIColor.white, for: .normal)
               btn.addTarget(self, action: #selector(setNotification), for: .touchUpInside)
            return btn
        }()
    
     //-------------- PAGE 4 --------------------------//
    lazy var titleLblFive: UILabel = {
           let titleLbl = UILabel()
        titleLbl.textAlignment = .center
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.text = "Premium Offer"
        titleLbl.numberOfLines = 0
        return titleLbl
       }()
    
  
       lazy var descLblFive: UILabel = {
         let descriptionLbl = UILabel()
         descriptionLbl.numberOfLines = 0
         descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.text =  "\u{2705}    No Ads, no interruption\n\n\u{2705}   Access to all word categories  \n\n\u{2705}   Quizzes and progress tracking"
        return descriptionLbl
       }()

   let premiumOfferLbl: UILabel = {
    let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Unlock VOCALE"
        return label
   }()

    //-------------- IMAGEVIEWS --------------------------//
    let customize: UIImageView = {
        let customize = UIImageView()
        customize.translatesAutoresizingMaskIntoConstraints = false
       // customize.image = UIImage(named: "shelf")
        customize.contentMode = .scaleAspectFill
        return customize
    }()
    let delete: UIImageView = {
        let delete = UIImageView()
           delete.translatesAutoresizingMaskIntoConstraints = false
           delete.image = UIImage(named: "delete")
           delete.contentMode = .scaleAspectFit
        return delete
       }()
    let test: UIImageView = {
        let test = UIImageView()
           test.translatesAutoresizingMaskIntoConstraints = false
            test.image = UIImage(named: "test3")
            test.contentMode = .scaleAspectFit
        return test
       }()
    let progress: UIImageView = {
        let progress = UIImageView()
           progress.translatesAutoresizingMaskIntoConstraints = false
           progress.image = UIImage(named: "progress")
           progress.contentMode = .scaleAspectFit
        return progress
       }()

    let smallLogoImg: UIImageView = {
           let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.image = UIImage(named: "logo")
          img.contentMode = .scaleAspectFit
           return img
       }()
    
    let closeImg: UIImageView = {
           let closeImg = UIImageView()
           closeImg.translatesAutoresizingMaskIntoConstraints = false
           closeImg.image = UIImage(named: "close")
           closeImg.isUserInteractionEnabled = true
           closeImg.contentMode = .scaleAspectFit
           closeImg.isUserInteractionEnabled = true
           return closeImg
       }()

     //-------------- BUTTONS --------------------------//
  
    
    let continueBtn: UIButton = {
                         let btn = UIButton.init(type: .system)
                             btn.translatesAutoresizingMaskIntoConstraints = false
                         btn.setTitle("Get Started", for: .normal)
                         btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
                         btn.layer.borderWidth = 2
                         btn.layer.cornerRadius = 10
                         btn.isUserInteractionEnabled = true
                         btn.layer.borderColor = UIColor.white.cgColor
                         btn.layer.backgroundColor = UIColor.link.cgColor
                            btn.setTitleColor(UIColor.white, for: .normal)
                        btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
                        
        
                         return btn
                        }()
    
     //-------------- DATEPICKER AND TOPVIEW(COLLECTION VIEW)--------------------------//
  
    
    lazy var topView: TopView = {
        let tv = TopView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
 
    fileprivate var hour = -1
    fileprivate var minute = -1
    
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds

    fileprivate var pageCount : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        /*UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
        print(familyName, fontNames)
        })*/
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        holderView.backgroundColor = .white//UIColor(patternImage: UIImage(named: "superviewbg3.png")!)
        configure()
    }

    private func configure(){
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        for x in 0..<4{
            let pageView = UIView(frame: CGRect(x: CGFloat(x)*holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)

             let pageControl = UIPageControl(frame: CGRect(x:view.frame.size.width/2 , y: pageView.frame.size.height-100,width:0, height: 0))
     
            pageControl.numberOfPages = 4
            pageControl.currentPage = x
            pageControl.currentPageIndicatorTintColor = .red
            pageControl.pageIndicatorTintColor = .gray
        
           // closeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView)))
    // -------------- CUSTOMIZE TEST AND TRACK PRORESS PAGE ------------//
            if x == 1{

                titleLblTwo.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/33)
                
                descLblTwo.font = UIFont(name: "AvenirNext", size: safeAreaHeight/35)
                descLblTwo.textAlignment = .center
            
             /*  customizeLbl.font = UIFont(name: "Helvetica-Bold", size: screenSize.width * 0.015)
                 deleteLbl.font = UIFont(name: "Helvetica-Bold", size: screenSize.width * 0.015)
                 testLbl.font = UIFont(name: "Helvetica-Bold", size: screenSize.width * 0.015)
                 progressLbl.font = UIFont(name: "Helvetica-Bold", size: screenSize.width * 0.015)*/
           
             /*
                customize.topAnchor.constraint(equalTo:safeArea.topAnchor, constant: safeAreaHeight/10).isActive = true
                //customize.topAnchor.constraint(equalTo:pageView.topAnchor, constant: screenSize.width * 0.08).isActive = true
                 customize.centerXAnchor.constraint(equalTo: pageView.centerXAnchor, constant: -(screenSize.width * 0.07)).isActive = true
                
                customize.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                customize.heightAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                
                pageView.addSubview(delete)
                delete.topAnchor.constraint(equalTo: customize.topAnchor).isActive = true
               delete.centerXAnchor.constraint(equalTo: customize.centerXAnchor, constant: (screenSize.width * 0.15)).isActive = true
              delete.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                delete.heightAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                
                
                 pageView.addSubview(customizeLbl)
                
                customizeLbl.topAnchor.constraint(equalTo:customize.bottomAnchor, constant: (screenSize.width * 0.01)).isActive = true
                customizeLbl.centerXAnchor.constraint(equalTo: pageView.centerXAnchor, constant: -(screenSize.width * 0.07)).isActive = true
                               
               //customizeLbl.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                //customizeLbl.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.25).isActive = true
                
                pageView.addSubview(deleteLbl)
                             
                deleteLbl.topAnchor.constraint(equalTo:delete.bottomAnchor, constant: screenSize.width * 0.01).isActive = true
                 deleteLbl.centerXAnchor.constraint(equalTo: customize.centerXAnchor, constant: screenSize.width * 0.15).isActive = true
                
                pageView.addSubview(test)
                test.topAnchor.constraint(equalTo:customizeLbl.bottomAnchor, constant: screenSize.width * 0.02).isActive = true
                 test.centerXAnchor.constraint(equalTo: pageView.centerXAnchor, constant: -(screenSize.width * 0.07)).isActive = true
                               
                 test.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                 test.heightAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                               
                pageView.addSubview(progress)
                               
                progress.topAnchor.constraint(equalTo:deleteLbl.bottomAnchor, constant: screenSize.width * 0.02).isActive = true
                 progress.centerXAnchor.constraint(equalTo: test.centerXAnchor, constant: (screenSize.width * 0.15)).isActive = true
                  progress.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                 progress.heightAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                
                  pageView.addSubview(testLbl)
                 
                 testLbl.topAnchor.constraint(equalTo:test.bottomAnchor, constant: screenSize.width * 0.01).isActive = true
                 testLbl.centerXAnchor.constraint(equalTo: pageView.centerXAnchor, constant: -(screenSize.width * 0.07)).isActive = true
       
                 pageView.addSubview(progressLbl)
                              
                 progressLbl.topAnchor.constraint(equalTo:progress.bottomAnchor, constant: screenSize.width * 0.01).isActive = true
                  progressLbl.centerXAnchor.constraint(equalTo: test.centerXAnchor, constant: screenSize.width * 0.15).isActive = true*/
        
                pageView.addSubview(pageControl)
                
                pageView.addSubview(descLblTwo)
                               
                //descLblTwo.topAnchor.constraint(equalTo:titleLblTwo.bottomAnchor, constant: safeAreaHeight/30).isActive = true
                descLblTwo.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/30).isActive = true
                descLblTwo.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/30).isActive=true
                descLblTwo.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -safeAreaHeight/10).isActive = true
                
                pageView.addSubview(titleLblTwo)
                titleLblTwo.bottomAnchor.constraint(equalTo: descLblTwo.topAnchor, constant: -safeAreaHeight/30).isActive = true
                titleLblTwo.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/35).isActive = true
                titleLblTwo.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
               // pageView.bringSubviewToFront(titleLblTwo)
                //pageView.bringSubviewToFront(descLblTwo)
                
                //let gif =  UIImage(named: "education9")//UIImage.gifImageWithName("intro1")
                //customize.image = gif
                
                pageView.addSubview(pageTwoImg)
                pageTwoImg.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/35).isActive = true
                pageTwoImg.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
                pageTwoImg.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.45).isActive = true
                pageTwoImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                pageTwoImg.centerYAnchor.constraint(equalTo: pageView.centerYAnchor, constant: -safeAreaHeight/7).isActive = true
        }
                else if x == 2{
                
                titleLblThree.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/33)
                              
                descLblThree.font = UIFont(name: "AvenirNext", size: safeAreaHeight/35)
                descLblThree.textAlignment = .center
                
                pageView.addSubview(pageControl)
                pageView.addSubview(descLblThree)
                
                descLblThree.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/30).isActive = true
                descLblThree.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/30).isActive=true
                descLblThree.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -safeAreaHeight/10).isActive = true
                              
                pageView.addSubview(titleLblThree)
                titleLblThree.bottomAnchor.constraint(equalTo: descLblThree.topAnchor, constant: -safeAreaHeight/30).isActive = true
                titleLblThree.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/35).isActive = true
                titleLblThree.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
                
               pageView.addSubview(pageThreeImg)
               pageThreeImg.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/35).isActive = true
               pageThreeImg.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
               pageThreeImg.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.45).isActive = true
               pageThreeImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
               pageThreeImg.centerYAnchor.constraint(equalTo: pageView.centerYAnchor, constant: -safeAreaHeight/6).isActive = true
            }
       // -------------- TIMEPICKER AND NOTIFICATIONS PAGE ------------//
               else if x == 3{
               //descLblFour.textAlignment = .center
               titleLblFour.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/33)
                scheduleBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/33)
                skipBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/43)

                
                   // let startTimeDiveTextField = UITextField()
               // startTimeDiveTextField.translatesAutoresizingMaskIntoConstraints = false
                    
               

               /* func valueChanged(sender: UIDatePicker, forEvent event: UIEvent){
                    let formatter = DateFormatter()
                       formatter.timeStyle = .short
                        startTimeDiveTextField.text = formatter.string(from: sender.date)
                }*/
                
               

                   // func startTimeDiveChanged(sender: UIDatePicker) {
                    //    let formatter = DateFormatter()
                    //    formatter.timeStyle = .short
                      //  startTimeDiveTextField.text = formatter.string(from: sender.date)
                  //  }
                
                
                /*pageView.addSubview(titleLblFour)
                                                           
                titleLblFour.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: screenSize.width * 0.033).isActive = true
                titleLblFour.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: 10).isActive = true
                titleLblFour.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -10).isActive=true
                              
            
                
                 pageView.addSubview(notificationImg)
             
                notificationImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                notificationImg.topAnchor.constraint(equalTo: titleLblFour.bottomAnchor, constant: (screenSize.width * 0.04)).isActive = true
                 notificationImg.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.8).isActive = true
                  notificationImg.heightAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                    */
                 pageView.addSubview(skipBtn)
                
                  skipBtn.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
                 skipBtn.trailingAnchor.constraint(equalTo: pageView.trailingAnchor, constant: -safeAreaHeight/100).isActive = true
                   skipBtn.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.25).isActive = true
                skipBtn.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.05 ).isActive = true
                
                pageView.addSubview(pageControl)
               pageView.addSubview(scheduleBtn)
                 scheduleBtn.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                scheduleBtn.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -safeAreaHeight/15).isActive = true
                scheduleBtn.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.55).isActive = true
               scheduleBtn.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.08).isActive = true
                scheduleBtn.addSlightShadow()
                scheduleBtn.layer.cornerRadius = safeAreaHeight/25
                
                pageView.addSubview(titleLblFour)
                titleLblFour.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/35).isActive = true
                titleLblFour.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
                titleLblFour.bottomAnchor.constraint(equalTo: titleLblThree.bottomAnchor).isActive = true
                
                  pageView.addSubview(timePicker)
                
                  timePicker.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                timePicker.bottomAnchor.constraint(equalTo: titleLblFour.topAnchor, constant: -safeAreaHeight/65).isActive = true
                timePicker.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.8).isActive = true
                timePicker.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.23).isActive = true
                
                pageView.addSubview(pageFourImg)
                pageFourImg.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: safeAreaHeight/35).isActive = true
                pageFourImg.trailingAnchor.constraint(equalTo: pageView.trailingAnchor,  constant: -safeAreaHeight/35).isActive=true
                pageFourImg.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.3).isActive = true
                pageFourImg.bottomAnchor.constraint(equalTo: timePicker.topAnchor).isActive = true
                pageFourImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                //pageFourImg.centerYAnchor.constraint(equalTo: pageView.centerYAnchor, constant: -safeAreaHeight/6).isActive = true
                
                }
           
            // -------------- INTRODUCTION APP PAGE ------------//
            else{
 
                titleLblOne.font = UIFont(name: "Helvetica", size: safeAreaHeight/27)
                swipeLbl.font = UIFont(name: "AvenirNext", size: safeAreaHeight/50)
                descLblOne.font = UIFont(name: "AvenirNext", size: safeAreaHeight/35)
                logoImg.backgroundColor = .lightBlue
                pageView.addSubview(logoImg)
                               
                logoImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                logoImg.centerYAnchor.constraint(equalTo: pageView.centerYAnchor, constant: -safeAreaHeight/5).isActive = true
                logoImg.widthAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.3).isActive = true
                logoImg.heightAnchor.constraint(equalTo: pageView.widthAnchor, multiplier: 0.3).isActive = true
                
                logoImg.drawCicleByFive()
               // logoImg.animateView()
                pageView.addSubview(titleLblOne)
                titleLblOne.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                titleLblOne.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: safeAreaHeight/50).isActive = true
                
                pageView.addSubview(descLblOne)
                descLblOne.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
                 descLblOne.topAnchor.constraint(equalTo: titleLblOne.bottomAnchor, constant: safeAreaHeight/50).isActive = true
                
                pageView.addSubview(pageControl)
                pageView.addSubview(swipeLbl)
                swipeLbl.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -safeAreaHeight/50).isActive = true
                swipeLbl.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
            }
            logoImg.crossAnimate()
            descLblOne.crossAnimate()
            titleLblOne.crossAnimate()
             swipeLbl.crossAnimate()
            pageTwoImg.isHidden = true
            descLblTwo.isHidden = true
           titleLblTwo.isHidden = true
            pageThreeImg.isHidden = true
            descLblThree.isHidden = true
            titleLblThree.isHidden = true
            titleLblFour.isHidden = true
            pageFourImg.isHidden = true
            timePicker.isHidden = true
            scheduleBtn.isHidden = true
          //  pageControl.topAnchor.constraint(equalTo: continueBtn.bottomAnchor, constant: 30).isActive = true
          //  pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          //  pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
           // pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*4, height: 0)
        scrollView.isPagingEnabled = true
    }
    var pageTwo = 0
           var pageThree = 0
           var pageFour = 0
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
           let width = scrollView.frame.width
           let page = Int(round(scrollView.contentOffset.x/width))
    
        switch page {
        case 1:
            if pageTwo == 0 {
                pageTwoImg.isHidden = false
                descLblTwo.isHidden = false
                titleLblTwo.isHidden = false
                pageTwoImg.crossAnimate()
                descLblTwo.crossAnimate()
                titleLblTwo.crossAnimate()
            }
            pageTwo += 1
        case 2:
             if pageThree == 0 {
                pageThreeImg.isHidden = false
                descLblThree.isHidden = false
                titleLblThree.isHidden = false
                pageThreeImg.crossAnimate()
                descLblThree.crossAnimate()
                titleLblThree.crossAnimate()
            }
            pageThree += 1
        case 3:
             if pageFour == 0 {
            titleLblFour.isHidden = false
            pageFourImg.isHidden = false
                timePicker.isHidden = false
                scheduleBtn.isHidden = false
                timePicker.crossAnimate()
                scheduleBtn.crossAnimate()
                pageFourImg.crossAnimate()
            titleLblFour.crossAnimate()
            let today = Date()
                            getDate(date: today)
                            let center = UNUserNotificationCenter.current()
                                 center.requestAuthorization(options: [.alert,.badge, .sound]){granted, error
                                    in
                                    if granted{
                                     print("good")
                                    }else{
                                     print("no")
                                     }
                             }
            }
            pageFour += 1
                     
        default:
            print("")
        }
    }


       // -------------- TIMEPICKER AND NOTIFICATIONS  Functions ------------//
    
    @objc func getTime(sender: UIDatePicker) {
       self.getDate(date: sender.date)
    }
    
    func getDate(date: Date) {
       // let dateFormatter = DateFormatter()
       // dateFormatter.timeStyle = DateFormatter.Style.short
       // dateFormatter.timeZone = TimeZone.current
        // time = dateFormatter.string(from: date)
       // let date = dateFormatter.date(from: time)!
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        hour = comp.hour ?? 0
        minute = comp.minute ?? 0
    }
    
    @objc func setNotification(){
       
        if(hour > -1 && minute > -1){
          
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        
        content.title = "Notification"
        content.body = "this is body jiodjo ij diojfoid fiodj fo jidoif doifjd oij odfij oijdojf odij fodjfod jjoidjf ojf odijfo dj fodi jfodifj doifjdofjdo fj djof j dofjdofjdojfo fjo i"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "new"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)  
        showAlert()
        Core.shared.setIsNotNewUser()
        }
    }
    
    func showAlert(){
        let editAlert = UIAlertController(title: "Success", message: "Notification Added", preferredStyle: .alert)
          editAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {  _ in
            self.redirectToPremium()
            //self.scrollView.setContentOffset(CGPoint(x: self.holderView.frame.size.width * CGFloat(self.pageCount+1), y:0), animated: true)
          }))
          self.present(editAlert, animated: true, completion: nil)
    }
    

    // -------------- SCROLL PAGE AND ANIMATIONS  Functions ------------//
    
    @objc func closeView(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //print(tapGestureRecognizer.title)
        // Core.shared.setIsNotNewUser()
        dismiss(animated: true, completion: nil)
    }
     @objc func openPremium(_ button: UIButton){
       redirectToPremium()
    }
    func redirectToPremium(){
        Core.shared.setIsNotNewUser()
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
        let premiumView = mainSB.instantiateViewController(identifier: "PremiumView") as! PremiumView
        premiumView.fromIntro = true
        premiumView.modalPresentationStyle = .overFullScreen
        premiumView.modalTransitionStyle = .crossDissolve
        self.present(premiumView, animated: true, completion: nil)
    }
   @objc func didTapButton(_ button: UIButton){
        guard button.tag < 4 else {
             // Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
    pageCount += 1
    if pageCount == 2{
     let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert,.badge, .sound]){granted, error
                    in
                    if granted{
                        print("good")
                    }else{
                        print("no")
                    }
        }
    }
  /*  if pageCount == 1{
        let screenSize = CGSize(width: holderView.frame.width * screenScale, height: holderView.frame.height * screenScale)
       
        UIView.animate(withDuration: 1, animations: {
            self.customize.frame.origin.x += screenSize.width*0.075
                                    }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
                                           self.delete.frame.origin.x += screenSize.width*0.17
                                       }, completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.test.frame.origin.x += screenSize.width*0.06       },
                       completion: nil)
        UIView.animate(withDuration: 1, animations: {
        self.progress.frame.origin.x += screenSize.width*0.2   },
                       completion: nil)
    
    }*/
    //pageControl.currentPage + 1
    scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y:0), animated: true)
    }
   

}
class TopView : UIView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(PriceCell.self, forCellWithReuseIdentifier:"PriceCell" )
        return cv
    }()
    
    let duration = ["MONTHLY", "ANNUAL", "LIFETIME"]
    let price = ["$3.99", "$12.99", "$29.99"]
    let priceDesc = ["PER MONTH", "PER YEAR", "ONE PAYMENT"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)

        //Add constraint
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return duration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let desc = priceDesc[indexPath.row]
        let amount = price[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               return 10
           }
          /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            
               return 100
           }*/
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCell", for: indexPath) as! PriceCell
        
        let dur = duration[indexPath.item]
        let pri = price[indexPath.item]
        let desc = priceDesc[indexPath.item]
        //var width = collectionView.frame.width/3
        //cell.frame = CGRect(x: width, y: 0 ,width: (collectionView.frame.width)/3, height: collectionView.frame.height/3)
       // cell.setPriceCell(durationTime: dur, priceTag: pri, pricingDesc: desc)
        cell.backgroundColor = .link
        cell.layer.borderColor = UIColor.yellow.cgColor
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        return CGSize(width: ((collectionView.frame.width-20)/3), height: collectionView.frame.height)
    }
}
