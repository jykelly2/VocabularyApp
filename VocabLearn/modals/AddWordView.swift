//
//  AddWordView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-10.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

class AddWordView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

     let isPhone = UIDevice.isPhone
     var currentList: ListEntity?
    var searching = false
     var searchList = [WordEntity]()
   // var searchText = ""
    var wordList = [WordEntity]()
     let dbWordController = DbWordController()
    
    let titleLbL: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textAlignment = .left
                    label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                     label.numberOfLines = 1
                  label.text = "Add Word"
             label.textColor = .lightGray
                    return label
         }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.register(AllWordsCell.self, forCellReuseIdentifier: "AllWordsCell")
        return tv
    }()
    
    let searchBar: UISearchBar = {
        let sv = UISearchBar(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.searchBarStyle = .minimal
        sv.barStyle = .default
        sv.placeholder = "Search Word"
        //sv.showsCancelButton = true
        return sv
    }()
    
    lazy var closeBtn: UIButton = {
         let btn = UIButton.init(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
        btn.tintColor = .lightGray
        btn.layer.backgroundColor = UIColor.lightGrey.cgColor
         btn.clipsToBounds = true
        btn.setImage(img, for: .normal)
         btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
         return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        tableView.delegate = self
       tableView.dataSource = self
        searchBar.delegate = self
        fetchAllWords()
        view.backgroundColor = .veryLightGray
        view.addSubview(titleLbL)
        view.addSubview(closeBtn)
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }

    
    func fetchAllWords(){
        wordList = dbWordController.getAllWordsAlphabeticalSort()!
    }
    @objc func closeView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc override func dismissKeyboard() {
           self.view.endEditing(true)
       }
        
    override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()
         let safeAreaHeight = safeArea.layoutFrame.height
        let safeAreaWidth = safeArea.layoutFrame.width
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
               tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
     //  titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/27)
      //  titleLbL.text = currentList?.name

           //tableView.addShadow()
           let darkerGrey = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)


           if isPhone{
            
           // titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/50).isActive = true
           // titleLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeArea.layoutFrame.height/30)).isActive = true
            
            titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/28)
            
            let image = getImageWithColor(color: .white, size: CGSize(width: safeArea.layoutFrame.width, height: safeAreaHeight/20))
                  searchBar.setSearchFieldBackgroundImage(image, for: .normal)
            
                  searchBar.searchTextField.layer.cornerRadius = safeAreaHeight/40
                  searchBar.searchTextField.layer.masksToBounds = true
            
            titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/40).isActive = true
 
            closeBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaWidth/60).isActive = true
            closeBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
            closeBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.085).isActive=true
            closeBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -safeAreaWidth/50).isActive = true

            searchBar.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeAreaHeight/50).isActive = true
                  searchBar.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.07).isActive = true
                  searchBar.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:0.93).isActive=true
                  searchBar.searchTextField.font = UIFont(name: "HelveticaNeue-Medium", size: safeAreaHeight/40)
            searchBar.searchTextField.textColor = .lightGray
                    

                  tableView.layer.cornerRadius = safeAreaHeight/50
                  tableView.rowHeight = safeAreaHeight/10
                  tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: safeAreaWidth/60).isActive = true
                  // tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.73).isActive=true
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -safeAreaWidth/30).isActive = true
                  tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:0.9).isActive=true
           
           }else{
                //  titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/50).isActive = true
                //  titleLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeArea.layoutFrame.height/30)).isActive = true
                  
                  let image = getImageWithColor(color: darkerGrey, size: CGSize(width: safeArea.layoutFrame.width, height: safeAreaHeight/17))
                        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
                  
                        searchBar.searchTextField.layer.cornerRadius = safeAreaHeight/40
                        searchBar.searchTextField.layer.masksToBounds = true

                       // searchBar.topAnchor.constraint(equalTo: titleLbL.bottomAnchor, constant: safeArea.layoutFrame.width/25).isActive = true
                        searchBar.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.07).isActive = true
                        searchBar.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:0.93).isActive=true
                        searchBar.searchTextField.font = UIFont(name: "Helvetica", size: safeAreaHeight/45)

                        tableView.layer.cornerRadius = safeAreaHeight/50
                        tableView.rowHeight = safeAreaHeight/10

                         tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.73).isActive=true
                        tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier:0.9).isActive=true
              }
        
          
         //closeBtn.imageView?.tintColor = .white
        closeBtn.drawCicleByFive()
        
         titleLbL.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        //searchBar.addSlightShadow()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
       // tableView.addSlightShadow()
        tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
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
    
       // --------------------- TableView Functions ------------------------------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
             return searchList.count
         } else{
             return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "AllWordsCell", for: indexPath) as! AllWordsCell
        if searching {
         let word = searchList[indexPath.row]
            cell.setWord(word: word)
        }
        cell.layer.cornerRadius = safeAreaHeight/60
        cell.title.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/34)
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.veryLightGray.cgColor
        cell.backgroundColor = .lightGrey
        cell.layoutMargins.bottom = 10
        cell.selectionStyle = .none
       return cell
    }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            /*if searching{
                  let word = searchList[indexPath.row]
                currentList?.addToRawWords(word)
                do {
                    try word.managedObjectContext?.save()
                    dismiss(animated: true, completion: nil)
                }catch{
                    print("not saved")
                }
              }*/
        var word = wordList[0]
        if searching{
               word = searchList[indexPath.row]
           }else{
               word = wordList[indexPath.row]
           }
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
                    let wordDisplay = mainSB.instantiateViewController(identifier: "DisplayView") as! DisplayView
                wordDisplay.modalPresentationStyle = .popover
                wordDisplay.currentWord = word
                  present(wordDisplay, animated: true, completion: nil)
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

    // --------------------- Search Bar ------------------------------//
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        searchList = wordList.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
           searching = true
         //  self.searchText = searchBar.text!
        if searchBar.text! == ""{
            searching = false
        }
           tableView.reloadData()
       }
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searching = false
           searchBar.text = ""
       //    searchText = ""
           tableView.reloadData()
       }
 
}
