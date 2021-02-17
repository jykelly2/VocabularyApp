//
//  CustomWordView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-09-01.
//  Copyright © 2020 Jun K. All rights reserved.
//



import UIKit

class CustomWordView: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var wordType = "Noun"
    var wordCategory = "Communicate"
    var cateogryOptions = ["Expression", "Emotion", "Business", "Education", "Health"]

    let isPhone = UIDevice.isPhone
    
    let pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.layer.borderColor = UIColor.white.cgColor
        pv.backgroundColor = .teal
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
        v.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        v.isOpaque = false
        //view.frame = UIScreen.main.bounds
           return v
       }()
    
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
    
    lazy var closeBtn: UIButton = {
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
    
   let resultImg: UIImageView = {
        let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
          img.contentMode = .scaleAspectFit
        return img
       }()
    
    let addWordImg: UIImageView = {
        let pencilImg = UIImageView()
        pencilImg.translatesAutoresizingMaskIntoConstraints = false
        pencilImg.image = UIImage(named: "education5")
         pencilImg.contentMode = .scaleAspectFit
        return pencilImg
    }()
    let wordLable: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Add your custom word"
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
        text.textColor = .darkerGray
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
        btn.setTitle("Add", for: .normal)
        btn.layer.backgroundColor = UIColor.teal.cgColor
           btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(submit), for: .touchUpInside)
           return btn
       }()
    
    let resultBtn: UIButton = {
         let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Close", for: .normal)
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
         btn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
            return btn
        }()
    
    override func viewDidLoad() {
           super.viewDidLoad()
       // view.addSubview(wordLable)
            view.addSubview(addWordImg)
                   view.addSubview(closeBtn)
                   view.addSubview(wordTypeControl)
                   view.addSubview(pickerView)
                   view.addSubview(wordText)
                   view.addSubview(definitionText)
                   view.addSubview(sentenceText)
                   view.addSubview(submitBtn)
                    alert.addSubview(alertTitle)
                    alert.addSubview(alertText)
       }

    
   override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
               tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        definitionText.delegate = self
        sentenceText.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
         submitBtn.tintColor = UIColor.link

        wordLable.font = UIFont.systemFont(ofSize: safeAreaHeight/30, weight: .bold)

        if isPhone{
            wordText.layer.borderWidth = 2
            definitionText.layer.borderWidth = 2
            sentenceText.layer.borderWidth = 2

            let font =  UIFont(name: "Helvetica-Bold", size: safeAreaHeight/40)
            wordTypeControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any], for: .normal)
          
            wordText.font = UIFont(name: "HelveticaNeue-Medium", size: safeAreaHeight/35)
            submitBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/30)
            sentenceText.font = UIFont(name: "HelveticaNeue-Medium", size: safeAreaHeight/35)
           definitionText.font = UIFont(name: "HelveticaNeue-Medium", size: safeAreaHeight/35)
            
            closeBtn.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: safeAreaWidth/30).isActive = true
            closeBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaHeight/35).isActive = true
            closeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1).isActive = true
            closeBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1).isActive = true

             wordText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
             wordText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
         
        }
            
        else{
            wordText.layer.borderWidth = 5
            definitionText.layer.borderWidth = 5
            sentenceText.layer.borderWidth = 5
            submitBtn.layer.borderWidth = 5
        }
        
        //view.layer.cornerRadius = safeAreaHeight/30
        pickerView.layer.cornerRadius = safeAreaHeight/40
        wordText.layer.cornerRadius = safeAreaHeight/100
        definitionText.layer.cornerRadius = safeAreaHeight/80
        sentenceText.layer.cornerRadius = safeAreaHeight/80
        submitBtn.layer.cornerRadius = safeAreaHeight/25
        resultBtn.layer.cornerRadius = safeAreaHeight/30
        alert.layer.cornerRadius = safeAreaHeight/60
    

    addWordImg.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: safeAreaHeight/60).isActive = true
        addWordImg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        addWordImg.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        
        wordTypeControl.topAnchor.constraint(equalTo: addWordImg.bottomAnchor).isActive = true
        wordTypeControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        wordTypeControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        pickerView.topAnchor.constraint(equalTo: wordTypeControl.bottomAnchor, constant: safeAreaHeight/70).isActive = true
        pickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        wordText.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: safeAreaHeight/70).isActive = true
        
        definitionText.topAnchor.constraint(equalTo: wordText.bottomAnchor, constant: safeAreaHeight/70).isActive = true
        definitionText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        definitionText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13).isActive = true
        
        sentenceText.topAnchor.constraint(equalTo: definitionText.bottomAnchor, constant: safeAreaHeight/70).isActive = true
        sentenceText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        sentenceText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13).isActive = true
        
        submitBtn.topAnchor.constraint(equalTo: sentenceText.bottomAnchor, constant: safeAreaHeight/30).isActive = true
        submitBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        submitBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
    // submitBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeAreaHeight/45).isActive = true
    adjustContentSize(tv: sentenceText)
    adjustContentSize(tv: definitionText)
    submitBtn.addSlightShadow()
    closeBtn.drawCicleByFive()
        addWordImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordTypeControl.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
               pickerView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        wordText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        definitionText.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
         sentenceText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  
    }
    
     /// --------------------- textView  Functions ------------------------------
    
    func adjustContentSize(tv: UITextView){
        let deadSpace = tv.bounds.size.height - tv.contentSize.height
        let inset = max(0, deadSpace/2.0)
        tv.contentInset = UIEdgeInsets(top: inset, left: tv.contentInset.left, bottom: inset, right: tv.contentInset.right)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.darkerGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.adjustContentSize(tv: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textView == self.definitionText ? "Enter Definition" : "Enter Sentence"
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

      /// --------------------- PickerView  Functions ------------------------------
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return cateogryOptions.count
   }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        //if isPhone == false{
            return safeAreaHeight/15
        //}
       //return safeAreaHeight/30
    }
   
  /* func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return cateogryOptions[row]
   }*/
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }

        label.text = cateogryOptions[row]
        label.numberOfLines = 1
        label.textAlignment = .center
        if isPhone{
           label.font = UIFont.boldSystemFont(ofSize: safeAreaHeight/25)
        }else{
            label.font = UIFont.boldSystemFont(ofSize: safeAreaHeight/35)
        }
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1

        return label
    }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      wordCategory = cateogryOptions[row]
       switch wordCategory {
        case "Expression":
        pickerView.backgroundColor = .teal
           case "Emotion":
              pickerView.backgroundColor = .lightRed
            case "Business":
              pickerView.backgroundColor = .lightOrange
        case "Education":
            pickerView.backgroundColor = .lightPurple
        case "Health":
                 pickerView.backgroundColor = .lightGreen
            default:
               pickerView.backgroundColor = .lightPink
       }
   }
    @objc override func dismissKeyboard() {
        view.endEditing(true)
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
     
            let wordController = DbWordController()
            let count = wordController.checkDuplicate(title: wordText.text!)
            if (count < 1){
                let worddb = WordEntity(title: wordText.text!, wordType: wordType, definition: definitionText.text, sentence: sentenceText.text, category: wordCategory, favourited: false, added: true, learned: false)
                
                do {
                    try worddb?.managedObjectContext?.save()
                      showAlert(successful: true)
                }catch{
                    print("unsuccessful")
                }
            }else{
                showAlert(successful: false)
            }
        }
    }
   func showAlert(successful:Bool){
    container.frame = view.bounds
    view.addSubview(container)
        view.addSubview(alert)
        alert.addSubview(resultImg)
       
         var title = ""
         var message = ""

         if successful{
            resultImg.topAnchor.constraint(equalTo: alert.topAnchor, constant: safeAreaHeight/10).isActive = true
            resultImg.image = UIImage(named: "correct")//?.withRenderingMode(.alwaysTemplate)
            title = "Successful"
            message = "Word successfully created \nAdded to record"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                          self.dismiss(animated: true, completion: nil)
            }
         }else{
            resultImg.topAnchor.constraint(equalTo: alert.topAnchor, constant: safeAreaHeight/15).isActive = true
             alert.addSubview(resultBtn)
             resultBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/35)
            resultImg.image = UIImage(named: "close")//?.withRenderingMode(.alwaysTemplate)
            title = "Error"
            message = "Word already exist in record\nTry with another word"
            
            resultBtn.topAnchor.constraint(equalTo: alertText.bottomAnchor, constant: safeAreaHeight/25).isActive = true
            
            resultBtn.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.5).isActive = true
            resultBtn.heightAnchor.constraint(equalTo: alert.heightAnchor, multiplier: 0.15).isActive = true
              resultBtn.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
            resultBtn.addSlightShadow()
         }

    alertTitle.text = title
    alertText.text = message
    
   alertTitle.font = UIFont.systemFont(ofSize: CGFloat(safeAreaHeight/25), weight: .bold)
    alertText.font = UIFont.systemFont(ofSize: CGFloat(safeAreaHeight/35), weight: .regular)
     //alertTitle.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/25)
     // alertText.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/35)
    
    alertTitle.numberOfLines = 0
    alertText.numberOfLines = 0
  
    alert.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -safeAreaHeight/15).isActive = true
      alert.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    alert.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
    alert.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55).isActive = true

    resultImg.widthAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.25).isActive = true
    resultImg.heightAnchor.constraint(equalTo: alert.widthAnchor, multiplier: 0.25).isActive = true
    resultImg.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true

   
    alertTitle.topAnchor.constraint(equalTo: resultImg.bottomAnchor,constant: safeAreaHeight/30).isActive = true
    alertTitle.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
    
  
    alertText.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: safeAreaHeight/40).isActive = true
   alertText.centerXAnchor.constraint(equalTo: alert.centerXAnchor).isActive = true
    
    alert.animateView()

     }
      @objc func closeView(){
            dismiss(animated: true, completion: nil)
        }
    
    @objc func closeAlert(){
        alert.removeFromSuperview()
        container.removeFromSuperview()
        resultBtn.removeFromSuperview()
        resultImg.removeFromSuperview()
    }
}

