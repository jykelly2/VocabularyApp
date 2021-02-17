//
//  PickListView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-04.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData
class PickListView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

        let screenScale = UIScreen.main.scale
        let screenBounds = UIScreen.main.bounds
        var pickedList = "Emotion"
        var listOptions = [List]()
        var word: WordEntity?
    var selectedList: ListEntity?
        var dbLists: [ListEntity] = []
     let listController = ListController()
    let dbListController = DbListController()
    var empty: Bool = true
          let isPhone = UIDevice.isPhone
        
        let pickerView: UIPickerView = {
            let pv = UIPickerView()
            pv.translatesAutoresizingMaskIntoConstraints = false
            pv.layer.borderColor = UIColor.white.cgColor
            pv.backgroundColor = .white
            return pv
        }()

        let container: UIView = {
               let v = UIView()
               v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .white
               return v
        }()
        
        let alert: UIView = {
                  let v = UIView()
                  v.translatesAutoresizingMaskIntoConstraints = false
               v.backgroundColor = .white
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
               btn.layer.backgroundColor = UIColor.lightGrey.cgColor
               btn.setImage(img, for: .normal)
            btn.tintColor = .lightGray
                btn.addTarget(self, action: #selector(close), for: .touchUpInside)
                return btn
           }()
        
       let resultImg: UIImageView = {
            let img = UIImageView()
               img.translatesAutoresizingMaskIntoConstraints = false
              img.contentMode = .scaleAspectFit
            return img
           }()
        
        /*let addWordImg: UIImageView = {
            let pencilImg = UIImageView()
            pencilImg.translatesAutoresizingMaskIntoConstraints = false
            pencilImg.image = UIImage(named: "addWordIcon")
             pencilImg.contentMode = .scaleAspectFit
            return pencilImg
        }()*/
        lazy var addWordImg: UIButton = {
              let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
          let img = UIImage(named: "addtolist")?.withRenderingMode(.alwaysOriginal)
            // img?.withTintColor(.)
              btn.clipsToBounds = true
             btn.layer.backgroundColor = UIColor.white.cgColor
          btn.setImage(img, for: .normal)
              return btn
      }()
    
      let wordLable: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Save to list"
            label.textAlignment = .center
         label.textColor = .lightGray
            return label
    }()
     
           let saveBtn: UIButton = {
            let btn = UIButton.init(type: .system)
                btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Save", for: .normal)
            btn.layer.borderColor = UIColor.white.cgColor
            btn.layer.backgroundColor = UIColor.teal.cgColor
               btn.setTitleColor(UIColor.white, for: .normal)
            btn.addTarget(self, action: #selector(commit), for: .touchUpInside)
               return btn
           }()
        
       /* let resultBtn: UIButton = {
             let btn = UIButton.init(type: .system)
                 btn.translatesAutoresizingMaskIntoConstraints = false
           //  btn.setTitle("commit", for: .normal)
            // btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
            // btn.layer.borderColor = UIColor.lightGray.cgColor
            // btn.layer.backgroundColor = UIColor.link.cgColor
             //   btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitle("Close", for: .normal)
            btn.setTitleColor(.white, for: .normal)
             btn.addTarget(self, action: #selector(close), for: .touchUpInside)
                return btn
            }()*/
        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(false)
            view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
            view.isOpaque = false
            view.frame = UIScreen.main.bounds
          //  showNavigationBar(animated: animated)
    }
    func setNavigationBar(){
      self.navigationItem.title = "Word Lists"
     //   self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 19)!]
      //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        //self.navigationItem.rightBarButtonItem = addButton
    }
    override func viewDidLoad() {
           super.viewDidLoad()
        fetchList()
        closeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
 
        view.addSubview(container)
        if dbLists.count > 0 {
            empty = false
             selectedList = dbLists[0]
            pickerView.delegate = self
            pickerView.dataSource = self
            container.addSubview(pickerView)
            container.addSubview(saveBtn)
            container.addSubview(alert)
            alert.addSubview(resultImg)
              alert.addSubview(alertTitle)
            alert.addSubview(alertText)
        }
        container.addSubview(closeImg)
       container.addSubview(addWordImg)
        container.addSubview(wordLable)
        container.addShadow()
                
       }
    
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        let teal = UIColor(red: 67/255.0, green: 195/255.0, blue: 206/255.0, alpha: 1)
        container.backgroundColor = .veryLightGray//.white
        let containerHeight = safeArea.layoutFrame.height
                
        if isPhone{
            if empty == false{
            addWordImg.layer.borderWidth = 2
            addWordImg.layer.borderColor = UIColor.lightBlue.cgColor
                
            saveBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/40)
            alertTitle.font = UIFont.systemFont(ofSize: CGFloat(containerHeight/20), weight: .bold)
                   
            alertText.font = UIFont.systemFont(ofSize: CGFloat(containerHeight/30), weight: .regular)
           
             wordLable.font = UIFont(name: "Helvetica-Bold", size: containerHeight/30)
           
            pickerView.layer.cornerRadius = containerHeight/40
            saveBtn.layer.cornerRadius = containerHeight/30
            alert.layer.cornerRadius = containerHeight/30
            
            addWordImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.18).isActive = true
            addWordImg.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.18).isActive = true
            addWordImg.topAnchor.constraint(equalTo: container.topAnchor, constant: containerHeight/60).isActive = true
                   
            wordLable.topAnchor.constraint(equalTo: addWordImg.bottomAnchor, constant: containerHeight/70).isActive = true
            
            pickerView.addShadow()
            pickerView.topAnchor.constraint(equalTo: wordLable.bottomAnchor, constant: containerHeight/65).isActive = true
            pickerView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
            pickerView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.45).isActive = true
                  
            saveBtn.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: containerHeight/45).isActive = true
            saveBtn.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
            saveBtn.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.12).isActive = true
            saveBtn.addShadow()
                  
            pickerView.centerXAnchor.constraint(equalTo:safeArea.centerXAnchor).isActive = true
            saveBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            addWordImg.drawCicleByFive()
            }
            //-------------------------Empty-------------------------
            else{
                wordLable.font = UIFont(name: "Helvetica-Bold", size: containerHeight/30)
                let emptyImg = UIImage(named: "emptylist")?.withRenderingMode(.alwaysOriginal)
                addWordImg.backgroundColor = .clear
                addWordImg.setImage(emptyImg, for: .normal)
                wordLable.text = "No custom list created yet"
                
                addWordImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.65).isActive = true
                addWordImg.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.55).isActive = true
                addWordImg.topAnchor.constraint(equalTo: container.topAnchor, constant: containerHeight/10).isActive = true
                                  
                wordLable.topAnchor.constraint(equalTo: addWordImg.bottomAnchor, constant: containerHeight/70).isActive = true
                
            }
            container.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
            container.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.6).isActive = true
           
            closeImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.085).isActive = true
            closeImg.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.085).isActive = true
            closeImg.drawCicleByFive()
        }
        //----------------------IPAD--------------------------------
        else{

                  saveBtn.layer.borderWidth = 5

                   container.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
                   container.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.65).isActive = true
                   container.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.55).isActive = true
                   
                   saveBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/50)
                   
                   closeImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.09).isActive = true
                   closeImg.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.09).isActive = true
                      
                          
            }
            container.layer.cornerRadius = containerHeight/40
            container.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            container.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
            closeImg.topAnchor.constraint(equalTo: container.topAnchor, constant: containerHeight/60).isActive = true
            closeImg.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -containerHeight/50).isActive = true

            addWordImg.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            wordLable.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
       func fetchList(){
        dbLists = dbListController.getCustomLists()!
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


           @objc func animateIn(){
                  //come from the top
               self.view.transform = CGAffineTransform(scaleX: 0, y: 0)
               self.view.alpha = 0
               UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping:  1, initialSpringVelocity: 0.1 , options: .curveEaseInOut,animations: {
                      self.view.transform = .identity
                   self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                   self.view.alpha = 1
                  })
              }
         /// --------------------- textView  Functions ------------------------------
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Enter text"
                textView.textColor = UIColor.lightGray
            }
        }

          /// --------------------- PickerView  Functions ------------------------------
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dbLists.count
       }
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
             let containerHeight = safeArea.layoutFrame.height
            //if isPhone == false{
                return containerHeight/10
            //}
           //return containerHeight/30
        }

        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

            var label: UILabel
            if let view = view as? UILabel { label = view }
            else { label = UILabel() }

            let containerHeight = safeArea.layoutFrame.height
            label.text = dbLists[row].name
            label.numberOfLines = 1
            label.textAlignment = .center
            if isPhone{
               label.font = UIFont.boldSystemFont(ofSize: containerHeight/15)
            }else{
                label.font = UIFont.boldSystemFont(ofSize: containerHeight/35)
            }
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.1
            label.textColor = .lightGray
            return label
        }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedList = dbLists[row]
       }
       
        @objc func commit(sender: UIButton){
        // var valid = true
            selectedList?.addToRawWords(word!)
            
            do {
                try word?.managedObjectContext?.save()
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("not saved")
            }
            
           // if valid {
            
              //  let word = Word(Id: 0, title: wordText.text!, wordType: wordType, definition: definitionText.text, sentence: sentenceText.text, category: wordCategory, date: today, favourited: false, added: true, learned: false)
               // let wordController = WordController()
               // let count = wordController.checkDuplicate(title: word.title)
                
               // if count > 0 {
                  showAlert(successful: false)
                //}else{
                 //    wordController.insertWord(newWord: word)
                    showAlert(successful: true)
                //}
            //}
        }
  
       func showAlert(successful:Bool){
             var title = ""
             var message = ""
             
        //alertTitle.textColor = .white
        //alertText.textColor = .white
             if successful{
                //alert.backgroundColor = .green
                resultImg.image = UIImage(named: "correct")//?.withRenderingMode(.alwaysTemplate)
                  title = "Successful"
                  message = "Added word to the picked list"
                
               
             }/*else{
               // alert.backgroundColor = .red
                alert.layer.borderColor = UIColor.red.cgColor
                alertTitle.textColor = UIColor.red.withAlphaComponent(0.8)
                alertText.textColor = UIColor.red.withAlphaComponent(0.8)
              //  resultBtn.backgroundColor = .red
                resultImg.image = UIImage(named: "close")//?.withRenderingMode(.alwaysTemplate)
             title = "Error"
             message = "Word already exist in record\nTry with another word"
             }*/
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss(animated: false, completion: nil)
        }
        let containerHeight = safeArea.layoutFrame.height
        
       // alert.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        //alert.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        alert.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        alert.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        container.bringSubviewToFront(alert)
     //alert.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
     //alert.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.6).isActive = true
       // resultImg.tintColor = .white
        alertTitle.text = title
        alertText.text = message
  
         //alertTitle.font = UIFont(name: "Helvetica-Bold", size: containerHeight/50)
          //alertText.font = UIFont(name: "Helvetica-Bold", size: containerHeight/70)
        
        alertTitle.numberOfLines = 0
        alertText.numberOfLines = 0
  
            
         alert.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        
     
         resultImg.topAnchor.constraint(equalTo: alert.topAnchor, constant: containerHeight/10).isActive = true
        resultImg.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.21).isActive = true
        resultImg.heightAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.21).isActive = true
        resultImg.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
       // resultImg.centerYAnchor.constraint(equalTo: alert.centerYAnchor, constant: -containerHeight/30).isActive = true
      
        
        alertTitle.topAnchor.constraint(equalTo: resultImg.bottomAnchor,constant: containerHeight/30).isActive = true
        alertTitle.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
        
        
        alertText.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: containerHeight/40).isActive = true
       alertText.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
        
        //resultImg.animate()

        alert.animateView()
    }
    
        @objc func close(){
              dismiss(animated: false, completion: nil)
          }
    }




