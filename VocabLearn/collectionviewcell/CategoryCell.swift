//
//  CategoryCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-24.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private let myCategoryBtn: UILabel = {
        let categoryBtn = UILabel()
        categoryBtn.textAlignment = .center;
        categoryBtn.clipsToBounds = true
        categoryBtn.contentMode = .scaleAspectFill //
        categoryBtn.layer.masksToBounds = true
        categoryBtn.layer.cornerRadius = 50.0/2.0
       // categoryBtn.backgroundColor = .lightGray
        return categoryBtn
    }()
    
    /*private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50.0/2.0
        imageView.backgroundColor = .blue
        
        return imageView
    }()*/
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(myCategoryBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myCategoryBtn.frame = contentView.bounds
    }
    public func configure(with name:String, with color: UIColor){
        //myCategoryBtn.setTitle(name, for: .normal)
        myCategoryBtn.text = name
        myCategoryBtn.backgroundColor = color
        //myImageView.image = UIImage(named: name)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
      
        //myImageView.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
