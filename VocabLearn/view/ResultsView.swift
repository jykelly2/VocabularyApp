//
//  ResultsView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-22.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class ResultsView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    let isPhone = UIDevice.isPhone
    
    var quizResult: [Result]!
    var score : Int = 0
    var category : String = ""
    var listName: String = ""
    var type: String = ""
    
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
      lazy var closeImg: UIButton = {
           let btn = UIButton.init(type: .system)
          btn.translatesAutoresizingMaskIntoConstraints = false
          let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
          img?.withTintColor(.darkGray)
           btn.clipsToBounds = true
          btn.layer.backgroundColor = UIColor.lightGrey.cgColor
          btn.setImage(img, for: .normal)
           btn.addTarget(self, action: #selector(close), for: .touchUpInside)
           return btn
      }()
    
    let titleLbl: UILabel = {
        let Lbl = UILabel()
        Lbl.translatesAutoresizingMaskIntoConstraints = false
       Lbl.textAlignment = .center
        Lbl.minimumScaleFactor = 0.1
        Lbl.adjustsFontSizeToFitWidth = true
        Lbl.textColor = .lightGray
        return Lbl
    }()
    
    /* lazy var scoreText: UIButton = {
             let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
             btn.clipsToBounds = true
            btn.layer.backgroundColor = UIColor.white.cgColor
        btn.setTitleColor(.lightGreen, for: .normal)
             return btn
        }()*/
    let scoreLbl: UILabel = {
           let Lbl = UILabel()
           Lbl.translatesAutoresizingMaskIntoConstraints = false
         //  Lbl.numberOfLines = 0
           Lbl.textAlignment = .center
      //  Lbl.adjustsFontSizeToFitWidth = true
        Lbl.text = "Score"
       // Lbl.adjustsFontForContentSizeCategory = true
           Lbl.textColor = .lightGray
           return Lbl
       }()
    let scoreText: UILabel = {
              let Lbl = UILabel()
              Lbl.translatesAutoresizingMaskIntoConstraints = false
              Lbl.textAlignment = .center
              Lbl.textColor = .lightGray
              return Lbl
          }()
    let percentageLbl: UILabel = {
            let Lbl = UILabel()
            Lbl.translatesAutoresizingMaskIntoConstraints = false
            Lbl.textAlignment = .center
         Lbl.text = "Percent"
            Lbl.textColor = .lightGray
            return Lbl
        }()
     let percentageText: UILabel = {
               let Lbl = UILabel()
               Lbl.translatesAutoresizingMaskIntoConstraints = false
               Lbl.textAlignment = .center
        Lbl.textColor = .lightGray
               return Lbl
        }()
   /* lazy var resultImg: UIButton = {
              let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
            // img?.withTintColor(.)
              btn.clipsToBounds = true
             btn.layer.backgroundColor = UIColor.white.cgColor
          
              return btn
      }()*/
    let resultImg: UIImageView = {
             let gif = UIImageView()
             gif.translatesAutoresizingMaskIntoConstraints = false
        gif.contentMode = .scaleToFill
   
             return gif
    }()
    
  /*  let tableView: UITableView = {
           let tv = UITableView(frame: .zero, style: .plain)
           tv.translatesAutoresizingMaskIntoConstraints = false
           //tv.backgroundColor = .clear
        tv.register(ResultCell.self, forCellReuseIdentifier: "ResultCell")
           return tv
       }()*/
    
    lazy var collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
          cv.translatesAutoresizingMaskIntoConstraints = false
          cv.delegate = self
          cv.dataSource = self
         // cv.backgroundColor = .lightGrey
          cv.register(ResultCell.self, forCellWithReuseIdentifier:"ResultCell" )
          return cv
      }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
        let preparingView = PreparingView()
        view.addSubview(preparingView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            preparingView.removeFromSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white//UIColor(patternImage: UIImage(named: "superviewbg3")!)

       /* if listName == "" {
            titleLbl.text = category
        }else{
            titleLbl.text = listName
        }*/
        scoreText.text = String(score) 
        let percent = Double(score)/Double(quizResult.count) * 100
        let formattedPercent = String(format: "%.0f", percent)
        percentageText.text = formattedPercent + "%"
        
        let intPercent = Int(formattedPercent)!
        var img = UIImage()
        
        if intPercent <= 65 {
            //img = UIImage(named: "beginner")!.withRenderingMode(.alwaysOriginal)
            img = UIImage.gifImageWithName("beginner1")!.withRenderingMode(.alwaysOriginal)
            titleLbl.text = "Beginner"
        }
        else if intPercent > 65 && intPercent <= 80{
            //img = UIImage(named: "intermediate")!.withRenderingMode(.alwaysOriginal)
            img = UIImage.gifImageWithName("intermediate3")!.withRenderingMode(.alwaysOriginal)
            titleLbl.text = "Intermediate"
        }
        else{
            //img = UIImage(named: "expert")!.withRenderingMode(.alwaysOriginal)
            img = UIImage.gifImageWithName("expert4")!.withRenderingMode(.alwaysOriginal)
            titleLbl.text = "Expert"
        }
        resultImg.image = img
        //resultImg.setImage(img, for: .normal)
        //resultImg.imageView?.contentMode = .scaleToFill
        
        view.addSubview(topView)
        topView.addSubview(titleLbl)
        topView.addSubview(scoreText)
       topView.addSubview(scoreLbl)
        topView.addSubview(percentageText)
        topView.addSubview(percentageLbl)
        topView.addSubview(closeImg)
        topView.addSubview(resultImg)
       
       // view.addSubview(tableView)
        topView.bringSubviewToFront(titleLbl)
        view.addSubview(collectionView)
        
    }
    
    @objc func close(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()

        if isPhone{
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.2).isActive = true
        
  // --------------------- TOPVIEW LABLES ------------------------------
        titleLbl.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
        scoreText.font = UIFont(name: "Helvetica", size: safeAreaHeight/35)
       // scoreText.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
        scoreLbl.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        
        percentageText.font = UIFont(name: "Helvetica", size: safeAreaHeight/35)
              // scoreText.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
        percentageLbl.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        
        closeImg.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaWidth/60).isActive = true
        closeImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
        closeImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
        closeImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaWidth/50).isActive = true
            
        titleLbl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -safeAreaHeight/80).isActive = true
            
       /* resultImg.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/60).isActive = true
        resultImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.1).isActive=true
        resultImg.widthAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.1).isActive=true*/
        
        resultImg.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/60).isActive = true
        resultImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.1).isActive=true
        resultImg.widthAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.1).isActive=true
      

        scoreLbl.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: safeAreaHeight/40).isActive = true
        scoreLbl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -safeAreaHeight/80).isActive = true
            
        scoreText.bottomAnchor.constraint(equalTo: scoreLbl.bottomAnchor, constant: -safeAreaHeight/40).isActive = true
        scoreText.centerXAnchor.constraint(equalTo: scoreLbl.centerXAnchor).isActive = true
        
        percentageLbl.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -safeAreaHeight/40).isActive = true
        percentageLbl.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -safeAreaHeight/80).isActive = true
                   
        percentageText.bottomAnchor.constraint(equalTo: percentageLbl.bottomAnchor, constant: -safeAreaHeight/40).isActive = true
        percentageText.centerXAnchor.constraint(equalTo: percentageLbl.centerXAnchor).isActive = true
        
