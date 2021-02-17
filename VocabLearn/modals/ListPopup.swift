//
//  ListPopup.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-03.
//  Copyright © 2020 Jun K. All rights reserved.
//


import UIKit

class ListPopup: UIViewController {
    
    let listcontainer = ListView()
    let dbListController = DbListController()
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
    var currentList: ListEntity?
    let isPhone = UIDevice.isPhone
    var wordTitle : String!
    
   /* let container: UIcontainer = {
           let v = UIcontainer()
           v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
           return v
       }()*/
    
    let alert: UIView = {
              let v = UIView()
              v.translatesAutoresizingMaskIntoConstraints = false
           v.backgroundColor = .veryLightGray
              return v
          }()
    
    let alertTitle: UILabel = {
               let label = UILabel()
               label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 1
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.1
                label.textColor = .lightGray
               return label
    }()
    
    let alertText: UILabel = {
             let label = UILabel()
             label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.1
            label.textAlignment = .center
            label.textColor = .lightGray
             return label
    }()
 

    lazy var closeImg: UIButton = {
                   let btn = UIButton.init(type: .system)
                  btn.translatesAutoresizingMaskIntoConstraints = false
                  let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
                   btn.clipsToBounds = true
        btn.tintColor = .lightGray
                  btn.layer.backgroundColor = UIColor.lightGrey.cgColor
                  btn.setImage(img, for: .normal)
                   btn.addTarget(self, action: #selector(close), for: .touchUpInside)
                   return btn
    }()
    
   let resultImg: UIImageView = {
        let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
          img.contentMode = .scaleAspectFit
        return img
       }()
    
     lazy var addWordImg: UIButton = {
                 let btn = UIButton.init(type: .system)
                btn.translatesAutoresizingMaskIntoConstraints = false
             let img = UIImage(named: "addWordIcon")?.withRenderingMode(.alwaysOriginal)
               // img?.withTintColor(.)
                 btn.clipsToBounds = true
                btn.layer.backgroundColor = UIColor.white.cgColor
             btn.setImage(img, for: .normal)
                 return btn
    }()
    
    let wordLable: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Title"
           label.textAlignment = .center
        label.textColor = .lightGray
           return label
       }()
       
       let wordText: UITextField = {
           let text = UITextField()
           text.translatesAutoresizingMaskIntoConstraints = false
           text.placeholder = "Enter title"
           let placeholder = text.placeholder ?? ""
            text.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            text.backgroundColor = .white
            text.layer.borderColor = UIColor.lightGrey.cgColor
                   text.textAlignment = .center
        text.textColor = .lightGray
               return text
       }()
    
