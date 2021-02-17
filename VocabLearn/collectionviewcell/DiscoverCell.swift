//
//  DiscoverCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-03.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

class DiscoverCell : UICollectionViewCell{
   // @IBOutlet weak var featuredImageView: UIImageView!
   // @IBOutlet weak var backgroundColorView: UIView!
   // @IBOutlet weak var discoverTitle: UILabel!
   // @IBOutlet weak var discoverWordType: UILabel!
   // @IBOutlet weak var discoverDefinition: UILabel!
    var word: WordEntity?
    let wordController = WordController()
    let featuredImageView = UIImageView()
    let backgroundColorView = UIView()
    let discoverTitle = UILabel()
    let discoverWordType = UILabel()
    let discoverDefinition = UILabel()
    let addToListBtn: UIButton = {
             let btn = UIButton.init(type: .system)
                btn.translatesAutoresizingMaskIntoConstraints = false
          let img = UIImage(named: "plusicon")?.withRenderingMode(.alwaysTemplate)
          btn.setImage(img, for: .normal)
           // btn.layer.borderWidth = 2
          btn.clipsToBounds = true
          btn.tintColor = .lightGray
          //btn.layer.borderColor = UIColor.white.cgColor
          btn.layer.backgroundColor = UIColor.white.cgColor
         // btn.titleLabel?.minimumScaleFactor = 0.1
         // btn.titleLabel?.adjustsFontSizeToFitWidth = true
         // btn.titleLabel?.numberOfLines = 1
         // btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(ViewController.addedTapped), for: .touchUpInside)
                return btn
            }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setDiscover(discover: Discover)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDiscover(discover: Discover, index: Int){
        featuredImageView.image = discover.featuredImage
        featuredImageView.translatesAutoresizingMaskIntoConstraints = false
        featuredImageView.contentMode = .scaleAspectFit
        featuredImageView.clipsToBounds = true
        featuredImageView.backgroundColor = discover.color
        
        backgroundColorView.backgroundColor = discover.color
        
        backgroundColorView.frame = contentView.frame
        let gradient = CAGradientLayer()

        gradient.frame = contentView.frame

        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor]

        gradient.locations = [0.0, 1.0]

        backgroundColorView.layer.insertSublayer(gradient, at: 0)
        featuredImageView.addSubview(backgroundColorView)
        featuredImageView.bringSubviewToFront(backgroundColorView)
        contentView.backgroundColor = UIColor(patternImage:discover.featuredImage)
        //contentView.backgroundColor = discover.color
       // contentView.insertSubview(featuredImageView, at: 0)
       // contentView.backgroundColor = discover.color
        
        //addToListBtn.layer.backgroundColor = discover.color.cgColor
        let safeAreaWidth = safeAreaLayoutGuide.layoutFrame.width
        let safeAreaHeight = contentView.frame.height
                discoverTitle.textAlignment = .center
        discoverTitle.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/10)
                discoverTitle.translatesAutoresizingMaskIntoConstraints = false
                discoverTitle.text = discover.title
                discoverTitle.numberOfLines = 0
        discoverTitle.textColor = .white
        discoverWordType.textColor = .white
        discoverDefinition.textColor = .white
        //discoverTitle.textColor = .white
        
        
                discoverWordType.textAlignment = .center
                 discoverWordType.font = UIFont(name: "Helvetica", size: safeAreaHeight/20)
                 discoverWordType.translatesAutoresizingMaskIntoConstraints = false
                discoverWordType.text = discover.wordType
                 discoverWordType.numberOfLines = 0
        
                 discoverDefinition.textAlignment = .center
                  discoverDefinition.font = UIFont(name:"Helvetica", size: safeAreaHeight/15)
                   discoverDefinition.translatesAutoresizingMaskIntoConstraints = false
                discoverDefinition.text = discover.definition
                   discoverDefinition.numberOfLines = 0
       
        
               backgroundColorView.layer.cornerRadius = 10.0
               backgroundColorView.layer.masksToBounds = true
               featuredImageView.layer.cornerRadius = 10.0
               featuredImageView.layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 10.0
        
       // contentView.addSubview(featuredImageView)
        contentView.addSubview(backgroundColorView)
        
   // backgroundColorView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
         //backgroundColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 30).isActive = true
        // backgroundColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
       // backgroundColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30).isActive = true
        
        contentView.addSubview(discoverTitle)
        discoverTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -safeAreaHeight/4.3).isActive = true
       // discoverTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeAreaHeight/50).isActive = true
        discoverTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
        discoverTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeAreaHeight/50).isActive = true
        //discoverTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50)
        
        
        contentView.addSubview(discoverWordType)
        discoverWordType.topAnchor.constraint(equalTo: discoverTitle.bottomAnchor, constant: safeAreaHeight/60).isActive = true
        discoverWordType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
        discoverWordType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeAreaHeight/50).isActive = true
        
        contentView.addSubview(discoverDefinition)
        discoverDefinition.topAnchor.constraint(equalTo: discoverWordType.bottomAnchor, constant: safeAreaHeight/40).isActive = true
        discoverDefinition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
        discoverDefinition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeAreaHeight/50).isActive = true
        
        
        contentView.addSubview(addToListBtn)
        addToListBtn.heightAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.12).isActive=true
               addToListBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor,  multiplier:0.12).isActive=true
               addToListBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
        addToListBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:  -safeAreaHeight/50).isActive = true
       // addToListBtn.topAnchor.constraint(equalTo: contentView.topAnchor,constant:  safeAreaHeight/50).isActive = true
        //contentView.bringSubviewToFront(addToListBtn)
        let height = contentView.frame.width * 0.12
        drawCicle(button: addToListBtn, height: height)

        addToListBtn.tag = index

        }
    func drawCicle(button: UIButton, height: CGFloat){
             button.layer.cornerRadius = 0.5 * height
             button.imageEdgeInsets = UIEdgeInsets(
                                   top: height/5,
                                   left: height/5,
                                   bottom: height/5,
                                   right: height/5)
      }
}