// --------------------- TABLEVIEW  ------------------------------
       // tableView.rowHeight = 150
      /*  tableView.backgroundColor = .clear
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.95).isActive=true
        tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.95).isActive=true
         tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true*/
        // tableView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeAreaHeight/50).isActive = true
        //collectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.95).isActive=true
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: safeAreaHeight/50).isActive = true
        collectionView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
         
        }else{
            
        }
        topView.addShadow()
        closeImg.drawCicleByFive()
       // resultImg.drawCicleByFive()
        //scoreText.layer.cornerRadius = 0.5 * scoreText.bounds.size.width
        collectionView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        // scoreLbl.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
         //scoreText.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
         titleLbl.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
         resultImg.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
    }
       
    
    
    
    // --------------------- TableView Functions ------------------------------//
         /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return quizResult.count
           
          }

           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
              
            let result = quizResult[indexPath.row]
           cell.setResult(result: result, number: indexPath.row+1)
            cell.backgroundColor = .clear
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.white.cgColor
            cell.frame.size = CGSize(width: tableView.frame.width, height: tableView.frame.height)
           // cell.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
              return cell
            }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
          return 1
      }

      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizResult.count
      }
   
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                 return safeAreaHeight/40
             }
            /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
              
                 return 100
             }*/
        
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as! ResultCell
          let result = quizResult[indexPath.row]
          cell.setResult(result: result, number: indexPath.row+1)
        
       // cell.layer.cornerRadius = safeAreaHeight/40
        cell.addSlightShadow()
        //cell.backgroundColor = .veryLightGray
                   //cell.layer.borderWidth = 2
                   //cell.layer.borderColor = UIColor.link.cgColor
  
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width * 0.95), height: (collectionView.frame.height/5))
      }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,0, -10, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0
                UIView.animate(withDuration: 0.7){
                    cell.layer.transform = CATransform3DIdentity
                    cell.alpha = 1.0
                }
        }
        
    }


}

