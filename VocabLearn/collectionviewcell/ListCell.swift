//
//  ListCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-24.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {

     let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
    
    let backgroundColorView: UIView={
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
  let title: UILabel = {
               let label = UILabel()
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .center
               label.minimumScaleFactor = 0.1
                label.adjustsFontSizeToFitWidth = true
                label.numberOfLines = 1
              // label.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 16)
        label.textColor = .lightGray
               return label
    }()
    
    let cellImage: UIButton = {
     let image = UIButton()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = false
     return image
    }()
    override func awakeFromNib ()
    {
        super.awakeFromNib()
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
       // self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
        //self.contentView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func setList(category: Category){

        let screenSize = CGSize(width: safeAreaLayoutGuide.layoutFrame.width * screenScale, height: safeAreaLayoutGuide.layoutFrame.height * screenScale)
        let contentHeight = contentView.frame.height
        
        contentView.addSubview(cellImage)
        contentView.addSubview(title)
     
        backgroundColorView.frame = contentView.frame
         backgroundColorView.layer.cornerRadius = contentHeight/10
        let gradient = CAGradientLayer()

        gradient.frame = contentView.frame
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [category.color.cgColor, category.color.cgColor]
        gradient.cornerRadius = contentHeight/5
        //gradient.locations = [0.0, 1.0]

       // contentView.sendSubviewToBack(backgroundColorView)
       // contentView.layer.insertSublayer(gradient, at: 0)
        //cellImage.addSubview(backgroundColorView)
     // cellImage.bringSubviewToFront(backgroundColorView)
        cellImage.backgroundColor = category.color
        cellImage.setImage(category.image.withRenderingMode(.alwaysTemplate), for: .normal)
        cellImage.tintColor = .white
        
        title.text = category.title
       // contentView.backgroundColor = category.color
       
        title.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width/5)
        
      
       cellImage.topAnchor.constraint(equalTo:contentView.topAnchor, constant: (screenSize.width * 0.03)).isActive = true
        cellImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
       cellImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65).isActive = true
        cellImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55).isActive = true
        let width = contentView.frame.width * 0.65
        let height = contentView.frame.height * 0.65
        makeInsetByTen(button: cellImage, width: width, height: height)
        cellImage.layer.cornerRadius = contentHeight/8
        title.topAnchor.constraint(equalTo: cellImage.bottomAnchor , constant: contentHeight/50).isActive = true
          //titleLblTwo.centerYAnchor.constraint(equalTo:pageView.centerYAnchor, constant: -(screenSize.width * 0.28)).isActive = true
                       
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
         title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive=true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       
    }
    
    func makeInsetByTen(button: UIButton, width: CGFloat, height: CGFloat){
           button.imageEdgeInsets = UIEdgeInsets(
                                        top: height/10,
                                        left: width/10,
                                        bottom: height/10,
                                        right: width/10)
       }
    
}
