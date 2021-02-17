//
//  ExploreTableCell.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-12.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

//protocol CellProtocol {
  //  func pushNavigation(_ vc: UIViewController)
//}

class ExploreTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout{//, CellProtocol{
   
    let isPhone = UIDevice.isPhone
     var numberOfSection = 5
    let openView = ExploreView()
     //var delegate: CellProtocol?
    
     var dbLists: [ListEntity] = []
   // var titles = ["Describing Someone", "Compliments", "Expressing Anger"]
    //var descriptions = ["Beginner", "Intermediate", "Advanced"]
    //var images = ["shelf", "progress", "test"]
    var explore: [Explore] = []
    var section: Int = 0
     let dblistController = DbListController()
    
    let listCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
         let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
         cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.register(ExploreCell.self, forCellWithReuseIdentifier:"ExploreCell")
        
         //cv.register(MyHeaderFooterClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderFooterClass")
        return cv
     }()

    override func awakeFromNib() {
        super.awakeFromNib()
       // fetchList()
        listCollection.delegate = self
        listCollection.dataSource = self
    }
   // func fetchList(){
   //           dbLists = dblistController.getLists()!
   // }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpExplore(explore:[Explore], index: Int){
        
        let containerHeight = contentView.frame.height
        let containerWidth = contentView.frame.width
        listCollection.delegate = self
        listCollection.dataSource = self
        self.explore = explore
        self.section = index
        listCollection.reloadData()
        
        contentView.addSubview(listCollection)
      //  listCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerWidth/8).isActive = true
        listCollection.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        listCollection.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive=true
        listCollection.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive=true
         //listCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerWidth/8).isActive = true
    }
    
    
    
    //--------------CollectionView FUNCTIONS-----------------//
      func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return explore.count
      }
     
   /* func collectionView(_ collectionView: UICollectionView,
                         viewForSupplementaryElementOfKind kind: String,
                         at indexPath: IndexPath) -> UICollectionReusableView {
             let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderFooterClass", for: indexPath)

             headerView.backgroundColor = UIColor.clear
             return headerView

     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
             return CGSize(width: collectionView.frame.width, height: 1)
     }*/
    
            
            //column margin - height
    /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         let containerHeight = contentView.frame.height
         let containerWidth = contentView.frame.width
        
                       return containerWidth/15
           }*/
            
            //row margin - width
      /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                let containerHeight = contentView.frame.height
                let containerWidth = contentView.frame.width
                if isPhone {
                      return -containerWidth/30
                }else{
                      return containerHeight/8
                }
      }*/
                   
            
          //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
               
             //   return UIEdgeInsets(top: 0, left:0 , bottom:0, right: 0)
                    
          // }
            
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
                
               // let shareTapGestureRecognizer = MyTappedGesture(target: self, action: #selector(ExploreView.openWordListView(tapGestureRecognizer:)))
                 //      cell.addGestureRecognizer(shareTapGestureRecognizer)
                //shareTapGestureRecognizer.list = explore[indexPath.row].list.name
                cell.setExploreList(explore: explore[indexPath.row], index: section)
                
            // cell.layer.borderWidth = 3
             //cell.layer.borderColor = UIColor.link.cgColor
            cell.layer.cornerRadius = contentView.frame.height/40
            //cell.addShadow()
            /*if section == 1{
                 cell.backgroundColor = .lightRed
            }else if section == 2 {
                 cell.backgroundColor = .lightBlue
            }else{
                 cell.backgroundColor = .teal
            }*/
            cell.backgroundColor = .white
            cell.addShadow()
                    return cell
        }
    
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let containerHeight = contentView.frame.height
                let containerWidth = contentView.frame.width
                      var size = CGSize()
                if isPhone{
                    size = CGSize(width: collectionView.frame.width/2.15, height: collectionView.frame.height/2.2)
                }else{
                        size = CGSize(width: containerWidth, height: containerWidth)
                }
                 return size
            }
            
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
               // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
                
                //let shareTapGestureRecognizer = MyTappedGesture(target: self, action: #selector(ExploreView.openWordListView(tapGestureRecognizer:)))
                      // cell.addGestureRecognizer(shareTapGestureRecognizer)
               // shareTapGestureRecognizer.list = explore[indexPath.row].list.name!
                
              let list = explore[indexPath.row].list
                let mainSB = UIStoryboard(name:"Main", bundle:nil)
                let listDisplay = mainSB.instantiateViewController(identifier: "WordsListView") as! WordsListView
                    //listDisplay.modalPresentationStyle = .fullScreen
                    //listDisplay.modalTransitionStyle = .crossDissolve
                    
                listDisplay.currentList = explore[indexPath.row].list
                openView.openWordListViews(list: list)
                //openView.self.pushNavigation(listDisplay)
                //openView.self.navigationController?.popToViewController(listDisplay, animated: true)
                //self.delegate?.pushNavigation(listDisplay)
               // openView.self.present(listDisplay, animated: true, completion: nil)
                //openView.self.navigationController?.pushViewController(listDisplay, animated: true)
                
             }
         
         func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
               let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,-10, 0, 0)
                     cell.layer.transform = rotationTransform
                     cell.alpha = 0
                     UIView.animate(withDuration: 0.7){
                         cell.layer.transform = CATransform3DIdentity
                         cell.alpha = 1.0
                     }
         }

}


