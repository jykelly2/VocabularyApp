//
//  PremiumView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-30.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class PremiumView: UIViewController, UIViewControllerTransitioningDelegate{
    
    let isPhone = UIDevice.isPhone
    var fromIntro = false
      let cancelLbl: UILabel = {
             let titleLbl = UILabel()
          titleLbl.textAlignment = .center
          titleLbl.translatesAutoresizingMaskIntoConstraints = false
          titleLbl.text = "Cancel anytime in the app store"
          titleLbl.numberOfLines = 0
        titleLbl.textColor = .lightGray
          return titleLbl
         }()
      
    
         let descLbl: UILabel = {
           let descriptionLbl = UILabel()
           descriptionLbl.numberOfLines = 0
           descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
          //  descriptionLbl.textAlignment = .center
            //descriptionLbl.text = "Unlock all the categories to get access to all the words"
         // descriptionLbl.text =  "\u{2705}    No Ads, no interruption\n\n\u{2705}   Access to all word categories  \n\n\u{2705}   Quizzes and progress tracking"
            descriptionLbl.textColor = .lightGray
          return descriptionLbl
         }()

     let premiumOfferLbl: UILabel = {
      let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
          label.numberOfLines = 0
          label.text = "VOCALE Premium"
        label.textColor = .lightGray
          return label
     }()
    
    
    let logoImg: UIImageView = {
           let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.image = UIImage(named: "logo")
          img.contentMode = .scaleAspectFit
           return img
       }()
    
     lazy var closeImg: UIButton = {
                       let btn = UIButton.init(type: .system)
                      btn.translatesAutoresizingMaskIntoConstraints = false
                      let img = UIImage(named: "closeicon")
                       btn.clipsToBounds = true
                    btn.tintColor = .lightGray
                      btn.layer.backgroundColor = UIColor.lightGrey.cgColor
                      btn.setImage(img, for: .normal)
                       btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
                       return btn
        }()
    
    let subscribeBtn: UIButton = {
        let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Subscribe", for: .normal)
            btn.isUserInteractionEnabled = true
            btn.layer.backgroundColor = UIColor.teal.cgColor
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.addTarget(self, action: #selector(premiumTapped), for: .touchUpInside)
        return btn
    }()
    
    let priceView: PremiumCollection = {
          let tv = PremiumCollection()
          tv.translatesAutoresizingMaskIntoConstraints = false
          return tv
      }()
    
    
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(false)
           animateIn()
       }
       
      /* @objc func animateOut(){
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
               self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
               self.view.alpha = 0
           }
           ){(complete) in
               if complete {
                   self.view.removeFromSuperview()
               }
               
           }
       }*/
       @objc func animateIn(){
           self.view.transform = CGAffineTransform(scaleX: 0, y: 0)
           self.view.alpha = 0
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  1, initialSpringVelocity: 0.1 , options: .curveEaseInOut,animations: {
                  self.view.transform = .identity
               
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
               self.view.alpha = 1
              })
          }

    /*override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                    hideNavigationBar(animated: animated)
         }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white//UIColor(patternImage: UIImage(named: "superviewbg3.png")!)
        
         // setUp()
        view.addSubview(cancelLbl)
       view.addSubview(closeImg)
        view.addSubview(premiumOfferLbl)
       // view.addSubview(logoImg)
        view.addSubview(priceView)
        view.addSubview(descLbl)
       view.addSubview(subscribeBtn)
        
       /* let closeTapGestureRecognizer = MyTapGesture(target: self, action: #selector(closeView(tapGestureRecognizer:)))
               closeImg.isUserInteractionEnabled = true
               closeImg.addGestureRecognizer(closeTapGestureRecognizer)
               closeTapGestureRecognizer.title = "Close"*/
        

    }
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
 
        let descriptions = [" No Ads, no interruption\n\n", " Access to all the words\n\n", " Access to all the category lists\n\n"," Take quizzes with any category"]
       let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"correct")
        let imageOffsetY: CGFloat = -safeAreaHeight/95
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: safeAreaHeight/25, height: safeAreaHeight/25)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        var textAfterIcon = NSAttributedString(string: "")
        for desc in descriptions{
              completeText.append(attachmentString)
              textAfterIcon = NSAttributedString(string: desc)
              completeText.append(textAfterIcon)
         }
        descLbl.textAlignment = .left
        descLbl.attributedText = completeText
        
        if isPhone{
        
        premiumOfferLbl.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/33)
        descLbl.font = UIFont(name: "Helvetica", size: safeAreaWidth/20)
            cancelLbl.font = UIFont(name: "Helvetica", size: safeAreaHeight/50)
        //descLbl.textAlignment = .left
        subscribeBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
              
        closeImg.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: safeAreaWidth/30).isActive = true
        closeImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaHeight/25).isActive = true
          closeImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1).isActive = true
        closeImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1).isActive = true
    
       
       //premiumOfferLbl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/10).isActive = true
        premiumOfferLbl.bottomAnchor.constraint(equalTo: descLbl.topAnchor, constant: -safeAreaHeight/20).isActive = true
        premiumOfferLbl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaHeight/25).isActive = true
        // descLbl.topAnchor.constraint(equalTo: premiumOfferLbl.bottomAnchor, constant: safeAreaHeight/23).isActive = true
        descLbl.bottomAnchor.constraint(equalTo: priceView.topAnchor, constant: -safeAreaHeight/17).isActive = true
        descLbl.leadingAnchor.constraint(equalTo: premiumOfferLbl.leadingAnchor).isActive = true
        descLbl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
      // premiumOfferLbl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
  
      /*  logoImg.topAnchor.constraint(equalTo: descLbl.bottomAnchor, constant: safeAreaHeight/40).isActive = true
       //  logoImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
         logoImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive = true
          logoImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive = true*/

            priceView.bottomAnchor.constraint(equalTo: subscribeBtn.topAnchor, constant: -safeAreaHeight/15).isActive = true
          priceView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9).isActive = true
           priceView.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.4).isActive = true
 
           
           // descLbl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
         //subscribeBtn.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -safeAreaHeight/8).isActive = true
        subscribeBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/7).isActive = true
           // subscribeBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
             subscribeBtn.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.08).isActive = true
             subscribeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.75).isActive = true
            subscribeBtn.layer.cornerRadius = safeAreaHeight/30
            
             cancelLbl.topAnchor.constraint(equalTo: subscribeBtn.bottomAnchor, constant: safeAreaHeight/90).isActive = true
            
            
        }else{
            premiumOfferLbl.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/40)
            descLbl.font = UIFont(name: "Helvetica", size: safeAreaHeight/50)
            descLbl.textAlignment = .left
            subscribeBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/50)
                         
            closeImg.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            closeImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
            closeImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.07).isActive = true
            closeImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.07).isActive = true
            
            premiumOfferLbl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/10).isActive = true

            logoImg.topAnchor.constraint(equalTo: premiumOfferLbl.bottomAnchor, constant: safeAreaHeight/40).isActive = true
            logoImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.11).isActive = true
            logoImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.11).isActive = true

            priceView.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: safeAreaHeight/60).isActive = true
            priceView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.78).isActive = true
            priceView.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.3).isActive = true
              priceView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            
            descLbl.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: safeAreaHeight/50).isActive = true
  
            subscribeBtn.bottomAnchor.constraint(equalTo: descLbl.bottomAnchor, constant: safeAreaHeight/8).isActive = true
           
            subscribeBtn.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.08).isActive = true
            subscribeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.63).isActive = true
        }
        subscribeBtn.addShadow()
        closeImg.drawCicleByFive()
      //  premiumOfferLbl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
       // logoImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        priceView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        //descLbl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        subscribeBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
         cancelLbl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
    }
    
    @objc func closeView(tapGestureRecognizer:UITapGestureRecognizer){
        if fromIntro {
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }else{
           dismiss(animated: true, completion: nil)
        }
    }
    @objc func premiumTapped(_ button: UIButton){
        print("tapped")
    }
}
class PremiumCollection : UIView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    let isPhone = UIDevice.isPhone
    
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
    
    let duration = ["Monthly", "Yearly", "Lifetime"]
    let price = ["$3.99", "$12.99", "$29.99"]
    let priceDesc = ["/month", "$1.08/month", "One Payment"]
    
    var selectedIndexPath = 1
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        self.addSubview(collectionView)

        //Add constraint
       
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
     
        //collectionView.addShadow()
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
     
        selectedIndexPath = indexPath.row
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if isPhone{
              return 10
        }else{
            return 30
        }
            
     }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCell", for: indexPath) as! PriceCell
        
        let dur = duration[indexPath.item]
        let pri = price[indexPath.item]
        let desc = priceDesc[indexPath.item]
        
        cell.setPriceCell(durationTime: dur, priceTag: pri, pricingDesc: desc, selectedIndex: selectedIndexPath, index: indexPath.item)
        
        if isPhone{
            cell.layer.borderWidth = 2
        }else{
            cell.layer.borderWidth = 5
        }
        
        if indexPath.row == selectedIndexPath{
            cell.layer.borderColor = UIColor.teal.cgColor
           // cell.isUserInteractionEnabled = false
        }else{
            cell.layer.borderColor = UIColor.white.cgColor
        }
        cell.backgroundColor = UIColor.teal.withAlphaComponent(0.4)
    
        cell.addCorner()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if isPhone{
            print("row")
            print(indexPath.row)
            print("path")
            print(selectedIndexPath)
            if indexPath.row == selectedIndexPath{
                size = CGSize(width: ((collectionView.frame.width-20)/3), height: collectionView.frame.height)
            }else{
                size = CGSize(width: ((collectionView.frame.width-20)/3), height: collectionView.frame.height/1.3)
            }
        }else{
            size = CGSize(width: ((collectionView.frame.width-20)/3.2), height: collectionView.frame.height/1.3)
        }
        return size
    }
    var count = 0
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if count < 3{
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,0, 50, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0
            UIView.animate(withDuration: 0.5){
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
            count += 1
        }
    }
}

