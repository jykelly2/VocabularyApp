//
//  Popup.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-01.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class Popup: UIView, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
    var today = Date()
    var wordType = "Noun"
    var wordCategory = "Communicate"
    var cateogryOptions = ["Communicate", "Emotion", "Business", "Education", "Health"]
    var rotationAngle: CGFloat!
 
      let isPhone = UIDevice.isPhone
    
    let pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.layer.borderColor = UIColor.white.cgColor
        pv.backgroundColor = .link
        return pv
    }()
    
    let wordTypeControl: UISegmentedControl = {
          let sc = UISegmentedControl(items: ["Noun", "Verb", "Adj.", "Adv."])
           sc.translatesAutoresizingMaskIntoConstraints = false
          sc.selectedSegmentIndex = 0
    sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
          return sc
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
               return label
           }()
    
    let alertText: UILabel = {
             let label = UILabel()
             label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.1
            label.textAlignment = .center
             return label
         }()
    
    let closeImg: UIImageView = {
        let closeImg = UIImageView()
        closeImg.translatesAutoresizingMaskIntoConstraints = false
        closeImg.image = UIImage(named: "close")
        closeImg.isUserInteractionEnabled = true
         closeImg.contentMode = .scaleAspectFit
        return closeImg
    }()
    
   let resultImg: UIImageView = {
        let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
          img.contentMode = .scaleAspectFit
        return img
       }()
    
    let addWordImg: UIImageView = {
        let pencilImg = UIImageView()
        pencilImg.translatesAutoresizingMaskIntoConstraints = false
        pencilImg.image = UIImage(named: "addWordIcon")
         pencilImg.contentMode = .scaleAspectFit
        return pencilImg
    }()
    let wordLable: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Add Word"
           label.textAlignment = .center
           return label
       }()
       
 
       let wordText: UITextField = {
           let text = UITextField()
           text.translatesAutoresizingMaskIntoConstraints = false
           text.placeholder = "Enter word"
           let placeholder = text.placeholder ?? ""
            text.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            text.backgroundColor = .white
            text.layer.borderColor = UIColor.lightGrey.cgColor
                   text.textAlignment = .center
               return text
       }()
    
    let definitionText: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Enter definition"
        text.textColor = UIColor.lightGray
        text.backgroundColor = .white
        text.layer.borderColor = UIColor.lightGrey.cgColor
        text.textAlignment = .center
        return text
    }()
    
    let sentenceText: UITextView = {
         let text = UITextView()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.text = "Enter sentence"
         text.textColor = UIColor.lightGray
        text.backgroundColor = .white
        text.layer.borderColor = UIColor.lightGrey.cgColor
         text.textAlignment = .center
         return text
     }()
       
       let submitBtn: UIButton = {
        let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Submit", for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.backgroundColor = UIColor.link.cgColor
           btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(submit), for: .touchUpInside)
           return btn
       }()
    
    let resultBtn: UIButton = {
         let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
       //  btn.setTitle("Submit", for: .normal)
        // btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        // btn.layer.borderColor = UIColor.lightGray.cgColor
        // btn.layer.backgroundColor = UIColor.link.cgColor
         //   btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Close", for: .normal)
       // btn.setTitleColor(.white, for: .normal)
         btn.addTarget(self, action: #selector(close), for: .touchUpInside)
            return btn
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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
               tap.cancelsTouchesInView = false
              self.addGestureRecognizer(tap)
        
        definitionText.delegate = self
        sentenceText.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
         submitBtn.tintColor = UIColor.link

        //rotationAngle = -90 * (.pi/180)
        
       // pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        wordLable.font = UIFont.systemFont(ofSize: CGFloat(screenSize.width * 0.015), weight: .bold)
        
       
         closeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.isOpaque = false
        self.frame = UIScreen.main.bounds
        
          self.addSubview(container)
        let teal = UIColor(red: 67/255.0, green: 195/255.0, blue: 206/255.0, alpha: 1)
        container.backgroundColor = .veryLightGray//.white
          let containerHeight = self.frame.height
        
        if isPhone{
            
            wordText.layer.borderWidth = 2
            definitionText.layer.borderWidth = 2
            sentenceText.layer.borderWidth = 2
            submitBtn.layer.borderWidth = 2
            resultBtn.layer.borderWidth = 2
            alert.layer.borderWidth = 2
            
            container.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
            container.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.55).isActive = true

            let font =  UIFont(name: "Helvetica-Bold", size: containerHeight/65)
            wordTypeControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any], for: .normal)
          
            wordText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/65)
            submitBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/60)
            sentenceText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/65)
           definitionText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/65)

            container.addSubview(addWordImg)
        
            container.addSubview(closeImg)
              closeImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.1).isActive = true
             closeImg.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true

             container.addSubview(wordTypeControl)
            
            container.addSubview(pickerView)
            container.addSubview(wordText)
             wordText.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
             wordText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.08).isActive = true
           
            container.addSubview(definitionText)
            container.addSubview(sentenceText)
            container.addSubview(submitBtn)
        }
        
        else{
            
            wordText.layer.borderWidth = 5
            definitionText.layer.borderWidth = 5
            sentenceText.layer.borderWidth = 5
            submitBtn.layer.borderWidth = 5
            resultBtn.layer.borderWidth = 5
            alert.layer.borderWidth = 5
            
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            container.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.65).isActive = true
                   container.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.55).isActive = true
            
            let font =  UIFont(name: "Helvetica-Bold", size: containerHeight/65)
                   wordTypeControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any], for: .normal)
            wordText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/55)
            submitBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/50)
            sentenceText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/55)
            definitionText.font = UIFont(name: "HelveticaNeue-Medium", size: containerHeight/55)
              
            container.addSubview(addWordImg)
        
            container.addSubview(closeImg)
            closeImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.09).isActive = true
            closeImg.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.09).isActive = true
            
            container.addSubview(wordTypeControl)
            container.addSubview(pickerView)
            
            container.addSubview(wordText)
            wordText.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
            wordText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.09).isActive = true
            
            container.addSubview(definitionText)
            container.addSubview(sentenceText)
            container.addSubview(submitBtn)
   
        }
        
        container.layer.cornerRadius = containerHeight/30
        pickerView.layer.cornerRadius = containerHeight/40
        wordText.layer.cornerRadius = containerHeight/100
        definitionText.layer.cornerRadius = containerHeight/80
        sentenceText.layer.cornerRadius = containerHeight/80
        submitBtn.layer.cornerRadius = containerHeight/60
        resultBtn.layer.cornerRadius = containerHeight/60
        alert.layer.cornerRadius = containerHeight/30
        
        container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        addWordImg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.15).isActive = true
        addWordImg.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.15).isActive = true
        
        closeImg.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -containerHeight/60).isActive = true
        
        wordTypeControl.topAnchor.constraint(equalTo: addWordImg.bottomAnchor).isActive = true
        wordTypeControl.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        wordTypeControl.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.08).isActive = true
        
        pickerView.topAnchor.constraint(equalTo: wordTypeControl.bottomAnchor, constant: containerHeight/70).isActive = true
        pickerView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        pickerView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.13).isActive = true
        
        wordText.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: containerHeight/70).isActive = true
        
        definitionText.topAnchor.constraint(equalTo: wordText.bottomAnchor, constant: containerHeight/70).isActive = true
        definitionText.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        definitionText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.15).isActive = true
        
        sentenceText.topAnchor.constraint(equalTo: definitionText.bottomAnchor, constant: containerHeight/70).isActive = true
        sentenceText.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        sentenceText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.15).isActive = true
        
        submitBtn.topAnchor.constraint(equalTo: sentenceText.bottomAnchor, constant: containerHeight/65).isActive = true
        submitBtn.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        submitBtn.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.09).isActive = true
        
        container.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive = true
        addWordImg.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        wordTypeControl.centerXAnchor.constraint(equalTo:container.centerXAnchor).isActive = true
               pickerView.centerXAnchor.constraint(equalTo:container.centerXAnchor).isActive = true
        wordText.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        definitionText.centerXAnchor.constraint(equalTo:container.centerXAnchor).isActive = true
         sentenceText.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
           submitBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    @objc fileprivate func handleSegmentChange(){
             switch wordTypeControl.selectedSegmentIndex {
             case 0:
               wordType = "Noun"
             case 1:
                wordType = "Verb"
             case 2:
                wordType = "Adjective"
            case 3:
                wordType = "Adverb"
             default:
                 wordType = "Noun"
             }
         }
    /*@objc fileprivate func handleCategoryChange(){
             switch wordCategoryControl.selectedSegmentIndex {
             case 0:
               wordCategory = "Emotion"
               wordCategoryControl.backgroundColor = .link
             case 1:
               wordCategory = "Casual"
                wordCategoryControl.backgroundColor = .green
             case 2:
            wordCategory = "Expression"
                wordCategoryControl.backgroundColor = .red
             default:
               wordCategory = "Emotion"
                wordCategoryControl.backgroundColor = .link
             }
        
        print(wordCategory)
         }*/

      /// --------------------- PickerView  Functions ------------------------------
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return cateogryOptions.count
   }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
         let containerHeight = self.frame.height
        //if isPhone == false{
            return containerHeight/30
        //}
       //return containerHeight/30
    }
   
  /* func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return cateogryOptions[row]
   }*/
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }

        let containerHeight = self.frame.height
        label.text = cateogryOptions[row]
        label.numberOfLines = 1
        label.textAlignment = .center
        if isPhone{
           label.font = UIFont.boldSystemFont(ofSize: containerHeight/45)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: containerHeight/35)
        }
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1

        return label
    }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      wordCategory = cateogryOptions[row]
       switch wordCategory {
           case "Emotion":
              pickerView.backgroundColor = .link
            case "Casual":
              pickerView.backgroundColor = .green
            case "Expression":
               pickerView.backgroundColor = .red
            default:
               pickerView.backgroundColor = .link
       }
   }
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }

    @objc func submit(sender: UIButton){
     var valid = true
        if wordText.text == "" {
            valid = false
        }
        if definitionText.text == "Enter definition" || definitionText.text == "Enter text" || definitionText.text == ""{
            valid = false
        }
        
        if sentenceText.text == "Enter sentence" || sentenceText.text == "Enter text" || sentenceText.text == ""{
                   valid = false
        }
        if valid {
        
           // let word = Word(Id: 0, title: wordText.text!, wordType: wordType, definition: definitionText.text, sentence: sentenceText.text, category: wordCategory, date: today, favourited: false, added: true, learned: false)
            
            let worddb = WordEntity(title: wordText.text!, wordType: wordType, definition: definitionText.text, sentence: sentenceText.text, category: wordCategory, favourited: false, added: true, learned: false)
            
            do {
                try worddb?.managedObjectContext?.save()
                  showAlert(successful: true)
            }catch{
                print("unsuccessful")
            }
          /*  let wordController = WordController()
            let count = wordController.checkDuplicate(title: word.title)*/
            
           /* if count > 0 {
              showAlert(successful: false)
            }else{
                 wordController.insertWord(newWord: word)
                showAlert(successful: true)
            }*/
        }
    }
   func showAlert(successful:Bool){
         var title = ""
         var message = ""
         
    //alertTitle.textColor = .white
    //alertText.textColor = .white
         if successful{
            //alert.backgroundColor = .green
            alert.layer.borderColor = UIColor.green.cgColor
            alertTitle.textColor = UIColor.green.withAlphaComponent(0.8)
            alertText.textColor = UIColor.green.withAlphaComponent(0.8)
           // resultBtn.backgroundColor = .green
            resultBtn.layer.borderColor = UIColor.green.cgColor
            resultBtn.setTitleColor(.green, for: .normal)
            resultImg.image = UIImage(named: "correct")//?.withRenderingMode(.alwaysTemplate)
            title = "Successful"
            message = "Word was successfully added"
         }else{
           // alert.backgroundColor = .red
            alert.layer.borderColor = UIColor.red.cgColor
            alertTitle.textColor = UIColor.red.withAlphaComponent(0.8)
            alertText.textColor = UIColor.red.withAlphaComponent(0.8)
          //  resultBtn.backgroundColor = .red
            resultBtn.layer.borderColor = UIColor.red.cgColor
            resultBtn.setTitleColor(.red, for: .normal)
            resultImg.image = UIImage(named: "close")//?.withRenderingMode(.alwaysTemplate)
         title = "Error"
         message = "Word already exist in record\nTry with another word"
         }
    
    let containerHeight = self.frame.height
 
   // resultImg.tintColor = .white
    alertTitle.text = title
    alertText.text = message
    
    resultBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: containerHeight/50)
     alertTitle.font = UIFont(name: "Helvetica-Bold", size: containerHeight/50)
      alertText.font = UIFont(name: "Helvetica-Bold", size: containerHeight/70)
    
    alertTitle.numberOfLines = 0
    alertText.numberOfLines = 0
    
    alertTitle.font = UIFont.systemFont(ofSize: CGFloat(container.frame.width * 0.06), weight: .bold)
              
       alertText.font = UIFont.systemFont(ofSize: CGFloat(container.frame.width * 0.06), weight: .regular)
        
     alert.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
    
    container.addSubview(alert)
    alert.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
      alert.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
     alert.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
    alert.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
    
     alert.addSubview(resultImg)
     resultImg.topAnchor.constraint(equalTo: alert.topAnchor, constant: containerHeight/15).isActive = true
    resultImg.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.25).isActive = true
    resultImg.heightAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.25).isActive = true
    resultImg.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true

      alert.addSubview(alertTitle)
    alertTitle.topAnchor.constraint(equalTo: resultImg.bottomAnchor,constant: containerHeight/30).isActive = true
    alertTitle.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
    
    alert.addSubview(alertText)
    alertText.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: containerHeight/40).isActive = true
   alertText.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
    
    alert.addSubview(resultBtn)
    
    resultBtn.bottomAnchor.constraint(equalTo: alert.bottomAnchor, constant: -containerHeight/40).isActive = true
    
    resultBtn.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.3).isActive = true
    resultBtn.heightAnchor.constraint(equalTo: alert.heightAnchor, multiplier: 0.09).isActive = true
      resultBtn.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
          
    
    
     }
    
    @objc func close(){
          animateOut()
      }
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [wordLable, wordText])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [horizontalStack, submitBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
   
}