       let listBtn: UIButton = {
        let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.backgroundColor = UIColor.teal.cgColor
           btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(sub), for: .touchUpInside)
           return btn
       }()
    
    let resultBtn: UIButton = {
         let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Ok", for: .normal)
         btn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
            return btn
        }()
    
    let container: UIView = {
                  let v = UIView()
                  v.translatesAutoresizingMaskIntoConstraints = false
               v.backgroundColor = .white
                  return v
    }()
    
    
    /*@objc func animateOut(){
        UIcontainer.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
             self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
        }
        ){(complete) in
            if complete {
                self.removeFromSupercontainer()
            }
            
        }
    }
    @objc func animateIn(){
        //come from the top
         self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        self.alpha = 0
        UIcontainer.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(false)
               view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
               view.isOpaque = false
               view.frame = UIScreen.main.bounds
       }
   
    override func viewDidLoad() {
        wordText.becomeFirstResponder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
               tap.cancelsTouchesInView = false
        self.container.addGestureRecognizer(tap)
         listBtn.tintColor = UIColor.link
        listBtn.setTitle("Add List", for: .normal)
        
        if currentList != nil {
            wordText.text = currentList?.name
            listBtn.setTitle("Edit List", for: .normal)
        }
        
        
        
         closeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        view.addSubview(container)
        container.addSubview(addWordImg)
         container.addSubview(closeImg)
         container.addSubview(wordLable)
        container.addSubview(wordText)
        container.addSubview(listBtn)
        container.backgroundColor = .veryLightGray//.white
        alert.addSubview(alertTitle)
        alert.addSubview(alertText)
    }
     override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
         let containerHeight = safeAreaHeight
                   
        let containerWidth = container.frame.width
               
        if isPhone{
            container.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9).isActive = true
            container.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.545).isActive = true
           // container.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/40).isActive = true
             container.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -safeAreaHeight/15).isActive = true
            container.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
      
                   wordLable.font = UIFont(name: "Helvetica-Bold", size: containerHeight/30)
                   wordText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/35)
                   listBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/40)
            
                   addWordImg.topAnchor.constraint(equalTo: container.topAnchor, constant: containerHeight/15).isActive = true
                   addWordImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.21).isActive = true
                   addWordImg.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.21).isActive = true
               
                  
                     closeImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.095).isActive = true
                    closeImg.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.095).isActive = true
                    closeImg.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -containerHeight/80).isActive = true
                   closeImg.topAnchor.constraint(equalTo: container.topAnchor, constant: containerHeight/70).isActive = true
               
                  
                   wordLable.topAnchor.constraint(equalTo: addWordImg.bottomAnchor, constant: containerHeight/70).isActive = true
                   
                   
                    wordText.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
                    wordText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.15).isActive = true
                   wordText.topAnchor.constraint(equalTo: wordLable.bottomAnchor, constant: containerHeight/80).isActive = true

             listBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -containerHeight/13).isActive = true
                   listBtn.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
                   listBtn.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.15).isActive = true
               }
               
               else{
                   
                   wordText.layer.borderWidth = 5
                   listBtn.layer.borderWidth = 5
                   resultBtn.layer.borderWidth = 5
                   alert.layer.borderWidth = 5
                   
                   container.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
                   container.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.65).isActive = true
                          container.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.55).isActive = true
            
                  // wordText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/55)
                   //listBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/40)
        
           
                   closeImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.09).isActive = true
                   closeImg.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.09).isActive = true


                   wordText.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
                   wordText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.09).isActive = true

               }
                
               container.layer.cornerRadius = containerHeight/40
                alert.layer.cornerRadius = containerHeight/40
              // container.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
               wordText.layer.cornerRadius = containerHeight/100
               listBtn.layer.cornerRadius = containerHeight/25
               resultBtn.layer.cornerRadius = containerHeight/25
                resultBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/25)
        
        alertTitle.font = UIFont.systemFont(ofSize: CGFloat(containerHeight/20), weight: .bold)
        alertText.font = UIFont.systemFont(ofSize: CGFloat(containerHeight/30), weight: .regular)

        listBtn.addShadow()
        wordText.addSlightShadow()
       // addWordImg.addShadow()
        
        addWordImg.drawCicleByFive()
        closeImg.drawCicleByFive()
        addWordImg.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        wordLable.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        wordText.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        listBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
         
    }

     /// --------------------- textcontainer  Functions ------------------------------
    
    func textcontainerDidBeginEditing(_ textcontainer: UITextView) {
        if textcontainer.textColor == UIColor.lightGray {
            textcontainer.text = nil
            textcontainer.textColor = UIColor.black
        }
    }
    
    func textcontainerDidEndEditing(_ textcontainer: UITextView) {
        if textcontainer.text.isEmpty {
            textcontainer.text = "Enter text"
            textcontainer.textColor = UIColor.lightGray
        }
    }

    @objc override func dismissKeyboard() {
        self.container.endEditing(true)
    }

    @objc func sub(sender: UIButton){
     var valid = true
        if wordText.text == "" {
            valid = false
        }
        if valid {
            let count = dbListController.checkListDuplicate(title: wordText.text ?? "")
            
            if count > 0 {
              showAlert(successful: false)
            }else{
                if currentList != nil {
                    currentList!.name = wordText.text
                    do {
                         try currentList?.managedObjectContext?.save()
                      }catch{
                         print("not saved")
                    }
                }else{
                guard let list = ListEntity(name: wordText.text ?? "", custom: true, category: "") else { return  }
                 dbListController.insertList(newList: list)
                }
                showAlert(successful: true)
            }
        }
    }
   func showAlert(successful:Bool){
         var title = ""
         var message = ""
          let containerHeight = safeAreaHeight
           container.addSubview(alert)
             alert.addSubview(resultImg)
         if successful{
            resultImg.image = UIImage(named: "correct")//?.withRenderingMode(.alwaysTemplate)
            title = "Successful"
            message = "List successfully created \nAdded to record"
             resultImg.topAnchor.constraint(equalTo: alert.topAnchor, constant: containerHeight/10).isActive = true
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss(animated: true, completion: nil)
            }
         }else{
            
            alert.addSubview(resultBtn)
            resultBtn.backgroundColor = .red
            resultImg.image = UIImage(named: "close")//?.withRenderingMode(.alwaysTemplate)
         title = "Error"
         message = "List already exist in record\nTry with another title"
             resultImg.topAnchor.constraint(equalTo: alert.topAnchor, constant: containerHeight/15).isActive = true
            resultBtn.topAnchor.constraint(equalTo: alertText.bottomAnchor, constant: containerHeight/25).isActive = true
               
               resultBtn.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.5).isActive = true
               resultBtn.heightAnchor.constraint(equalTo: alert.heightAnchor, multiplier: 0.15).isActive = true
                 resultBtn.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
               resultBtn.addSlightShadow()
         }
   
   
   // resultImg.tintColor = .white
    alertTitle.text = title
    alertText.text = message

    alertTitle.numberOfLines = 0
    alertText.numberOfLines = 0
  
   // alert.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
      alert.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    alert.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
    alert.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
 
    
    
    resultImg.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.21).isActive = true
    resultImg.heightAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.21).isActive = true
    resultImg.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true

      
    alertTitle.topAnchor.constraint(equalTo: resultImg.bottomAnchor,constant: containerHeight/80).isActive = true
    alertTitle.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
    
    
    alertText.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: containerHeight/40).isActive = true
   alertText.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
    
    alert.animateView()
    //resultImg.animate()

     }
    @objc func close(){
        //self.navigationController?.popcontainerController(animated: true)
        dismiss(animated: true, completion: nil)
      }
    @objc func closeAlert(){
        alert.removeFromSuperview()
        resultBtn.removeFromSuperview()
        resultImg.removeFromSuperview()
    }
}

