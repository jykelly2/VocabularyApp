//
//  QuizCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-21.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

protocol QuizCellDelegate: class {
    func didChooseAnswer(btnTitle: String, btnIndex:Int)
}

class QuizCell: UICollectionViewCell {
    
    let screenScale = UIScreen.main.scale
     let screenBounds = UIScreen.main.bounds
       var btn1: UIButton!
       var btn2: UIButton!
       var btn3: UIButton!
       var btn4: UIButton!
       var btnsArray = [UIButton]()
       var count = 0
       weak var delegate: QuizCellDelegate?
       
       var question: Question? {
           didSet {
               guard let unwrappedQue = question else { return }
               lblQue.text = unwrappedQue.questionText
               btn1.setTitle(unwrappedQue.options[0], for: .normal)
               btn2.setTitle(unwrappedQue.options[1], for: .normal)
               btn3.setTitle(unwrappedQue.options[2], for: .normal)
               btn4.setTitle(unwrappedQue.options[3], for: .normal)
            
               btn1.backgroundColor = .lightGrey
               btn2.backgroundColor = .lightGrey
            btn3.backgroundColor = .lightGrey
            btn4.backgroundColor = .lightGrey
            
           // btn1.setTitleColor(.darkGray, for: .normal)
            //btn2.setTitleColor(.darkGray, for: .normal)
            //btn3.setTitleColor(.darkGray, for: .normal)
            //btn4.setTitleColor(.darkGray, for: .normal)
            
            btn1.addSlightShadow()
            btn2.addSlightShadow()
            btn3.addSlightShadow()
            btn4.addSlightShadow()
            
         //
             
            /*print("count")
            print(count)
            if count == 2{
            initialAnimation(button: btn1)
            initialAnimation(button: btn2)
            initialAnimation(button: btn3)
            initialAnimation(button: btn4)
                
            }*/
            
            let btnLabelSize = self.frame.height/28
                    btn1.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: btnLabelSize)
                  btn2.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: btnLabelSize)
                   btn3.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: btnLabelSize)
                  btn4.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: btnLabelSize)
            //print("correct")
            //print(unwrappedQue.correctAns)
            let index = answerIndex(correctAns: unwrappedQue.correctAns)
               if unwrappedQue.isAnswered {
                btnsArray[index].backgroundColor = .lightBlue
                animate(index: index)
                   if unwrappedQue.wrongAns >= 0 {
                    animate(index: unwrappedQue.wrongAns)
                    btnsArray[unwrappedQue.wrongAns].backgroundColor = .lightRed
                   }
               }/*else{
                    initialAnimation(button: btn1)
                    initialAnimation(button: btn2)
                    initialAnimation(button: btn3)
                    initialAnimation(button: btn4)
            }*/
           }
       }
    func initialAnimation(button: UIButton){
        button.alpha = 0
        UIView.animate(withDuration: 0.3 ,
                        delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,
                    animations: {
                    button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                     
                  },
                      completion: { finish in
                        UIView.animate(withDuration: 0.3){
                        button.transform = CGAffineTransform.identity
                        button.alpha = 1
                  }
              })
    }
    func animate(index: Int){
     
        UIView.animate(withDuration: 0.3 ,
                      // delay: 0,
                       //usingSpringWithDamping: 0.5,
                       //initialSpringVelocity: 6.0,
                                   animations: {
                                    self.btnsArray[index].transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            },
                                    completion: { finish in
                                        UIView.animate(withDuration: 0.3){
                                            self.btnsArray[index].transform = CGAffineTransform.identity
                                    }
        })
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        btnsArray = [btn1, btn2, btn3, btn4]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnOptionAction(sender: UIButton) {
        guard let unwrappedQue = question else { return }
        if !unwrappedQue.isAnswered {
            delegate?.didChooseAnswer(btnTitle: sender.title(for: .normal)!, btnIndex: sender.tag)
        }
    }
    
    func answerIndex(correctAns: String) -> Int{
        var index = 0
        for i in 0..<btnsArray.count{
            if btnsArray[i].title(for: .normal) == correctAns{
                index = i
            }
        }
        return index
    }
    
   // override func prepareForReuse() {
        //btn1.backgroundColor = .lightGrey
          // btn2.backgroundColor = .lightGrey
          // btn3.backgroundColor = .lightGrey
          // btn4.backgroundColor = .lightGrey
      // }
    
    func setupViews() {
           let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        let safeAreaHeight = self.frame.height
        let safeAreaWidth = self.frame.width
        lblQue.font = UIFont.systemFont(ofSize: safeAreaHeight/25)
        //lblQue.textColor = .darkGray
        
         //addSubview(imgView)
        // imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive=true
        // imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        // imgView.widthAnchor.constraint(equalToConstant: 150).isActive=true
        // imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor).isActive=true

        addSubview(lblQue)
         lblQue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeAreaHeight/10).isActive=true
       // lblQue.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -s/5).isActive = true
         lblQue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: safeAreaWidth/20).isActive=true
         lblQue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -safeAreaWidth/30).isActive=true

       // btn1.widthAnchor.constraint(equalToConstant: btnWidth), btn1.heightAnchor.constraint(equalToConstant: btnHeight)
        // let btnWidth: CGFloat = 150
         //let btnHeight: CGFloat = 50
         btn1 = getButton(tag: 0)
         addSubview(btn1)
        NSLayoutConstraint.activate([btn1.topAnchor.constraint(equalTo: lblQue.bottomAnchor, constant: safeAreaHeight/12), btn1.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -safeAreaWidth/60), btn1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45), btn1.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33)])
         btn1.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
         
         btn2 = getButton(tag: 1)
         addSubview(btn2)
         NSLayoutConstraint.activate([btn2.topAnchor.constraint(equalTo: btn1.topAnchor), btn2.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: safeAreaWidth/60),  btn2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45), btn2.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33)])
         btn2.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
         
         btn3 = getButton(tag: 2)
         addSubview(btn3)
         NSLayoutConstraint.activate([btn3.topAnchor.constraint(equalTo: btn1.bottomAnchor, constant: safeAreaWidth/60 + safeAreaWidth/60), btn3.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -safeAreaWidth/60),  btn3.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45), btn3.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33)])
         btn3.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
         
         btn4 = getButton(tag: 3)
         addSubview(btn4)
         NSLayoutConstraint.activate([btn4.topAnchor.constraint(equalTo: btn3.topAnchor), btn4.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: safeAreaWidth/60),  btn4.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45), btn4.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33)])
         btn4.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
    
     }
     
     func getButton(tag: Int) -> UIButton {
         let btn=UIButton()
         btn.tag=tag
       //  btn.setTitle("Option", for: .normal)
         btn.setTitleColor(UIColor.black, for: .normal)
         btn.backgroundColor=UIColor.white
        // btn.layer.borderWidth=1
        // btn.layer.borderColor=UIColor.darkGray.cgColor
         btn.layer.cornerRadius=5
         btn.clipsToBounds=true
         btn.translatesAutoresizingMaskIntoConstraints=false
         return btn
     }
    
    let lblQue: UILabel = {
           let lbl=UILabel()
         //  lbl.text="This is a question and you have to answer it?"
           lbl.textColor=UIColor.black
          // lbl.textAlignment = .left          // lbl.font = UIFont.systemFont(ofSize: 16)
           lbl.numberOfLines=4
           lbl.translatesAutoresizingMaskIntoConstraints=false
           return lbl
       }()
}
