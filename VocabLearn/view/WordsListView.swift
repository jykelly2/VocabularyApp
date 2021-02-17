//
//  WordsListView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-02.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

class WordsListView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{//UITableViewDelegate, UITableViewDataSource {
    
    var currentList: ListEntity?
     let isPhone = UIDevice.isPhone
    var empty: Bool = false
    var searching = false
    var searchList = [WordEntity]()
    var wordList = [WordEntity]()
    var searchText = ""
    var fromExplore = false
    
    let searchBar: UISearchBar = {
           let sv = UISearchBar(frame: .zero)
           sv.translatesAutoresizingMaskIntoConstraints = false
           sv.searchBarStyle = .minimal
           sv.barStyle = .default
           sv.placeholder = "Search Word"
           //sv.showsCancelButton = true
           return sv
       }()
    
       
       /*let tableView: UITableView = {
           let tv = UITableView(frame: .zero, style: .plain)
           tv.translatesAutoresizingMaskIntoConstraints = false
          // tv.layer.borderWidth = 5
           //tv.backgroundColor = .clear
        tv.separatorStyle = .none
           tv.register(WordListCell.self, forCellReuseIdentifier: "WordListCell")
           return tv
       }()*/
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.register(WordListCell.self, forCellWithReuseIdentifier: "WordListCell")
        return cv
    }()
    let containerView : UIView = {
           let view = UIView()
               view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .white
           return view
    }()
    
    let titleLbL: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left
                    label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 1
             label.textColor = .darkerGray
                    return label
    }()
    let countLbL: UILabel = {
                       let label = UILabel()
                       label.translatesAutoresizingMaskIntoConstraints = false
                       label.textAlignment = .left
                       label.minimumScaleFactor = 0.1
                        label.adjustsFontSizeToFitWidth = true
                        label.numberOfLines = 1
        label.textColor = .lightGray
                       return label
       }()
    
    let quizBtn: UIButton = {
        let btn = UIButton.init(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Quiz", for: .normal)
            //btn.layer.borderWidth = 2
            btn.isUserInteractionEnabled = true
           // btn.layer.borderColor = UIColor.white.cgColor
            btn.layer.backgroundColor = UIColor.teal.cgColor
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.addTarget(self, action: #selector(didTapQuiz), for: .touchUpInside)
            return btn
    }()
    let addBtn: UIButton = {
              let btn = UIButton.init(type: .system)
                 btn.translatesAutoresizingMaskIntoConstraints = false
           let img = UIImage(named: "plusicon")?.withRenderingMode(.alwaysTemplate)
           btn.setImage(img, for: .normal)
           btn.clipsToBounds = true
        btn.tintColor = .teal
           btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
                 return btn
       }()
    
       let editBtn: UIButton = {
               let btn = UIButton.init(type: .system)
                  btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "editicon")?.withRenderingMode(.alwaysTemplate)
        img?.withTintColor(.green)
            btn.setImage(img, for: .normal)
            btn.clipsToBounds = true
        btn.tintColor = .teal
            btn.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
                  return btn
        }()
    lazy var closeBtn: UIButton = {
          let btn = UIButton.init(type: .system)
             btn.translatesAutoresizingMaskIntoConstraints = false
       let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
        btn.clipsToBounds = true
        btn.layer.backgroundColor = UIColor.lightGrey.cgColor
        btn.tintColor = .lightGray
       btn.setImage(img, for: .normal)
    btn.addTarget(self, action: #selector(close), for: .touchUpInside)
             return btn
    }()
    
    let emptyImg: UIImageView = {
              let img = UIImageView()
              img.translatesAutoresizingMaskIntoConstraints = false
              img.image = UIImage(named: "emptywords")
             img.contentMode = .scaleAspectFit
              return img
    }()
    let emptyLbL: UILabel = {
                     let label = UILabel()
                     label.translatesAutoresizingMaskIntoConstraints = false
                     label.textAlignment = .center
                     label.minimumScaleFactor = 0.1
                      label.adjustsFontSizeToFitWidth = true
                      label.numberOfLines = 1
                   label.text = "Tap + to add words"
              label.textColor = .lightGray
                     return label
     }()
    let emptyTitle: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .center
                    label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 1
             label.textColor = .darkerGray
                    return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        wordList = currentList!.words!
        collectionView.delegate = self
         collectionView.dataSource = self
        searchBar.delegate = self
        
        view.backgroundColor = .lightGrey//.lightBlue
        view.addSubview(containerView)
        containerView.addSubview(closeBtn)
        containerView.addSubview(editBtn)
        containerView.addSubview(addBtn)
       
        
        containerView.addSubview(quizBtn)
        if currentList?.words?.count == 0 {
            empty = true
            containerView.addSubview(emptyImg)
            containerView.addSubview(emptyLbL)
           containerView.addSubview(emptyTitle)
        }else{
            containerView.addSubview(searchBar)
            containerView.addSubview(titleLbL)
            containerView.addSubview(countLbL)
            containerView.addSubview(collectionView)
        }
        closeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    @objc func close(){
        if fromExplore{
            dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func didTapQuiz(_ button: UIButton){
        if (currentList?.words!.count)! >= 3{
        let date = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let dateDay = Calendar.current.date(from: components)!
        
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
        let testingView = mainSB.instantiateViewController(identifier: "TestingView") as! TestingView
        let takenQuiz = Quiz(type: "Mix", category: "Mix", list: (currentList?.name!)!, score: 0, date: dateDay)
        testingView.takenQuiz = takenQuiz
         testingView.currentList = currentList
        self.navigationController?.pushViewController(testingView, animated: true)
        }else{
            let alert = UIAlertController(title: "Not Enough Words",
            message: "You need at least 5 words", preferredStyle: .alert)
                         
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()
         //let safeAreaHeight = safeArea.layoutFrame.height
       
           //tableView.addShadow()
           let darkerGrey = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
           let lightGrey = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
      
          if isPhone{
            
            closeBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaWidth/60).isActive = true
            closeBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
            closeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
            closeBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: safeAreaWidth/50).isActive = true
          
            quizBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/35)
                     // quizBtn.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: safeAreaHeight/35).isActive = true
            quizBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -safeAreaHeight/55).isActive = true
             quizBtn.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
             quizBtn.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.07).isActive = true
             quizBtn.layer.cornerRadius = quizBtn.frame.height/2//safeAreaHeight/30
             
           
            editBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive=true
            editBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive=true
                     
           
            addBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive=true
            addBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.07).isActive=true
             addBtn.trailingAnchor.constraint(equalTo: editBtn.leadingAnchor, constant: -safeAreaWidth/25).isActive = true
        
           

            containerView.layer.cornerRadius = safeAreaHeight/50
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            //, constant: safeAreaHeight/80
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/90).isActive = true
            // containerView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.95).isActive=true
            containerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.95).isActive=true
                   
            if empty{
                /*titleLbL.backgroundColor = .blue
                countLbL.backgroundColor = .purple
                 //titleLbL.leadingAnchor.constraint(equalTo: closeBtn.leadingAnchor, constant: safeAreaWidth/30).isActive = true
                 editBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -safeAreaWidth/30).isActive = true*/
             
                //titleLbL.leadingAnchor.constraint(equalTo: emptyImg.leadingAnchor, constant: safeAreaWidth/40).isActive = true
               
                emptyTitle.text = currentList?.name
                emptyTitle.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/27)
                emptyTitle.topAnchor.constraint(equalTo: closeBtn.bottomAnchor, constant: safeAreaWidth/55).isActive = true
                emptyTitle.leadingAnchor.constraint(equalTo: emptyImg.leadingAnchor, constant: safeAreaWidth/40).isActive = true
            //searchBar.topAnchor.constraint(equalTo: emptyTitle.bottomAnchor).isActive = true
            editBtn.centerYAnchor.constraint(equalTo: emptyTitle.centerYAnchor).isActive = true
            addBtn.centerYAnchor.constraint(equalTo: emptyTitle.centerYAnchor).isActive = true
             
                editBtn.trailingAnchor.constraint(equalTo: emptyImg.trailingAnchor, constant: -safeAreaWidth/50).isActive = true
                emptyLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/27)
                emptyLbL.topAnchor.constraint(equalTo: emptyTitle.bottomAnchor, constant: safeAreaHeight/30).isActive = true
              //  emptyLbL.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: safeAreaHeight/30).isActive = true
              //  emptyLbL.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -safeAreaHeight/30).isActive = true
                emptyLbL.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
                emptyImg.topAnchor.constraint(equalTo: emptyLbL.bottomAnchor).isActive = true
                emptyImg.bottomAnchor.constraint(equalTo: quizBtn.topAnchor, constant: -safeAreaHeight/80).isActive = true
                //emptyImg.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
                emptyImg.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.90).isActive = true
                emptyImg.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
                emptyImg.backgroundColor = .clear
             }
            else{
                titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/27)
                countLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/50)
                titleLbL.text = currentList?.name
                var count = "0 Word"
                count = (currentList?.rawWords!.count)! > 1 ? String(currentList?.rawWords?.count ?? 0) + " Words" : String(currentList?.rawWords?.count ?? 0) + " Word"
                countLbL.text = count
                
                titleLbL.topAnchor.constraint(equalTo: closeBtn.bottomAnchor, constant: safeAreaWidth/55).isActive = true
                     
                countLbL.topAnchor.constraint(equalTo: titleLbL.bottomAnchor,constant: safeAreaWidth/80).isActive = true
                countLbL.leadingAnchor.constraint(equalTo: titleLbL.leadingAnchor, constant: safeAreaWidth/80).isActive = true
                titleLbL.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: safeAreaWidth/40).isActive = true
            editBtn.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
            addBtn.centerYAnchor.constraint(equalTo: titleLbL.centerYAnchor).isActive = true
            let image = getImageWithColor(color: .lightGrey, size: CGSize(width: safeArea.layoutFrame.width, height: safeAreaHeight/20))
             searchBar.setSearchFieldBackgroundImage(image, for: .normal)
            searchBar.searchTextField.layer.cornerRadius = safeAreaHeight/40
            searchBar.searchTextField.layer.masksToBounds = true
            searchBar.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.07).isActive = true
            searchBar.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier:0.93).isActive=true
            searchBar.searchTextField.font = UIFont(name: "Helvetica", size: safeAreaHeight/45)
            searchBar.topAnchor.constraint(equalTo: countLbL.bottomAnchor).isActive = true
                 editBtn.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -safeAreaWidth/50).isActive = true
                collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
                collectionView.bottomAnchor.constraint(equalTo: quizBtn.topAnchor, constant: -safeAreaHeight/100).isActive = true
                        //  collectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor,  multiplier:0.73).isActive=true
                collectionView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier:0.92).isActive=true
            }
           }else{
                //  titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/50).isActive = true
                //  titleLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeArea.layoutFrame.height/30)).isActive = true
                  
                  let image = getImageWithColor(color: darkerGrey, size: CGSize(width: safeArea.layoutFrame.width, height: safeAreaHeight/17))
                        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
                  
                        searchBar.searchTextField.layer.cornerRadius = safeAreaHeight/40
                        searchBar.searchTextField.layer.masksToBounds = true

                        searchBar.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeArea.layoutFrame.width/25).isActive = true
                        searchBar.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.08).isActive = true
                        searchBar.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:0.93).isActive=true
                        searchBar.searchTextField.font = UIFont(name: "Helvetica", size: safeAreaHeight/45)

                        //tableView.layer.cornerRadius = safeAreaHeight/50
                        //tableView.rowHeight = safeAreaHeight/10

                         //tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.73).isActive=true
                        //tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:0.9).isActive=true
              }
       
        containerView.addShadow()
        containerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        closeBtn.drawCicleByFive()

        quizBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        if empty == false{
            collectionView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
            swipeLeft.direction = .left
            collectionView.addGestureRecognizer(swipeLeft)
            searchBar.searchTextField.layer.masksToBounds = true
             searchBar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        }
        
    }

    @objc func handleSwipeLeft(swipeGestureRecognizer: UISwipeGestureRecognizer){
          let touchPoint = swipeGestureRecognizer.location(in: self.collectionView)
          if let indexPath = collectionView.indexPathForItem(at: touchPoint){
            var word = wordList[0]
               if searching{
                word = searchList[indexPath.row]
                    searchList.remove(at: indexPath.row)
              }else{
                 word = wordList[indexPath.row]
                    wordList.remove(at: indexPath.row)
               }
            currentList?.removeFromRawWords(word)
            do {
                 try currentList?.managedObjectContext?.save()
              }catch{
                 print("not saved")
            }
            UIView.transition(with: collectionView, duration: 1.0, options: .transitionCrossDissolve, animations: {self.collectionView.reloadData()}, completion: nil)
          }
       }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
              let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
              UIGraphicsBeginImageContextWithOptions(size, false, 0)
              color.setFill()
              UIRectFill(rect)
              let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
              UIGraphicsEndImageContext()
              return image
          }

    func setNavigationBar(){
        
       // self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 19)!]
        
       
      //  let editButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(editTapped))
      
        self.navigationItem.title = "My List"//currentList?.name
       // let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
         // self.navigationItem.rightBarButtonItems = [editButton, addButton]
     
      }
    
    @objc func editTapped(){
           let mainSB = UIStoryboard(name:"Main", bundle:nil)
                       let editListView = mainSB.instantiateViewController(identifier: "ListPopup") as! ListPopup
                editListView.currentList = currentList
                   editListView.modalPresentationStyle = .overFullScreen
                   //addWordView.modalTransitionStyle = .
        present(editListView, animated: true, completion: nil)
      }
    
    @objc func addTapped(){
              let mainSB = UIStoryboard(name:"Main", bundle:nil)
            let addWordView = mainSB.instantiateViewController(identifier: "AddWordView") as! AddWordView
        addWordView.currentList = currentList
        addWordView.modalPresentationStyle = .popover
        //addWordView.modalTransitionStyle = .
        present(addWordView, animated: true, completion: nil)
          }
    
           // --------------------- CollectionView Functions ------------------------------//
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
             return 1
         }

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           if searching{
                return searchList.count
            } else{
                return wordList.count
           }
         }
      
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return safeArea.layoutFrame.height/80
                }
               /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                 
                    return 100
                }*/
           
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordListCell", for: indexPath) as! WordListCell
                  var word = wordList[0]
              
                  if searching{
                      word = searchList[indexPath.row]
                 }else{
                    word = wordList[indexPath.row]
                  }
            
           /* cell.learnedBtn.layer.cornerRadius = 0.5 * cell.learnedBtn.bounds.size.width
            cell.learnedBtn.imageEdgeInsets = UIEdgeInsets(
                top: cell.learnedBtn.frame.size.height/5,
                left: cell.learnedBtn.frame.size.width/5,
                bottom: cell.learnedBtn.frame.size.height/5,
                right: cell.learnedBtn.frame.size.width/5)*/
              cell.setWord(word: word)
           // cell.backgroundColor = .lightGrey
            cell.layer.cornerRadius = cell.frame.height/10
               return cell
         }
         
         func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height/7))
         }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var word = wordList[0]
               if searching{
                      word = searchList[indexPath.row]
                  }else{
                      word = wordList[indexPath.row]
                  }
               let mainSB = UIStoryboard(name:"Main", bundle:nil)
                           let wordDisplay = mainSB.instantiateViewController(identifier: "DisplayView") as! DisplayView
                         wordDisplay.modalPresentationStyle = .fullScreen
                             wordDisplay.currentWord = word
                         
                         present(wordDisplay, animated: true, completion: nil)
    }
    
       // --------------------- TableView Functions ------------------------------//
    
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if searching{
             return searchList.count
         } else{
             return wordList.count
        }
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "WordListCell", for: indexPath) as! WordListCell
            var word = wordList[0]
        
            if searching{
                word = searchList[indexPath.row]
           }else{
              word = wordList[indexPath.row]
            }
        cell.setWord(word: word)
         return cell
     }
 

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var word = wordList[0]
        if searching{
               word = searchList[indexPath.row]
           }else{
               word = wordList[indexPath.row]
           }
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
                    let wordDisplay = mainSB.instantiateViewController(identifier: "DisplayView") as! DisplayView
                  wordDisplay.modalPresentationStyle = .fullScreen
                      wordDisplay.currentWord = word
                  
                  present(wordDisplay, animated: true, completion: nil)
    }
    
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var deletingWord = wordList[0]
                          
        if searching{
            deletingWord = searchList[indexPath.row]
        }else{
            deletingWord = wordList[indexPath.row]
        }
         self.deleteWord(word: deletingWord)
         
     }*/
    
    func deleteWord(word:WordEntity){
         currentList?.removeFromRawWords(word)
         do {
           try word.managedObjectContext?.save()
             dismiss(animated: true, completion: nil)
         }catch{
             print("not saved")
         }
     }
    // --------------------- Search Bar ------------------------------//
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        searchList = wordList.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
           searching = true
        if searchBar.text! == "" || searchText == ""{
            self.dismissKeyboard()
        }
           self.searchText = searchBar.text!
        collectionView.reloadData()
          // tableView.reloadData()
       }
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searching = false
       
           searchBar.text = ""
           searchText = ""
        collectionView.reloadData()
           //tableView.reloadData()
       }
}

