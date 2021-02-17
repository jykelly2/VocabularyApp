//
//  HistoryView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-23.
//  Copyright © 2020 Jun K. All rights reserved.
//
//import Foundation
import UIKit
import CoreData

class HistoryView: UIViewController,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ExpandableHeaderViewDelegate {

    private var collectionView: UICollectionView?
    
  
    let wordController = WordController()

    private var wordList = [Word]()
    
    private let model = ["All", "Emotion", "Casual"]
    
    private let color = [UIColor.gray, UIColor.blue, UIColor.red]

    var sections = [Section]()
    var dayCount = 0
    var unique = [Word]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtWordCategory: UITextField!
    
    @IBOutlet var txtWordTitle: UITextField!
    @IBOutlet var txtWordType: UITextField!
    @IBOutlet var txtWordDefinition: UITextField!
    @IBOutlet var txtWordSentence: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllWords()
       // getSection()
        tableView.delegate = self
        tableView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:150, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        guard let myCollection = collectionView else{
        return
        }
        view.addSubview(myCollection)
       // self.setupTapGesture()

    }
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y:100, width: view.frame.size.width, height: 50).integral
              
      
    }
    
      // --------------------- CollectionView Functions ------------------------------//
    
   /* private func setupTapGesture(){

        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
          self.collectionView?.addGestureRecognizer(tapGesture)
      }
      
      @objc func handleTap(_ gestureReconizer: UITapGestureRecognizer){
       if gestureReconizer.state == .ended{
              let touchPoint = gestureReconizer.location(in: self.collectionView)
              
            if let indexPath = collectionView?.indexPathForItem(at: touchPoint){
                  self.categoryTap(indexPath: indexPath)
              }
          }
      }
    
   private func categoryTap(indexPath: IndexPath){
    let selectedItemTitle = model[indexPath.row]
          print(selectedItemTitle)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int ) -> Int{
        return model.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.configure(with: model[indexPath.row], with: color[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = model[indexPath.row]
        filterByCategory(category: selectedCategory)
        
    }
    
      // --------------------- TableView Functions ------------------------------//

   /* func getSection(){
    //  let unique = wordList.unique{$0.date}
      for day in unique{
        let listByDay = wordList.filter { $0.date == day.date }
         dayCount += 1
            sections.append(Section(day: "Day "+String(dayCount), words: listByDay, expanded: false))
        }
        tableView.reloadData()
    }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].words.count
       }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded){
            return 175
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        
        header.customInit(title: sections[section].day, section: section, delegate: self)
        
        return header
    }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        let word = sections[indexPath.section].words[indexPath.row]
        
        cell.setWord(word: word)
        cell.wordID.isHidden = true
        
        var button = UIButton();
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0);
        
       
        
         var imageView = UIImage()
               
          if word.favourited == true{
            imageView = (UIImage(named: "Favourite")?.withRenderingMode(.alwaysTemplate))!
            button.tintColor = .red
          }else{
            imageView = (UIImage(named: "Favourite")?.withRenderingMode(.alwaysOriginal))!
               }

        button.setImage(imageView, for: .normal)
        
        button.addTarget(self, action: #selector(self.pressedFinished), for: .touchUpInside)


        cell.accessoryView = button;
        
       /* let deselectedImage = UIImage(named: "Favourite")?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: "Favourite")?.withRenderingMode(.alwaysTemplate)

        var imageView = UIImageView()
        
        if word.favourited == true{
           
             imageView = UIImageView(image: selectedImage)
            imageView.tintColor = .red
        }else{
              imageView = UIImageView(image: deselectedImage)
            
             
        }
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        
        cell.accessoryView = imageView*/
        
        return cell
       }
    @objc func pressedFinished(_ sender:UIButton){
        let location = self.tableView.convert(sender.bounds.origin, from: sender)
        let indexPath = self.tableView.indexPathForRow(at: location)
        let word = sections[indexPath!.section].words[indexPath!.row]
              
       
               word.favourited = !word.favourited
                  
               wordController.updateWordFavourited(title: word.title, favourited: word.favourited)
                      
        tableView.reloadRows(at: [indexPath!], with: .automatic)
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = sections[indexPath.section].words[indexPath.row]
       
/*
        word.favourited = !word.favourited
           
        wordController.updateWordFavourited(title: word.title, favourited: word.favourited)
               
       tableView.reloadRows(at: [indexPath], with: .automatic)*/
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.beginUpdates()
        for i in 0 ..< sections[section].words.count{
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    // --------------------- DB Functions ------------------------------//
    
    func filterByCategory(category: String){
        wordList.removeAll()
        sections.removeAll()
        
        var allWords = [NSManagedObject]()
        
        if(category == "All"){
            allWords = wordController.getAllWordsDateSort()!
        }
        else{
            allWords =  wordController.getWordsByCategory(category: category)!
        }
        
        formatWordList(allWords: allWords)
        dayCount = 0
//        getSection()
        
    }
    
    func fetchAllWords(){
     let allWords = (wordController.getAllWordsDateSort() ?? nil)!
        if (allWords != nil){
           formatWordList(allWords: allWords)
         }
     else {
     print("not successful")
        }
    }
    
    public func formatWordList(allWords: [NSManagedObject]){
        for word in allWords{
            var StringId = word.objectID.uriRepresentation().absoluteString
            guard let Id = Int(String(StringId.last!)) else { return  }
                    let title = word.value(forKey: "title") as! String
                    let wordType = word.value(forKey: "wordType") as! String
                    let definition = word.value(forKey: "definition") as! String
                     let sentence = word.value(forKey: "sentence") as! String
                    let category = word.value(forKey: "category") as! String
                   // let date = word.value(forKey: "date") as! Date
            let favourited = word.value(forKey: "favourited") as! Bool
                    
            let newWord = Word( title: title, wordType: wordType , definition: definition
                ,sentence: sentence, category: category, favourited: favourited, added: false, learned: false)
                    wordList.append(newWord)
                }
    }

    
        @IBAction func addWord(_ sender: UIButton) {
            
            let title = txtWordTitle.text!
            let type = txtWordType.text!
            let definition = txtWordDefinition.text!
            let sentence = txtWordSentence.text!
            let category = txtWordCategory.text!
           // var calendar = Calendar.current
           // calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
            //let today = calendar.startOfDay(for: Date().localDate())
           //let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
           // print(yesterday)
            
            
            let newWord = Word(title: title, wordType: type , definition: definition
                ,sentence: sentence, category: category, favourited: false, added: false,learned: false)
            
            if newWord != nil{
               wordController.insertWord(newWord: newWord)
                      }else{
                          print("Word creation unsuccessful")
                      }
     
    }

}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}

