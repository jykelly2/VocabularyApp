//
//  QuizView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-20.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class QuizView: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
     let isPhone = UIDevice.isPhone
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
    
    var list = "Mix"
    var listOptions = ["Mix", "Favourite", "Added", "Learned"]
    var category = "Mix"
    var cateogryOptions = ["Mix","Expression","Emotion","Buisiness","Education", "Health"]
    let categories = ["Mix","Expression","Emotion","Buisiness","Education", "Health"]
    let images = ["emptylist","expression", "emotion","business3","education5", "health11"]
    let descriptions = ["15 Words", "Intermediate", "Advanced", "15 Words", "Intermediate", "Advanced"]
    var quizType = ""
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.register(QuizListCell.self, forCellWithReuseIdentifier:"QuizListCell")
        return cv
    }()
    
    lazy var quizLbl: UILabel = {
     let Lbl = UILabel()
     Lbl.textAlignment = .center
     Lbl.translatesAutoresizingMaskIntoConstraints = false
     Lbl.text = "Take the Quiz"
     Lbl.numberOfLines = 0
     return Lbl
    }()
    
    
    lazy var categoryLbl: UILabel = {
             let Lbl = UILabel()
          Lbl.textAlignment = .center
          Lbl.translatesAutoresizingMaskIntoConstraints = false
          Lbl.text = "Choose your category"
          Lbl.numberOfLines = 2 //your category \nto quiz"
         Lbl.lineBreakMode = .byWordWrapping
          return Lbl
    }()
    
    lazy var listLbl: UILabel = {
          let titleLbl = UILabel()
          titleLbl.textAlignment = .center
          titleLbl.translatesAutoresizingMaskIntoConstraints = false
          titleLbl.text = "List"
          titleLbl.numberOfLines = 0
          return titleLbl
         }()
    
    let categoryPicker: UIPickerView = {
         let pv = UIPickerView()
         pv.translatesAutoresizingMaskIntoConstraints = false
         pv.layer.borderColor = UIColor.white.cgColor
         pv.backgroundColor = .link
         pv.layer.cornerRadius = 20
         return pv
     }()
    
    let listPicker: UIPickerView = {
         let pv = UIPickerView()
         pv.translatesAutoresizingMaskIntoConstraints = false
         pv.layer.borderColor = UIColor.white.cgColor
         pv.backgroundColor = .link
         pv.layer.cornerRadius = 20
         return pv
     }()

    let definitionBtn: UIButton = {
        let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Definition", for: .normal)
           // btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 10
            btn.isUserInteractionEnabled = true
            btn.layer.borderColor = UIColor.white.cgColor
            btn.layer.backgroundColor = UIColor.green.cgColor
            btn.setTitleColor(UIColor.white, for: .normal)
             btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            return btn
    }()
    let sentenceBtn: UIButton = {
          let btn = UIButton.init(type: .system)
              btn.translatesAutoresizingMaskIntoConstraints = false
              btn.setTitle("Sentence", for: .normal)
             // btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
              btn.layer.borderWidth = 2
              btn.layer.cornerRadius = 10
              btn.isUserInteractionEnabled = true
              btn.layer.borderColor = UIColor.white.cgColor
              btn.layer.backgroundColor = UIColor.link.cgColor
              btn.setTitleColor(UIColor.white, for: .normal)
               btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
              return btn
      }()
    let topView : UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .white
         view.isUserInteractionEnabled = true
         return view
     }()
    
    let underlineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGrey
        return view
    }()
    
    let titleLbL: UILabel = {
         let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .left
        label.minimumScaleFactor = 0.1
         label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.text = "Quizzes"
         label.textColor = .darkerGray
          return label
    }()
      
    let titleDescLbL: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .left
          label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
         label.text = "Test your knowledge"
          label.textColor = .lightGray
           return label
    }()
    
  /*  let quizImg: UIImageView = {
        let closeImg = UIImageView()
        closeImg.translatesAutoresizingMaskIntoConstraints = false
            let img = UIImage(named: "addWordIcon")
         closeImg.image = img
        closeImg.isUserInteractionEnabled = true
         closeImg.contentMode = .scaleAspectFit
        return closeImg
    }()*/
    
    lazy var quizImg: UIButton = {
            let btn = UIButton.init(type: .system)
           btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "quizimg")?.withRenderingMode(.alwaysOriginal)
          // img?.withTintColor(.)
            btn.clipsToBounds = true
           btn.layer.backgroundColor = UIColor.white.cgColor
        btn.setImage(img, for: .normal)
            return btn
    }()
    
    lazy var logoImg: UIButton = {
                      let btn = UIButton.init(type: .system)
                     btn.translatesAutoresizingMaskIntoConstraints = false
                  let img = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
                    // img?.withTintColor(.)
                      btn.clipsToBounds = true
                     btn.layer.backgroundColor = UIColor.white.cgColor
                  btn.setImage(img, for: .normal)
                      return btn
        }()
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         hideNavigationBar(animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.addSubview(titleLbL)
       // topView.addSubview(titleDescLbL)
        topView.addSubview(quizImg)
       // topView.addSubview(underlineView)
        topView.addSubview(logoImg)
       // view.addSubview(categoryLbl)
       // view.addSubview(listLbl)
       // view.addSubview(categoryPicker)
       // view.addSubview(listPicker)
      //  view.addSubview(quizLbl)
       // view.addSubview(definitionBtn)
        //view.addSubview(sentenceBtn)
        view.addSubview(collectionView)
      //  view.bringSubviewToFront(topView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
   
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)

          // --------------------- PICKER LABLES ------------------------------
        
        if isPhone{
        categoryLbl.font = UIFont(name: "Helvetica", size: safeAreaHeight/35)
      //  listLbl.font = UIFont(name: "Helvetica-Bold", size: screenSize.width * 0.015)
         titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/25)
       // titleDescLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        
        titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/30).isActive = true
       // titleLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeAreaHeight/40)).isActive = true
            titleLbL.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
            
       // titleDescLbL.topAnchor.constraint(equalTo: titleLbL.bottomAnchor).isActive = true
       // titleDescLbL.leadingAnchor.constraint(equalTo: titleLbL.leadingAnchor).isActive = true
           // titleDescLbL.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
            quizImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
           quizImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
                      // listImg.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/50).isActive = true
           quizImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaHeight/30).isActive = true
           // quizImg.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
               quizImg.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            logoImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
            logoImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
            logoImg.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaHeight/30).isActive = true
            logoImg.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        /*quizImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.14).isActive=true
         quizImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.14).isActive=true
         quizImg.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/50).isActive = true
         quizImg.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true*/
        // quizImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -safeAreaHeight/30).isActive = true
        // quizImg.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       
        topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
        topView.bottomAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/55).isActive = true
            
    //  underlineView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive=true
     // underlineView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
   // underlineView.heightAnchor.constraint(equalToConstant: safeAreaHeight/150).isActive=true
            
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeAreaHeight/60).isActive = true
        //collectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.5).isActive=true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/60).isActive = true
         collectionView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.93).isActive=true
 
        }else{
            
        }
        topView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
      //  underlineView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
       // underlineView.addBottomShadow()
       // topView.addSlightShadow()
        quizImg.drawCicleByFive()
        logoImg.drawCicleByFive()
        quizImg.strongBottomShadow()
        logoImg.strongBottomShadow()
        
    }
    
     @objc func didTapButton(_ button: UIButton){
        quizType = button.title(for: .normal)!
      let date = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let dateDay = Calendar.current.date(from: components)!
        let quiz = Quiz(type: quizType, category: category, list: list, score: 0, date: dateDay)
        
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
                     let testView = mainSB.instantiateViewController(identifier: "TestingView") as! TestingView   
        testView.takenQuiz = quiz
        self.navigationController?.pushViewController(testView, animated: true)
    }
    
    
   
    
    //--------------CollectionView FUNCTIONS-----------------//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cateogryOptions.count
      }
          
          //column margin - height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               return safeArea.layoutFrame.width/20
    }
          
          //row margin - width
          /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
              if isPhone {
                   // return safeArea.layoutFrame.width/30
              }else{
                    return safeArea.layoutFrame.width/8
              }
          }*/
    
          
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizListCell", for: indexPath) as! QuizListCell
            let category = categories[indexPath.row]
        let image = UIImage(named:images[indexPath.row])
        
            let description = descriptions[indexPath.row]
       
        cell.setQuizList(title: category, description: description, image:image!)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = safeAreaHeight/80
        cell.addShadow()
        return cell
     }
          
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                    var size = CGSize()
        if isPhone{
            size = CGSize(width: collectionView.frame.width/2.2, height: collectionView.frame.height/3.4)
        }else{
            size = CGSize(width: safeArea.layoutFrame.width, height: safeArea.layoutFrame.width)
        }
        return size
    }
          
          func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let date = Date()
              let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
              let dateDay = Calendar.current.date(from: components)!
              let category = categories[indexPath.row]
              let mainSB = UIStoryboard(name:"Main", bundle:nil)
              let testingView = mainSB.instantiateViewController(identifier: "TestingView") as! TestingView
              let takenQuiz = Quiz(type: "Mix", category: category, list: "default", score: 0, date: dateDay)
              testingView.takenQuiz = takenQuiz
              self.navigationController?.pushViewController(testingView, animated: true)
        }
       
       func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
             let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,-10, 0, 0)
                   cell.layer.transform = rotationTransform
                   cell.alpha = 0
                   UIView.animate(withDuration: 0.7){
                       cell.layer.transform = CATransform3DIdentity
                       cell.alpha = 1.0
                   }
       }

}
