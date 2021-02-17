//
//  ListView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-02.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

/*protocol NameOfDelegate{
    func someFunction(type: String)
}*/
class ListView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout{
    
 let isPhone = UIDevice.isPhone
    var empty = false
    var lists = [List]()
     var dbLists: [ListEntity] = []
      let listController = ListController()
     let dblistController = DbListController()
    var count: Int = 0
    let listCollection: UICollectionView = {
          // let layout = UICollectionViewFlowLayout()
           //layout.scrollDirection = .horizontal
        let floawLayout = UPCarouselFlowLayout()
             floawLayout.scrollDirection = .horizontal
             floawLayout.sideItemScale = 0.85
            floawLayout.sideItemAlpha = 0.8
             floawLayout.spacingMode = .fixed(spacing: 0.1)
           let cv = UICollectionView(frame:.zero,collectionViewLayout: floawLayout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.backgroundColor = .clear
           cv.register(AddedListCell.self, forCellWithReuseIdentifier:"AddedListCell" )
           return cv
       }()
    
    
    let defaultLbL: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .center
                    label.minimumScaleFactor = 0.1
                    label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 0
                  label.text = "Default"
      
           //label.backgroundColor = .lightBlue
             label.textColor = .white
                    return label
         }()
    
    let titleLbL: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left
                    label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 1
                  label.text = "My Lists"
                  // label.backgroundColor = .lightBlue
             label.textColor = .darkerGray
                    return label
    }()
    
    let titleDescLbL: UILabel = {
                      let label = UILabel()
                      label.translatesAutoresizingMaskIntoConstraints = false
                      label.textAlignment = .left
                      label.minimumScaleFactor = 0.1
                       label.adjustsFontSizeToFitWidth = true
                       label.numberOfLines = 1
                    label.text = "Make your own lists"
                    // label.backgroundColor = .lightBlue
               label.textColor = .lightGray
                      return label
      }()

    let descriptionLbL: UILabel = {
               let label = UILabel()
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .center
               label.minimumScaleFactor = 0.1
                label.adjustsFontSizeToFitWidth = true
                label.numberOfLines = 1
             label.text = "All  Favourite  Added  Learned "
              
        label.textColor = .white
               return label
    }()
    
    lazy var defaultImg: UIButton = {
                 let btn = UIButton.init(type: .system)
                btn.translatesAutoresizingMaskIntoConstraints = false
             let img = UIImage(named: "alllist2")
                 btn.clipsToBounds = true
                //img.backgroundColor = .lightTeal
             btn.setImage(img, for: .normal)
        btn.tintColor = .white
                 return btn
         }()
    
    let defaultListView : UIView = {
        let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .lightTeal
        return view
    }()
    let emptyImg: UIImageView = {
              let img = UIImageView()
              img.translatesAutoresizingMaskIntoConstraints = false
              img.image = UIImage(named: "emptylist")
             img.contentMode = .scaleAspectFit
        //img.layer.borderWidth = 2
        //img.layer.borderColor = UIColor.lightBlue.cgColor
              return img
    }()
    let emptyLbL: UILabel = {
                     let label = UILabel()
                     label.translatesAutoresizingMaskIntoConstraints = false
                     label.textAlignment = .left
                     label.minimumScaleFactor = 0.1
                      label.adjustsFontSizeToFitWidth = true
                      label.numberOfLines = 1
                   label.text = "Tap + to add new list"
              label.textColor = .lightGray
                     return label
     }()
    let addBtn: UIButton = {
           let btn = UIButton.init(type: .system)
              btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "plusicon")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(img, for: .normal)
       // btn.setTitle("Add", for: .normal)
        //btn.titleLabel?.minimumScaleFactor = 0.1
         //btn.titleLabel?.adjustsFontSizeToFitWidth = true
         //btn.titleLabel?.numberOfLines = 1
         //btn.setTitleColor(UIColor.white, for: .normal)
         // btn.layer.borderWidth = 2
        btn.clipsToBounds = true
       // btn.layer.borderColor = UIColor.link.cgColor
        btn.layer.backgroundColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
              return btn
    }()
    let topView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let underlineView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGrey
            return view
    }()
    lazy var listImg: UIButton = {
              let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
          let img = UIImage(named: "listimg")?.withRenderingMode(.alwaysOriginal)
            // img?.withTintColor(.)
              btn.clipsToBounds = true
             btn.layer.backgroundColor = UIColor.white.cgColor
          btn.setImage(img, for: .normal)
              return btn
      }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        fetchList()
        listCollection.delegate = self
        listCollection.dataSource = self
        self.listCollection.showsHorizontalScrollIndicator = false
       // listCollection.register(AddedListCell.self, forCellWithReuseIdentifier:"AddedListCell")
     
        //defaultImg.image =
        view.addSubview(defaultListView)
        view.addSubview(defaultLbL)
        view.addSubview(descriptionLbL)
        view.addSubview(defaultImg)
        //view.addSubview(titleLbL)
        //view.addSubview(addBtn)
        view.addSubview(topView)
        topView.addSubview(titleLbL)
        topView.addSubview(addBtn)
       // topView.addSubview(underlineView)
        topView.addSubview(listImg)
       // topView.addSubview(titleDescLbL)
        view.backgroundColor = .white
        if dbLists.count == 0 {
            empty = true
            view.addSubview(emptyLbL)
            view.addSubview(emptyImg)
        }else{
            view.addSubview(listCollection)
        }
        //view.addSubview(customLbL)
         
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.listCollection.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(defaultTapped))
        defaultListView.addGestureRecognizer(tap)
        if (isPhone){
             descriptionLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/40)
             titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/25)
            //titleDescLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
            defaultLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/20)
           // addBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/50)
            
          //  customLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/50).isActive = true
          //  customLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaWidth/17).isActive = true
           //customLbL.trailingAnchor.constraint(equalTo: defaultListView.trailingAnchor, constant: -safeAreaHeight/70).isActive = true
            if empty{
                emptyLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/35)
                emptyLbL.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeAreaHeight/40).isActive = true
               emptyLbL.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
                emptyImg.topAnchor.constraint(equalTo: emptyLbL.bottomAnchor, constant: safeAreaHeight/80).isActive = true
               
                // emptyImg.bottomAnchor.constraint(equalTo: defaultListView.topAnchor, constant: -safeAreaHeight/80).isActive = true
                               
                emptyImg.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.45).isActive = true
                emptyImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.83).isActive = true
                emptyImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
                emptyImg.backgroundColor = .white
                emptyImg.layer.cornerRadius = emptyImg.frame.width * 0.5 //safeAreaWidth/30
                emptyImg.clipsToBounds = true
                
                //emptyImg.addSlightShadow()
                defaultListView.topAnchor.constraint(equalTo: emptyImg.bottomAnchor, constant: safeAreaHeight/30).isActive = true
            }
            else{
                listCollection.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeAreaHeight/40).isActive = true
                listCollection.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.5).isActive=true
                listCollection.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
             //   listCollection.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
                defaultListView.topAnchor.constraint(equalTo: listCollection.bottomAnchor, constant: safeAreaHeight/40).isActive = true
            }
            titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/30).isActive = true
            //titleLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeAreaHeight/40)).isActive = true
            listImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
            listImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
           // listImg.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/50).isActive = true
            listImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -safeAreaHeight/30).isActive = true
            //listImg.leadingAnchor.constraint(equalTo:defaultListView.leadingAnchor).isActive = true
           // listImg.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
             listImg.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            //titleDescLbL.topAnchor.constraint(equalTo: titleLbL.bottomAnchor).isActive = true
            //titleDescLbL.leadingAnchor.constraint(equalTo: titleLbL.leadingAnchor).isActive = true
            //titleDescLbL.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
                
            topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                          //topView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.15).isActive=true
            topView.bottomAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/55).isActive = true
            topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
            //topView.addShadow()
          //  underlineView.widthAnchor.constraint(equalTo:defaultListView.widthAnchor).isActive=true
          //  underlineView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
          //  underlineView.heightAnchor.constraint(equalToConstant: safeAreaHeight/150).isActive=true
                
            addBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
            addBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.09).isActive=true
            addBtn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: safeAreaHeight/30).isActive = true
            //addBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -safeAreaHeight/30).isActive = true
             addBtn.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            //addBtn.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
            //addBtn.bottomAnchor.constraint(equalTo: titleLbL.bottomAnchor).isActive = true
            //addBtn.layer.cornerRadius = safeAreaHeight/60
           // addBtn.layer.cornerRadius = 0.5 * addBtn.bounds.size.width
                
           
           // defaultLbL.topAnchor.constraint(equalTo: listCollection.bottomAnchor, constant: safeArea.layoutFrame.height/50).isActive = true
           // defaultLbL.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
           // defaultLbL.leadingAnchor.constraint(equalTo: customLbL.leadingAnchor).isActive = true
          
             defaultListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/40).isActive = true
            //defaultListView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.65).isActive=true
            defaultListView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.83).isActive=true
            
            defaultListView.addSubview(defaultLbL)
            defaultLbL.topAnchor.constraint(equalTo: defaultListView.topAnchor, constant: safeAreaHeight/30).isActive = true
             defaultLbL.leadingAnchor.constraint(equalTo: defaultListView.leadingAnchor, constant: safeAreaHeight/90).isActive = true
            defaultLbL.trailingAnchor.constraint(equalTo: defaultListView.trailingAnchor, constant: -safeAreaHeight/90).isActive = true
            
            defaultListView.addSubview(descriptionLbL)
            descriptionLbL.topAnchor.constraint(equalTo: defaultLbL.bottomAnchor).isActive = true
            descriptionLbL.leadingAnchor.constraint(equalTo: defaultListView.leadingAnchor, constant: safeAreaHeight/70).isActive = true
            descriptionLbL.trailingAnchor.constraint(equalTo: defaultListView.trailingAnchor, constant: -safeAreaHeight/70).isActive = true
            
            defaultListView.addSubview(defaultImg)
            defaultImg.topAnchor.constraint(equalTo: descriptionLbL.bottomAnchor, constant: safeAreaHeight/70).isActive = true
            defaultImg.heightAnchor.constraint(equalTo: defaultListView.widthAnchor,  multiplier:0.22).isActive=true
            defaultImg.widthAnchor.constraint(equalTo: defaultListView.widthAnchor,  multiplier:0.22).isActive=true
            defaultImg.bottomAnchor.constraint(equalTo: defaultListView.bottomAnchor, constant: -safeAreaHeight/70).isActive = true
           // defaultImg.leadingAnchor.constraint(equalTo: defaultListView.leadingAnchor,constant: safeAreaHeight/70).isActive = true
         }else{
           // collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeArea.layoutFrame.height/40).isActive = true
            listCollection.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.6).isActive=true
            listCollection.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.8).isActive=true
             listCollection.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        }
       // listCollection.layer.cornerRadius = safeArea.layoutFrame.width/60
        topView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
      //  topView.addSlightShadow()
      //  underlineView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
      // listImg.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        titleLbL.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        defaultListView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
      // defaultLbL.centerXAnchor.constraint(equalTo: defaultListView.centerXAnchor).isActive = true
        
        defaultImg.centerXAnchor.constraint(equalTo: defaultListView.centerXAnchor).isActive = true
       // descriptionLbL.centerYAnchor.constraint(equalTo: defaultListView.centerYAnchor).isActive = true
        
       // defaultListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        defaultImg.drawCicleByFive()
        listImg.drawCicleByFive()
        listImg.strongBottomShadow()
        addBtn.strongBottomShadow()
        underlineView.addBottomShadow()
        //defaultImg.makeRounded()
        listCollection.addSlightShadow()
        defaultListView.layer.cornerRadius = safeAreaWidth/30
        defaultListView.addSlightShadow()
        
        addBtn.drawCicleByFive()
        view.bringSubviewToFront(defaultLbL)
       
        if count == 0{
         let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,-10, 0, 0)
             defaultListView.layer.transform = rotationTransform
             defaultListView.alpha = 0
             UIView.animate(withDuration: 0.7){
                 self.defaultListView.layer.transform = CATransform3DIdentity
                 self.defaultListView.alpha = 1.0
             }
            count += 1
        }
        
    }
    
    @objc func defaultTapped(){
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
         let listDisplay = mainSB.instantiateViewController(identifier: "FavouriteView") as! FavouriteView
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         self.navigationController?.pushViewController(listDisplay, animated: true)
    }
    
    func fetchList(){
        dbLists = dblistController.getCustomLists()!
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "Word Lists"
       //   self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 19)!]
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
          //self.navigationItem.rightBarButtonItem = addButton
      }
    
    @objc func addTapped(){
         let mainSB = UIStoryboard(name:"Main", bundle:nil)
            let editListView = mainSB.instantiateViewController(identifier: "ListPopup") as! ListPopup
        //editListView.modalTransitionStyle = .coverVertical
        editListView.modalPresentationStyle = .overFullScreen
        present(editListView, animated: true, completion: nil)
   }
    
  func refresh(){
        fetchList()
          UIView.transition(with: self.listCollection, duration: 0.5, options: .transitionCrossDissolve, animations: {self.listCollection.reloadData()}, completion: nil)
    }
    
    @objc func delete (sender: UIButton){
            let index = sender.tag
            let list = dbLists[index]
        let deleteAlert = UIAlertController(title: "Delete List",
                                                message: "Are you sure you want to delete the list?",
                                                preferredStyle: .alert)
          
               deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let deleteBtn = (UIAlertAction(title: "Delete", style: .default, handler: {
               _ in
        
            self.deleteList(list: list)
            self.dbLists.remove(at: index)
            UIView.transition(with: self.listCollection, duration: 0.5, options: .transitionCrossDissolve, animations: {self.listCollection.reloadData()}, completion: nil)
            let indexPath = IndexPath(item: index-1, section: 0)
            self.listCollection.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
           }))
             deleteBtn.setValue(UIColor.systemRed, forKey: "titleTextColor")
        
               deleteAlert.addAction(deleteBtn)
               self.present(deleteAlert, animated: true, completion: nil)
          }
    
    func deleteList(list: ListEntity){
        dblistController.deleteList(list:list)
        if dbLists.count == 0 {
            
        }
    }
    //--------------CollectionView FUNCTIONS-----------------//
        func numberOfSections(in collectionView: UICollectionView) -> Int {
              return 1
          }
          func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dbLists.count
       }
       
       //column margin - height
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return safeArea.layoutFrame.width/15
      }
       
       //row margin - width
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           if isPhone {
                 return 10
           }else{
                 return safeArea.layoutFrame.width/8
           }
       }*/
              
       
      /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           if collectionView == self.collectionView{
                    return UIEdgeInsets(top: 0, left:0 , bottom: 0, right: 0)
               }else{
                  return UIEdgeInsets(top: 0, left:0 , bottom:safeArea.layoutFrame.width/10, right: 0)
               }
      }*/
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddedListCell", for: indexPath) as! AddedListCell
               let cellList = dbLists[indexPath.row]
        cell.setList(list: cellList, index: indexPath.row)
        cell.deleteBtn.tintColor = .white
        cell.contentView.layer.cornerRadius = safeAreaWidth/30
       
       // cell.layer.borderWidth = 3
        //cell.layer.borderColor = UIColor.white.cgColor
               return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                 var size = CGSize()
           if isPhone{
            size = CGSize(width: listCollection.frame.width/1.23, height: listCollection.frame.size.height)
            // CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
           }else{
                   size = CGSize(width: safeArea.layoutFrame.width, height: safeArea.layoutFrame.width)
           }
            return size
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let mainSB = UIStoryboard(name:"Main", bundle:nil)
            let listDisplay = mainSB.instantiateViewController(identifier: "WordsListView") as! WordsListView
               //listDisplay.modalPresentationStyle = .fullScreen
        //listDisplay.modalTransitionStyle = .coverVertical
               
                listDisplay.currentList = dbLists[indexPath.row]
               navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
               //present(listDisplay, animated: true, completion: nil)
               self.navigationController?.pushViewController(listDisplay, animated: true)
           
        }
    
  /*  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,-10, 0, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0
                UIView.animate(withDuration: 0.7){
                    cell.layer.transform = CATransform3DIdentity
                    cell.alpha = 1.0
                }
    }*/
    
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let layout = self.listCollection.collectionViewLayout as! UPCarouselFlowLayout
            let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
            let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
            currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        }
        fileprivate var currentPage: Int = 0 {
            didSet {
                print("page at centre = \(currentPage)")
            }
        }
        
        fileprivate var pageSize: CGSize {
            let layout = self.listCollection.collectionViewLayout as! UPCarouselFlowLayout
            var pageSize = layout.itemSize
            if layout.scrollDirection == .horizontal {
                pageSize.width += layout.minimumLineSpacing
            } else {
                pageSize.height += layout.minimumLineSpacing
            }
            return pageSize
        }
    
    func snapToNearestCell(scrollView: UIScrollView) {
         let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
         if let indexPath = self.listCollection.indexPathForItem(at: CGPoint(x: middlePoint, y: 0)) {
              self.listCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
         }
    }
   
}

