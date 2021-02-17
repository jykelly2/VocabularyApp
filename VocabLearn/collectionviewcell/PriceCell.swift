//
//  PriceCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-17.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
class PriceCell : UICollectionViewCell{
    
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds

     let isPhone = UIDevice.isPhone
    
    let duration: UILabel = {
               let label = UILabel()
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .center
              // label.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 16)
        label.textColor = .lightGray
               return label
           }()
    
    let price: UILabel = {
                 let label = UILabel()
                 label.translatesAutoresizingMaskIntoConstraints = false
               //  label.font = UIFont(name: "Helvetica-Bold", size: 32)
                 label.textAlignment = .center
         label.textColor = .lightGray
                 return label
             }()
    
    let priceDesc: UILabel = {
                 let label = UILabel()
                 label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
        // label.textColor = .lightGray
               // label.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 16)
                                    
                 return label
             }()
 
    override init(frame: CGRect) {
           super.init(frame: frame)
           //setDiscover(discover: Discover)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func setPriceCell(durationTime: String, priceTag: String, pricingDesc: String ,selectedIndex: Int, index: Int){
        
        let containerHeight = contentView.frame.height
      
        if selectedIndex == index{
            price.textColor = .teal
           // priceDesc.textColor = .teal
        }else{
            price.textColor = .lightGray
           // priceDesc.textColor = .black
        }
        let screenSize = CGRect(x:0,y:0, width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        contentView.addSubview(duration)
        contentView.addSubview(price)
        contentView.addSubview(priceDesc)
    
        if isPhone{
        
          duration.font = UIFont(name: "Helvetica", size: containerHeight/8)
        price.font = UIFont(name: "Helvetica-Bold", size: containerHeight/5)
        priceDesc.font = UIFont(name: "AvenirNext-Italic", size: containerHeight/10)
        
        duration.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        priceDesc.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 5).isActive = true
            
        }else{
            duration.font = UIFont(name: "Helvetica", size: containerHeight/9)
            price.font = UIFont(name: "Helvetica-Bold", size: containerHeight/6)
            priceDesc.font = UIFont(name: "AvenirNext-Italic", size: containerHeight/12)
  
            duration.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true

            priceDesc.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 5).isActive = true
        }
        duration.text = durationTime
        price.text = priceTag
        priceDesc.text = pricingDesc
        contentView.layer.cornerRadius = 10.0
        contentView.backgroundColor = .clear
        
        price.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
         priceDesc.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
         price.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
         duration.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
