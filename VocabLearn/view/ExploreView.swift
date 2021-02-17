//
//  ExploreView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-12.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit

class ExploreView: UIViewController, UITableViewDelegate, UITableViewDataSource{ //UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, {
   
     let isPhone = UIDevice.isPhone
    var numberOfSection = 1
   
   // var dbLists: [ListEntity] = []
    let dblistController = DbListController()
    
    var explores: [[Explore]] = []
    
    var base: [Explore] = []

    var titles = ["","Expression","Emotion", "Business","Education", "Health"]
     var descriptions = ["Beginner", "Intermediate", "Advanced"]
     var images = ["shelf", "progress", "test"]
    
    let listCollection: UICollectionView = {
              let layout = UICollectionViewFlowLayout()
              layout.scrollDirection = .vertical
        let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
              cv.translatesAutoresizingMaskIntoConstraints = false
          
              cv.backgroundColor = .clear
              cv.register(AddedListCell.self, forCellWithReuseIdentifier:"AddedListCell" )
        cv.register(MyHeaderFooterClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderFooterClass")
              return cv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
       // tv.layer.borderWidth = 5
        //tv.backgroundColor = .clear
        tv.register(MyCustomHeader.self,forHeaderFooterViewReuseIdentifier: "MyCustomHeader")
        tv.register(ExploreTableCell.self, forCellReuseIdentifier: "ExploreTableCell")
        
        return tv
    }()
    let topView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.isUserInteractionEnabled = true
            return view
    }()
    
    let titleLbL: UILabel = {
           let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .left
          label.minimumScaleFactor = 0.1
           label.adjustsFontSizeToFitWidth = true
          label.numberOfLines = 1
          label.text = "Explore"
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
           label.text = "Study from default lists"
            label.textColor = .lightGray
             return label
      }()
      
