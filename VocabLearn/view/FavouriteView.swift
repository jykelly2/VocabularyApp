//
//  FavouriteView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-27.
//  Copyright © 2020 Jun K. All rights reserved.
//
 
import UIKit
import CoreData


class FavouriteView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    let isPhone = UIDevice.isPhone
    
    let screenScale = UIScreen.main.scale
    var categoryList = [Category]()
    var selectedCategory : String = ""
    var categoryColor = UIColor(red: 255/255.0, green:94/255.0, blue: 98/255.0, alpha:1)
    
    
    
    let searchBar: UISearchBar = {
        let sv = UISearchBar(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.searchBarStyle = .minimal
        sv.barStyle = .default
        sv.placeholder = "Search Word"
        //sv.showsCancelButton = true
            
        return sv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
       // tv.layer.borderWidth = 5
        //tv.backgroundColor = .clear
      //  tv.separatorStyle = .none
        tv.register(FavouritetCell.self, forCellReuseIdentifier: "FavouritetCell")
        return tv
    }()
    
    lazy var collectionView: UICollectionView = {
             let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .horizontal
             let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
             cv.translatesAutoresizingMaskIntoConstraints = false
             cv.delegate = self
             cv.dataSource = self
             cv.backgroundColor = .clear
        cv.isScrollEnabled = false
             cv.register(ListCell.self, forCellWithReuseIdentifier:"ListCell" )
             return cv
         }()
    
    lazy var closeBtn: UIButton = {
             let btn = UIButton.init(type: .system)
                btn.translatesAutoresizingMaskIntoConstraints = false
          let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
           btn.clipsToBounds = true
           btn.layer.backgroundColor = UIColor.lightGrey.cgColor
          btn.setImage(img, for: .normal)
        btn.tintColor = .lightGray
       btn.addTarget(self, action: #selector(close), for: .touchUpInside)
                return btn
       }()

    let underlineView : UIView = {
        let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
       let wordController = WordController()
        let dbWordController = DbWordController()
        private var wordList = [WordEntity]()
    
    var unique = [WordEntity]()
    var searching = false
    var searchList = [WordEntity]()
    var searchText = ""

    @objc func close(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        fetchAllWords(search: searching)
        //let teal = UIColor(red: 67/255.0, green: 195/255.0, blue: 206/255.0, alpha: 1)
        //let lightTeal = UIColor(red: 210/255.0, green: 230/255.0, blue: 255/255.0, alpha: 1)
       
         let darkerGrey = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
      //  let col1 = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        searchBar.searchTextField.font = .systemFont(ofSize: safeArea.layoutFrame.width/28)
        
        setUpCategory()
        tableView.delegate = self
              tableView.dataSource = self
              searchBar.delegate = self
        view.backgroundColor = .lightGrey

          view.addSubview(underlineView)
        underlineView.addSubview(collectionView)
         underlineView.addSubview(searchBar)
        //setNavigationBar()
        underlineView.addSubview(tableView)
        underlineView.addSubview(closeBtn)
       
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

        underlineView.addShadow()
        let darkerGrey = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
        let lightGrey = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        
        let safeAreaHeight = safeArea.layoutFrame.height
      
        if isPhone{
            underlineView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            underlineView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/90).isActive = true
             // underlineView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.95).isActive=true
            underlineView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.95).isActive=true
            underlineView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            
            closeBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaWidth/60).isActive = true
            closeBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
            closeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
            closeBtn.leadingAnchor.constraint(equalTo: underlineView.leadingAnchor, constant: safeAreaWidth/50).isActive = true
            //closeBtn.trailingAnchor.constraint(equalTo: underlineView.trailingAnchor, constant: -safeAreaWidth/50).isActive = true
            
            let image = getImageWithColor(color: darkerGrey, size: CGSize(width: safeArea.layoutFrame.width, height: safeAreaHeight/18))
            searchBar.setSearchFieldBackgroundImage(image, for: .normal)
      
            searchBar.searchTextField.layer.cornerRadius = safeAreaHeight/45
            searchBar.searchTextField.layer.masksToBounds = true

            searchBar.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: safeArea.layoutFrame.width/60).isActive = true
            searchBar.heightAnchor.constraint(equalTo: underlineView.heightAnchor, multiplier: 0.075).isActive = true
            searchBar.widthAnchor.constraint(equalTo: underlineView.widthAnchor, multiplier:0.93).isActive=true
            searchBar.searchTextField.font = UIFont(name: "Helvetica", size: safeAreaHeight/45)

            tableView.layer.cornerRadius = safeAreaHeight/50
            tableView.rowHeight = safeAreaHeight/10
            
             tableView.bottomAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: -safeAreaHeight/35).isActive = true
             //tableView.heightAnchor.constraint(equalTo: underlineView.heightAnchor,  multiplier:0.75).isActive=true
            tableView.widthAnchor.constraint(equalTo: underlineView.widthAnchor, multiplier:0.9).isActive=true
        
        }else{
            
            underlineView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/50).isActive = true
              underlineView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.95).isActive=true
            underlineView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9).isActive=true
            underlineView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
       
            let image = getImageWithColor(color: darkerGrey, size: CGSize(width: safeArea.layoutFrame.width, height: safeAreaHeight/19))
            searchBar.setSearchFieldBackgroundImage(image, for: .normal)
            searchBar.searchTextField.layer.cornerRadius = safeAreaHeight/50
            searchBar.searchTextField.font = UIFont(name: "Helvetica", size: safeAreaHeight/45)
            searchBar.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: safeArea.layoutFrame.width/25).isActive = true
            searchBar.heightAnchor.constraint(equalTo: underlineView.heightAnchor, multiplier: 0.08).isActive = true
            searchBar.widthAnchor.constraint(equalTo: underlineView.widthAnchor, multiplier:0.89).isActive=true
    
            tableView.layer.cornerRadius = safeAreaHeight/70
            tableView.rowHeight = safeAreaHeight/10
            tableView.bottomAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: -safeAreaHeight/35).isActive = true
            //tableView.heightAnchor.constraint(equalTo: underlineView.heightAnchor,  multiplier:0.72).isActive=true
            tableView.widthAnchor.constraint(equalTo: underlineView.widthAnchor, multiplier:0.88).isActive=true
         
        }
            
            collectionView.backgroundColor = .white
           // collectionView.topAnchor.constraint(equalTo: underlineView.topAnchor, constant: safeAreaHeight/35).isActive = true
            collectionView.topAnchor.constraint(equalTo: closeBtn.bottomAnchor).isActive = true
            collectionView.heightAnchor.constraint(equalTo: underlineView.heightAnchor, multiplier: 0.13).isActive=true
           // collectionView.widthAnchor.constraint(equalTo: underlineView.widthAnchor,  multiplier:0.85).isActive=true
        //collectionView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: safeAreaHeight/50).isActive = true
         collectionView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -safeAreaHeight/50).isActive = true
            collectionView.centerXAnchor.constraint(equalTo: underlineView.centerXAnchor).isActive = true

            searchBar.searchTextField.layer.masksToBounds = true
            searchBar.centerXAnchor.constraint(equalTo: underlineView.centerXAnchor).isActive = true
        
        tableView.backgroundColor = .clear
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
            closeBtn.drawCicleByFive()
        tableView.separatorStyle = .none

        collectionView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
       }
    
    @objc func addTapped(){
        print("add tapped")
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

    func setUpCategory(){
        //let allColor = UIColor(red: 201/255.0, green:255/255.0, blue: 191/255.0, alpha:0.9)
        //let allBgColor = UIColor(red: 239/255.0, green:98/255.0, blue: 159/255.0, alpha:0.9)
               
        let allColor = UIColor(red: 255/255.0, green:153/255.0, blue: 102/255.0, alpha:0.9)
        let allBgColor = UIColor(red: 255/255.0, green:94/255.0, blue: 98/255.0, alpha:0.9)
               
        let favouriteColor = UIColor(red: 220/255.0, green:36/255.0, blue: 48/255.0, alpha:0.3)
      
        let favouriteBgColor = UIColor(red: 123/255.0, green:67/255.0, blue: 151/255.0, alpha:0.3)
        
        let addedColor = UIColor(red: 67/255.0, green:206/255.0, blue: 162/255.0, alpha:0.9)
         let addedBgColor = UIColor(red: 24/255.0, green:90/255.0, blue: 157/255.0, alpha:0.3)
       // let learnedColor = UIColor(red: 186/255.0, green:83/255.0, blue: 112/255.0, alpha:0.9)
        
        // let learnedeBgColor = UIColor(red: 244/255.0, green:226/255.0, blue: 216/255.0, alpha:0.9)
        let learnedColor = UIColor(red: 97/255.0, green:67/255.0, blue: 133/255.0, alpha:0.9)
               
          let learnedeBgColor = UIColor(red: 81/255.0, green:99/255.0, blue: 149/255.0, alpha:0.3)
 
        categoryList.append(Category(title: "All", image: UIImage(named: "alllist4")!, color: .teal, bgColor: allBgColor))
        categoryList.append(Category(title: "Favourite", image: UIImage(named: "favouritelist2")!, color: .lightRed,bgColor: favouriteBgColor))
        categoryList.append(Category(title: "Added", image: UIImage(named: "addedlist2")!, color: .lightPurple ,bgColor: addedBgColor))
        categoryList.append(Category(title: "Learned", image: UIImage(named: "learnedlist2")!, color: .lightGreen,bgColor: learnedeBgColor))
    }
    
    func setNavigationBar(){
       self.navigationItem.title = "Default List"
        //self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 19)!]
          //  let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
            //  self.navigationItem.rightBarButtonItem = addButton
       }

       // --------------------- COLLECTIONVIEW Functions ------------------------------//
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
             return 1
         }

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categoryList.count
         }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row].title
        handleCategoryChange(category: category)
    }
    func handleCategoryChange(category: String){
        selectedCategory = category
         switch category {
               case "Learned":
                categoryColor = UIColor(red: 97/255.0, green:67/255.0, blue: 133/255.0, alpha:0.8)
                fetchAllLearnedWords(search: searching)
                tableView.reloadData()
               case "Favourite":
                categoryColor = UIColor(red: 220/255.0, green:36/255.0, blue: 48/255.0, alpha:0.8)
                   fetchAllFavourite(search: searching)
                   tableView.reloadData()
               case "Added":
                categoryColor = UIColor(red: 24/255.0, green:90/255.0, blue: 157/255.0, alpha:0.8)
                   fetchAllAddedWords(search: searching)
                   tableView.reloadData()
               default:
                categoryColor = UIColor(red: 255/255.0, green:94/255.0, blue: 98/255.0, alpha:0.8)
                    fetchAllWords(search: searching)
                    tableView.reloadData()
        }
    }
      
    //row margin - width
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            if isPhone{
                print("here")
                     return safeArea.layoutFrame.width/130
                
            }else{
                 return safeArea.layoutFrame.width/40
                //95
            }
        }*/
    var count = 0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print(collectionView.indexPath)
       
         return safeArea.layoutFrame.width/140
     }
    
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
            let category = categoryList[indexPath.row]
            cell.setList(category:category)
          //  cell.layer.cornerRadius = safeAreaHeight/40
        //cell.addShadow()
        //   cell.layer.borderWidth = 2
         //  cell.layer.borderColor = UIColor.white.cgColor
       
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var size = CGSize()
            if isPhone{
                size = CGSize(width: (collectionView.frame.width/4), height: (collectionView.frame.height))
                //CGSize(width: (safeArea.layoutFrame.width/6), height: (safeArea.layoutFrame.height/10))
            }else{
                size = CGSize(width: (safeArea.layoutFrame.width/9), height: (safeArea.layoutFrame.height/11.5))
            }
            return size
        }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,-10, 0, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0
                UIView.animate(withDuration: 0.5){
                    cell.layer.transform = CATransform3DIdentity
                    cell.alpha = 1.0
                }
    }

    // --------------------- TableView Functions ------------------------------//
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let safeAreaHeight = safeArea.layoutFrame.height
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: safeArea.layoutFrame.height/14))

       let label = UILabel()
       label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        if selectedCategory != ""{
            label.text = selectedCategory
        }else{
              label.text = "All"
        }
     
        if isPhone{
            label.font = UIFont(name: "Helvetica-Bold", size: tableView.frame.width/20)
            headerView.layer.cornerRadius = safeAreaHeight/80
        }
        else{
            label.font = UIFont(name: "Helvetica-Bold", size: tableView.frame.width/30)
             headerView.layer.cornerRadius = safeAreaHeight/70
        }
        label.textAlignment = .center
        label.textColor = .white//categoryColor
        headerView.backgroundColor = .lightGray
       headerView.addSubview(label)

        return headerView
    }
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return safeArea.layoutFrame.height/14
    }
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchList.count
        } else{
            return wordList.count
       }
        
       }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritetCell", for: indexPath) as! FavouritetCell
           
            var word = wordList[0]
            
           if searching{
               word = searchList[indexPath.row]
            }else{
                word = wordList[indexPath.row]
            }
            cell.setWord(word: word)
            //cell.layer.borderWidth = 1
            //cell.layer.borderColor = UIColor.black.cgColor
            cell.backgroundColor = .clear
            //cell.layoutMargins.bottom = 10
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
               //  self.navigationController?.pushViewController(wordDisplay, animated: true)
    }

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var deletingWord = ""
          if searching {
            deletingWord = searchList[indexPath.item].title!
          }else{
            deletingWord = wordList[indexPath.item].title!
        }
        self.deleteWord(title: deletingWord, database: true)
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
    // --------------------- DB Functions ------------------------------//
     
    func fetchAllFavourite(search: Bool){
        let allWords = (dbWordController.getFavouriteWords() ?? nil)!
         if (allWords != nil){
            formatWordList(allWords: allWords)
          }
     }
    
    func fetchAllWords(search: Bool){
       let allWords = (dbWordController.getAllWordsAlphabeticalSort() ?? nil)!
        if (allWords != nil){
               formatWordList(allWords: allWords)
        }
     }
    
    func fetchAllAddedWords(search: Bool){
        let allWords = (dbWordController.getAddedWords() ?? nil)!
            if (allWords != nil){
               formatWordList(allWords: allWords)
             }
        }
    func fetchAllLearnedWords(search: Bool){
        let allWords = (dbWordController.getLearnedWords() ?? nil)!
            if (allWords != nil){
               formatWordList(allWords: allWords)
             }
        }
     func formatWordList(allWords: [WordEntity]){
        wordList.removeAll()
        wordList = allWords
        if searching {
            searchList = wordList.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        }
     }
    //might not work when lots of words, removefirst might be asynced bad
    func deleteWord(title: String, database: Bool){
        searchList.removeFirst{$0.title! == title}
        wordList.removeFirst{$0.title! == title}
        if (database){
            dbWordController.deleteWord(title: title)
        }
        tableView.reloadData()
      }
    // --------------------- Search Bar ------------------------------//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        searchList = wordList.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        self.searchText = searchBar.text!
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchText = ""
        tableView.reloadData()
    }
}
// --------------------- Extension Functions ------------------------------//
extension RangeReplaceableCollection {
    @discardableResult
    mutating func removeFirst(where predicate: @escaping (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try firstIndex(where: predicate) else { return nil }
        return remove(at: index)
    }
}

extension UIView{
    func anchor(top:NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor, padding: UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
    }
}




