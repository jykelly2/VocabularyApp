//
//  LoadingView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-08-02.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class LoadingView: UIView{
    
    let isPhone = UIDevice.isPhone
   
    let container: UIView = {
           let v = UIView()
           v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .veryLightGray
           return v
    }()
    
    let loadingView : UIView = {
           let view = UIView()
               view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .white
              return view
       }()
       
       let loadingLbL: UILabel = {
           let lbl=UILabel()
           lbl.translatesAutoresizingMaskIntoConstraints=false
           lbl.textAlignment = .center
           lbl.text = "Preparing Quiz..."
           lbl.textColor = .lightGray
           lbl.minimumScaleFactor = 0.1
           lbl.adjustsFontSizeToFitWidth = true
           lbl.numberOfLines = 1
           return lbl
       }()
       
       let loadingImg: UIImageView = {
                let gif = UIImageView()
                gif.translatesAutoresizingMaskIntoConstraints = false
        gif.contentMode = .scaleToFill
                return gif
       }()
    
    @objc func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
             self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }
        ){(complete) in
            if complete {
                self.removeFromSuperview()
            }
            
        }
    }
    @objc func animateIn(){
        //come from the top
         self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        self.backgroundColor = .white///UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        
        let gif = UIImage.gifImageWithName("loading4")
        
        loadingImg.image = gif
      //  self.addSubview(container)
        
       // container.addSubview(loadingLbL)
       //container.addSubview(loadingImg)
        
        self.addSubview(loadingLbL)
        self.addSubview(loadingImg)
        self.bringSubviewToFront(loadingLbL)
        let safeAreaHeight = self.frame.height
        
        if isPhone{
      
           /* container.topAnchor.constraint(equalTo: self.topAnchor, constant: safeAreaHeight/10).isActive = true
           // container.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.8).isActive = true
             container.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
             container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeAreaHeight/10).isActive = true*/
            
        
            
           /* loadingImg.bottomAnchor.constraint(equalTo: loadingLbL.topAnchor, constant: -safeAreaHeight/30).isActive = true
           // loadingImg.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeAreaHeight/30).isActive = true
            loadingImg.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
            loadingImg.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
            */ //, constant: -safeAreaHeight/30
           // loadingImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -safeAreaHeight/5).isActive = true
            //loadingImg.topAnchor.constraint(equalTo: self.topAnchor, constant:  safeAreaHeight/5).isActive = true
              loadingImg.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
           loadingImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  safeAreaHeight/70).isActive = true
           loadingImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -safeAreaHeight/70).isActive = true
             loadingImg.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -safeAreaHeight/20).isActive = true
            
            loadingLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
            loadingLbL.bottomAnchor.constraint(equalTo: loadingImg.bottomAnchor, constant: -safeAreaHeight/50).isActive = true
          //  loadingImg.layer.cornerRadius = safeAreaHeight/40
            //container.layer.cornerRadius = safeAreaHeight/40
        

        }
        else{
 
        }
        loadingImg.layer.masksToBounds = false
        loadingImg.layer.cornerRadius = loadingImg.frame.height/2
        loadingImg.clipsToBounds = true
         loadingImg.addShadow()
        loadingLbL.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadingImg.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
       // container.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
          
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