     /* let exploreImg: UIImageView = {
          let closeImg = UIImageView()
          closeImg.translatesAutoresizingMaskIntoConstraints = false
              let img = UIImage(named: "addWordIcon")
           closeImg.image = img
          closeImg.isUserInteractionEnabled = true
           closeImg.contentMode = .scaleAspectFit
          return closeImg
      }()*/
    lazy var exploreImg: UIButton = {
                  let btn = UIButton.init(type: .system)
                 btn.translatesAutoresizingMaskIntoConstraints = false
              let img = UIImage(named: "exploreimg")?.withRenderingMode(.alwaysOriginal)
        //img?.withTintColor(.white)
                  btn.clipsToBounds = true
                 btn.layer.backgroundColor = UIColor.white.cgColor
              btn.setImage(img, for: .normal)
                  return btn
    }()
    lazy var logoImg: UIButton = {
                    let btn = UIButton.init(type: .system)
                   btn.translatesAutoresizingMaskIntoConstraints = false
                let img = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
                  // img?.withTintColor(.)
                    btn.clipsToBounds = true
                   btn.layer.backgroundColor = UIColor.white.cgColor
                btn.setImage(img, for: .normal)
                    return btn
      }()
    let btnUnlock: UIButton = {
           let btn=UIButton()
           btn.setTitle("Unlock Categories", for: .normal)
           btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.textAlignment = .center
           btn.backgroundColor=UIColor.teal
           btn.translatesAutoresizingMaskIntoConstraints=false
         //  btn.addTarget(self, action: #selector(btnNextAction), for: .touchUpInside)
           return btn
       }()
   // var underline = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setExplore()
          // listCollection.delegate = self
           //listCollection.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(listCollection)
         view.addSubview(tableView)
        view.addSubview(btnUnlock)
        view.bringSubviewToFront(btnUnlock)
       // view.addSubview(topView)
        //view.bringSubviewToFront(topView)
        view.backgroundColor = .white
        
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           hideNavigationBar(animated: animated)
          self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        
        if (isPhone){
           
            
            /*titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/50).isActive = true
            titleLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeAreaHeight/20)).isActive = true
                       
            titleDescLbL.topAnchor.constraint(equalTo: titleLbL.bottomAnchor).isActive = true
            titleDescLbL.leadingAnchor.constraint(equalTo: titleLbL.leadingAnchor).isActive = true
                       
            exploreImg.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.1).isActive=true
            exploreImg.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.1).isActive=true
            exploreImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -safeAreaHeight/30).isActive = true
            exploreImg.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
                   
            topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
              topView.heightAnchor.constraint(equalToConstant: safeAreaHeight/20 + safeAreaHeight/20).isActive=true
            topView.backgroundColor = .clear
            topView.addSlightShadow()*/
            
       
            //, constant: safeAreaHeight/50
            
            btnUnlock.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/35)
            
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
           // tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor).isActive=true
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.925).isActive=true
            
            btnUnlock.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/40).isActive = true
            btnUnlock.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.925).isActive=true
            btnUnlock.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.09).isActive=true
            btnUnlock.layer.cornerRadius = safeAreaHeight/30
            
         }else{
        }
        tableView.separatorStyle = .none
        tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        tableView.backgroundColor = .white
        btnUnlock.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        btnUnlock.addSlightShadow()
    }
    
    func openWordListViews(list:ListEntity){
           let mainSB = UIStoryboard(name:"Main", bundle:nil)
            let listDisplay = mainSB.instantiateViewController(identifier: "WordsListView") as! WordsListView
           listDisplay.currentList = list
           listDisplay.fromExplore = true
           listDisplay.modalPresentationStyle = .overFullScreen
           listDisplay.modalTransitionStyle = .crossDissolve
           UIApplication.topViewController()?.present(listDisplay, animated: true, completion: nil)
       }
       
       func setExplore(){
       // let emotionTitles = ["Love", "Happy", "Anger", "Fear", "Sad", "Excitement"]
      // let businessTitles = ["Financial","Marketing", "Enterprise", "Profession"]
       // let expressionTitles = ["Compliments","Criticism","Personality", "Description"]
         //  let socialTitles = ["Relationship", "Party", "Travel", "Relationships"]
       // let healthTitles = ["Health","Physical"]//"Environment", "Art", "Politic"]
       // let educationTitles = [ "Biology", "Chemistry","Engineering", "Mathematic"]
        
           let emotionDesc = ["Beginner", "Intermediate", "Advanced", "Advanced", "Advanced", "Advanced"]
           let businessDesc = ["Beginner", "Intermediate","Advanced", "Advanced"]
           let expressionDesc = ["Beginner", "Intermediate","Advanced", "Advanced"]
        let healthDesc = ["Beginner", "Intermediate"]
        let educationDesc = ["Beginner", "Intermediate","Advanced", "Advanced"]
        
           let emotionImg = ["anger", "excitement", "fear", "happy", "love", "sad"]
           let businessImg = ["enterprise","financial","marketing", "profession"]
        let expressionImg = ["compliments","criticism", "description", "personality"]
        let healthImg = ["mental", "physical"]
        let educationImg = ["biology", "chemistry","engineering","mathematic"]
           
           let emotionList = dblistController.getListsByCategory(category: "Emotion")
           let businessList = dblistController.getListsByCategory(category: "Business")
            let expressionList = dblistController.getListsByCategory(category: "Expression")
         let healthList = dblistController.getListsByCategory(category: "Health")
         let educationList = dblistController.getListsByCategory(category: "Education")
           
          // let firstExplore = Explore(title: "", description: "", image: UIImage(named: emotionImg[0])!, list: emotionList![0])
           
           //explores.append([firstExplore])

        
           for n in 0..<expressionList!.count {
              let explore = Explore(title: (expressionList?[n].name)!, description: expressionDesc[n], image: UIImage(named: expressionImg[n])!, list: expressionList![n])
                base.append(explore)
          }
           explores.append(base)
          
            base.removeAll()
        
           for n in 0..<emotionList!.count {
            let explore = Explore(title: (emotionList?[n].name)!, description: emotionDesc[n], image: UIImage(named: emotionImg[n])!, list: emotionList![n])
               base.append(explore)
           }
           
           explores.append(base)
     
           base.removeAll()
           for n in 0..<businessList!.count {
            let explore = Explore(title: (businessList?[n].name)!, description: businessDesc[n], image: UIImage(named: businessImg[n])!, list: businessList![n])
               base.append(explore)
           }
           explores.append(base)
           
           base.removeAll()
           for n in 0..<educationList!.count {
                let explore = Explore(title: (educationList?[n].name)!, description: educationDesc[n], image: UIImage(named: educationImg[n])!, list: educationList![n])
                   base.append(explore)
            }
           explores.append(base)
        
            base.removeAll()
                  for n in 0..<healthList!.count {
                   let explore = Explore(title: (healthList?[n].name)!, description: healthDesc[n], image: UIImage(named: healthImg[n])!, list: healthList![n])
                      base.append(explore)
            }
            explores.append(base)
       }

      //--------------TableView FUNCTIONS-----------------//
     func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeAreaHeight/20 + safeAreaHeight/20))//safeAreaHeight/25 + safeAreaHeight/45 + safeAreaHeight/50 + safeAreaHeight/10))
            headerView.backgroundColor = .white
            //view.addSubview(headerView)
            //headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            let underline = UIView(frame: CGRect.init(x: -100, y: headerView.frame.height, width: safeAreaWidth+100, height: safeAreaHeight/150))
             underline.translatesAutoresizingMaskIntoConstraints = false
             underline.backgroundColor = .white
            
        
          // headerView.addSubview(underline)
            headerView.bringSubviewToFront(underline)
            headerView.addSubview(titleLbL)
            headerView.addSubview(exploreImg)
            headerView.addSubview(logoImg)
            //  headerView.addSubview(titleDescLbL)
           
            titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/25)
            //titleDescLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
                       
            titleLbL.topAnchor.constraint(equalTo: headerView.topAnchor, constant: safeAreaHeight/30).isActive = true
             titleLbL.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
            exploreImg.heightAnchor.constraint(equalTo: headerView.widthAnchor,  multiplier:0.098).isActive=true
            exploreImg.widthAnchor.constraint(equalTo: headerView.widthAnchor,  multiplier:0.098).isActive=true
          // exploreImg.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
            exploreImg.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -safeAreaHeight/90).isActive = true
             exploreImg.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
            //exploreImg.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
            //exploreImg.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/50).isActive = true
            logoImg.heightAnchor.constraint(equalTo: headerView.widthAnchor,  multiplier:0.098).isActive=true
            logoImg.widthAnchor.constraint(equalTo: headerView.widthAnchor,  multiplier:0.098).isActive=true
            logoImg.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: safeAreaHeight/90).isActive = true
             //logoImg.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
            logoImg.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
            let size = headerView.frame.width * 0.1
            drawCicle(height: size, width:size, button: exploreImg)
            drawCicle(height: size, width:size, button: logoImg)
          //  underline.addBottomShadow()
            bottomShadow(button: exploreImg)
            bottomShadow(button: logoImg)
           // slightShadow(shadowView: underline)
            return headerView
        }else{
           let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "MyCustomHeader") as! MyCustomHeader
           headerView.title.text = titles[section]
           return headerView
        }
    }

    func bottomShadow(button:UIButton){
        button.layer.shadowRadius = safeAreaWidth/400
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: safeAreaWidth/400)
        button.layer.masksToBounds = false
    }
    func slightShadow(shadowView: UIView){
           shadowView.layer.shadowColor = UIColor.teal.cgColor
           shadowView.layer.shadowRadius = safeAreaWidth/120
           shadowView.layer.shadowOpacity = 1
           shadowView.layer.shadowOffset = .zero
           shadowView.layer.masksToBounds = false
       }
    
    func drawCicle(height: CGFloat, width: CGFloat, button: UIButton){
        button.layer.cornerRadius = 0.5 * width
        button.imageEdgeInsets = UIEdgeInsets(
                              top: height/5,
                              left: width/5,
                              bottom: height/5,
                              right: width/5)
    }
    
  /*  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
         if(velocity.y>0) {
                self.underline.isHidden = true
         }else {
                self.underline.isHidden = false
           }
    }*/
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return safeAreaHeight/20 + safeAreaHeight/30 //+ safeAreaHeight/50 + safeAreaHeight/10
        }
        return safeAreaHeight/14
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return titles.count
    }
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableCell", for: indexPath) as! ExploreTableCell
        // let cellList = dbLists[indexPath.row]
        // let explore = Explore(title: titles[indexPath.row], description: descriptions[indexPath.row], image: UIImage(named: images[indexPath.row])!, list: cellList)
        if indexPath.section != 0{
            cell.setUpExplore(explore:explores[indexPath.section-1], index: indexPath.section)
            cell.backgroundColor = .clear
           
        }
         return cell
        //let emptyCell = UITableViewCell.init()
        //return emptyCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 0
        }
        //if indexPath.section == 2 {
          //  return safeAreaHeight/2.1
       // }
        return safeAreaHeight/2.2
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,0, 50, 0)
          cell.layer.transform = rotationTransform
          cell.alpha = 0
          UIView.animate(withDuration: 0.5){
              cell.layer.transform = CATransform3DIdentity
              cell.alpha = 1.0
          }
      }

    /*  //--------------CollectionView FUNCTIONS-----------------//
            func numberOfSections(in collectionView: UICollectionView) -> Int {
                  return 2
              }
              func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                if section == 0{
                return 1
                }else{
                    return 2
                }
              }
    
   /* func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderFooterClass", for: indexPath)

            headerView.backgroundColor = UIColor.blue
            return headerView

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 180.0)
    }*/
           
           //column margin - height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
                if section == 0{
                      return safeArea.layoutFrame.width/15
                      }else{
                           return safeArea.layoutFrame.width/15
                      }
               
          }
           
          /* //row margin - width
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
               if isPhone {
                     return safeArea.layoutFrame.width/4
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
           // cell.layer.borderWidth = 3
            //cell.layer.borderColor = UIColor.white.cgColor
                   return cell
           }
           
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                     var size = CGSize()
               if isPhone{
                size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
               }else{
                       size = CGSize(width: safeArea.layoutFrame.width, height: safeArea.layoutFrame.width)
               }
                return size
           }
           
           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                //let list = listController.getLists()//selectedlist.title)
               //let formattedlist = formatList(list: list)
               let mainSB = UIStoryboard(name:"Main", bundle:nil)
                let listDisplay = mainSB.instantiateViewController(identifier: "WordsListView") as! WordsListView
                   //listDisplay.modalPresentationStyle = .fullScreen
                   //listDisplay.modalTransitionStyle = .crossDissolve
                   
            listDisplay.currentList = dbLists[indexPath.row]
                   
                   //present(listDisplay, animated: true, completion: nil)
                   self.navigationController?.pushViewController(listDisplay, animated: true)
               
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
*/
}

class MyCustomHeader: UITableViewHeaderFooterView {
    let title: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 1
        label.textColor = .darkerGray
            return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        //self.backgroundColor = .veryLightGray
        configureContents()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.backgroundColor = .white
        title.font = UIFont(name: "Helvetica-Bold", size: 18)
        //contentView.addSubview(image)
        contentView.addSubview(title)
       
        NSLayoutConstraint.activate([
          //  title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

class MyHeaderFooterClass: UICollectionReusableView {

    let defaultLbL: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .center
                    label.minimumScaleFactor = 0.1
                    label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 0
                 
      
           //label.backgroundColor = .lightBlue
             label.textColor = .white
                    return label
    }()
 override init(frame: CGRect) {
    super.init(frame: frame)
 }

 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

 }
}

/*extension ExploreView {
    func pushNavigation(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}*/

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
