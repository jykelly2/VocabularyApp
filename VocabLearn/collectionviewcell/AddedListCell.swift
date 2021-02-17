//
//  AddedListCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-02.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class AddedListCell: UICollectionViewCell {
    let title: UILabel = {
                  let label = UILabel()
                  label.translatesAutoresizingMaskIntoConstraints = false
                  label.textAlignment = .center
                  label.minimumScaleFactor = 0.1
                   label.adjustsFontSizeToFitWidth = true
                   label.numberOfLines = 1
                  return label
       }()
    let count: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .center
                    label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 1
                    return label
         }()
    
    lazy var learnedBtn: UIButton = {
              let btn = UIButton.init(type: .system)
                 btn.translatesAutoresizingMaskIntoConstraints = false
          // let img = UIImage(named: "plusicon")?.withRenderingMode(.alwaysTemplate)
          // img?.withTintColor(.white)
          // btn.setImage(img, for: .normal)
             btn.layer.borderWidth = 3
           btn.clipsToBounds = true
           btn.layer.borderColor = UIColor.lightBlue.cgColor
           btn.layer.backgroundColor = UIColor.white.cgColor
           btn.titleLabel?.minimumScaleFactor = 0.1
           btn.titleLabel?.adjustsFontSizeToFitWidth = true
           btn.titleLabel?.numberOfLines = 1
       
                 return btn
             }()
    
    let deleteBtn: UIButton = {
              let btn = UIButton.init(type: .system)
                 btn.translatesAutoresizingMaskIntoConstraints = false
           let img = UIImage(named: "closeicon")//?.withRenderingMode(.alwaysTemplate)
          // img?.withTintColor(.white)
           btn.setImage(img, for: .normal)
           //  btn.layer.borderWidth = 2
           btn.clipsToBounds = true
        btn.backgroundColor = .clear
           //btn.layer.borderColor = UIColor.link.cgColor
           //btn.layer.backgroundColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(ListView.delete(sender:)), for: .touchUpInside)
                 return btn
     }()
    
    /*override func awakeFromNib ()
       {
           super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
           self.contentView.autoresizingMask.insert(.flexibleHeight)
           self.contentView.autoresizingMask.insert(.flexibleWidth)
          // self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
           
       }*/
  /*  override func layoutSubviews() {
        contentView.superview?.frame = bounds
        super.layoutSubviews()
    }*/
    
    func setList(list: ListEntity, index: Int){
      //  self.contentView.frame = self.bounds
        title.textColor = .white
        title.text = list.name
        title.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width/10)
        
        count.textColor = .white
        let num  = list.rawWords!.count
        count.text = num <= 1 ? String(num) + " Word" : String(num) + " Words"
        count.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width/20)
        
        var learnedCount = 0
        for word in list.words!{
            if word.learned{
                learnedCount += 1
            }
        }

        learnedBtn.setTitle(String(learnedCount), for: .normal)
         learnedBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height/10)
        contentView.backgroundColor = .backgroundGray
       // contentView.layer.cornerRadius = contentView.frame.width/20
        
        contentView.addSubview(title)
        contentView.addSubview(count)
        contentView.addSubview(learnedBtn)
        contentView.addSubview(deleteBtn)
       // title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/30).isActive = true
         title.centerYAnchor.constraint(equalTo:contentView.centerYAnchor, constant: -contentView.frame.height/5).isActive = true
        title.centerXAnchor.constraint(equalTo:contentView.centerXAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
         title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -10).isActive=true
       // title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        count.topAnchor.constraint(equalTo: title.bottomAnchor, constant: contentView.frame.height/50).isActive = true
         // title.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
        count.centerXAnchor.constraint(equalTo:contentView.centerXAnchor).isActive = true
        count.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
         count.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -10).isActive=true
        
        learnedBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.18).isActive=true
        learnedBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.18).isActive=true
        learnedBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        learnedBtn.topAnchor.constraint(equalTo: count.bottomAnchor, constant: contentView.frame.height/20).isActive = true
            //contentView.bringSubviewToFront(deleteBtn)
        learnedBtn.layer.cornerRadius = 0.5 * (contentView.frame.width * 0.18)
        //learnedBtn.clipsToBounds = true
        learnedBtn.setTitleColor(.teal, for: .normal)
        
        deleteBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.085).isActive=true
               deleteBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.085).isActive=true
        deleteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width/50).isActive = true
        deleteBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/50).isActive = true
        //contentView.bringSubviewToFront(deleteBtn)
        //deleteBtn.layer.cornerRadius = 0.5 * deleteBtn.bounds.size.width
                  
            /*  deleteBtn.imageEdgeInsets = UIEdgeInsets(
                        top: deleteBtn.frame.size.height/3,
                        left: deleteBtn.frame.size.width/3,
                        bottom: deleteBtn.frame.size.height/3,
                        right: deleteBtn.frame.size.width/3)*/
              //deleteBtn.backgroundColor = .white

        deleteBtn.tag = index
       
    }
}
