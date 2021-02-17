//
//  ViewController.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-21.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout{  //UITableViewDelegate, UITableViewDataSource{
    
    //@IBOutlet weak var tableView: UITableView!
 
    @IBOutlet var popupView: UIView!
   // @IBOutlet var blurView: UIVisualEffectView!
    
   // @IBOutlet weak var collectionView: UICollectionView!
    
    let wordController = WordController()
    let dbWordController = DbWordController()
    let dbListController = DbListController()
     private var wordList = [Word]()
    private var discoverList = [Discover]()
    
    private var mixList = [Discover]()
    private var emotionList = [Discover]()
    private var expressionList = [Discover]()
    private var businessList = [Discover]()
    private var educationList = [Discover]()
    private var healthList = [Discover]()
    
    private var defaultLists = [ListEntity]()
    
    var categoryList = [Category]()
    var selectedCategory : String = "Mix"

    let isPhone = UIDevice.isPhone
    
    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
  
    private let model = ["All", "Emotion", "Casual", "Business","Science", "Expression"]
       
       private let color = [UIColor.gray, UIColor.blue, UIColor.red]

       let group = DispatchGroup()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
        //let cv = UICollectionView(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.size.width * UIScreen.main.scale * 0.8, height: UIScreen.main.bounds.size.height * UIScreen.main.scale * 0.6), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.register(DiscoverCell.self, forCellWithReuseIdentifier:"DiscoverCell" )
        return cv
    }()
    
    lazy var categoryCollection: UICollectionView = {
               let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
               let cv = UICollectionView(frame:.zero,collectionViewLayout: layout)
               cv.translatesAutoresizingMaskIntoConstraints = false
               cv.delegate = self
               cv.dataSource = self
               cv.backgroundColor = .clear
        cv.isScrollEnabled = false
                cv.register(MainCategoryCell.self, forCellWithReuseIdentifier:"MainCategoryCell" )
               return cv
           }()
    
    let categoryLbL: UILabel = {
                  let label = UILabel()
                  label.translatesAutoresizingMaskIntoConstraints = false
                  label.textAlignment = .left
                  label.minimumScaleFactor = 0.1
                   label.adjustsFontSizeToFitWidth = true
                   label.numberOfLines = 1
                label.text = "Category"
                 
        label.textColor = .lightGray
                  return label
       }()
    
    let discoverLbL: UILabel = {
                  let label = UILabel()
                  label.translatesAutoresizingMaskIntoConstraints = false
                  label.textAlignment = .left
                  label.minimumScaleFactor = 0.1
                   label.adjustsFontSizeToFitWidth = true
                   label.numberOfLines = 1
                label.text = "Discover"
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
            label.text = "Find new words"
             label.textColor = .lightGray
              return label
    }()
    
    let todayLbL: UILabel = {
                     let label = UILabel()
                     label.translatesAutoresizingMaskIntoConstraints = false
                     label.textAlignment = .left
                     label.minimumScaleFactor = 0.1
                      label.adjustsFontSizeToFitWidth = true
                      label.numberOfLines = 1
                   label.text = "Today"
                    
              label.textColor = .lightGray
                     return label
          }()
    
    
       let buttonLbL: UILabel = {
                     let label = UILabel()
                     label.translatesAutoresizingMaskIntoConstraints = false
                     label.textAlignment = .left
                     label.minimumScaleFactor = 0.1
                     label.adjustsFontSizeToFitWidth = true
                      label.numberOfLines = 1
                   label.text = "Shuffle"
                    
              label.textColor = .white
                     return label
          }()
    
   let premiumBtn: UIButton = {
           let btn = UIButton.init(type: .system)
               btn.translatesAutoresizingMaskIntoConstraints = false
    let img = UIImage(named: "shuffle")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(img, for: .normal)
    btn.tintColor = .white
        btn.isUserInteractionEnabled = false
              return btn
          }()
    
    let addBtn: UIButton = {
           let btn = UIButton.init(type: .system)
              btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "plusicon")?.withRenderingMode(.alwaysTemplate)
        img?.withTintColor(.white)
        btn.setImage(img, for: .normal)
        
    
          // btn.setTitle("Add Word", for: .normal)
          // myFirstButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
          btn.layer.borderWidth = 2
        
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.link.cgColor
        btn.layer.backgroundColor = UIColor.white.cgColor
       // btn.titleLabel?.minimumScaleFactor = 0.1
       // btn.titleLabel?.adjustsFontSizeToFitWidth = true
       // btn.titleLabel?.numberOfLines = 1
       // btn.setTitleColor(UIColor.white, for: .normal)
          btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
              return btn
    }()
    
    let shuffleIcon: UIButton = {
              let btn = UIButton.init(type: .system)
                 btn.translatesAutoresizingMaskIntoConstraints = false
           let img = UIImage(named: "shuffle")?.withRenderingMode(.alwaysTemplate)
           img?.withTintColor(.white)
           btn.setImage(img, for: .normal)
             btn.layer.borderWidth = 2
           btn.clipsToBounds = true
           btn.layer.borderColor = UIColor.link.cgColor
           btn.layer.backgroundColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(shuffleTapped), for: .touchUpInside)
            // btn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
                 return btn
        }()
    
    let shuffleBtn: UIButton = {
       let btn = UIButton.init(type: .system)
          btn.translatesAutoresizingMaskIntoConstraints = false
       btn.setTitle("Shuffle", for: .normal)
      // myFirstButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
    //  btn.layer.borderWidth = 2
    btn.layer.cornerRadius = 20
   // btn.layer.borderColor = UIColor.link.cgColor
       btn.layer.backgroundColor = UIColor.purple.cgColor
    btn.titleLabel?.minimumScaleFactor = 0.1
    btn.titleLabel?.adjustsFontSizeToFitWidth = true
    btn.titleLabel?.numberOfLines = 1
    btn.setTitleColor(UIColor.white, for: .normal)
      btn.addTarget(self, action: #selector(shuffleTapped), for: .touchUpInside)
          return btn
      }()
    
    let premiumView : UIView = {
        let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightBlue.cgColor
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
         let teal = UIColor(red: 67/255.0, green: 195/255.0, blue: 206/255.0, alpha: 0.8)
        view.backgroundColor = teal.withAlphaComponent(0.4)
        //let tap = UITapGestureRecognizer(target:self, action: #selector(premiumTapped(_:)))
        //view.addGestureRecognizer(tap)
        return view
    }()
    
    let bottomView : UIView = {
           let view = UIView()
               view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.teal.withAlphaComponent(0.4)
          // view.layer.borderWidth = 2
           //view.layer.borderColor = UIColor.link.cgColor
          // view.layer.cornerRadius = 10
           view.isUserInteractionEnabled = true
           return view
       }()
    
    let topView : UIView = {
            let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
         
        view.backgroundColor = .white//UIColor.teal.withAlphaComponent(0.4)
           // view.layer.borderWidth = 2
            //view.layer.borderColor = UIColor.link.cgColor
           // view.layer.cornerRadius = 10
            view.isUserInteractionEnabled = true
            return view
    }()
    let underlineView : UIView = {
          let view = UIView()
          view.translatesAutoresizingMaskIntoConstraints = false
          view.backgroundColor = .lightGrey
          return view
      }()

     let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
 
    private let errorMessage = UILabel()
    
    @IBOutlet weak var txtWordTitle: UITextField!
    @IBOutlet weak var txtWordType: UITextField!
    @IBOutlet weak var txtWordCategory: UITextField!

    @IBOutlet weak var txtWordSentence: UITextView!
    @IBOutlet weak var txtWordDefinition: UITextView!
    
    @IBOutlet weak var btnModal: UIButton!
    
  /* let segmentedControl: UISegmentedControl = {
            let sc = UISegmentedControl(items: ["Mix", "Emotion", "Casual", "Expression"])
            sc.selectedSegmentIndex = 0
      sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
            return sc
        }()
    */
   

        let mixImage = UIImage(named: "headerBg1")!
      let mixColor = UIColor(red: 201/255.0, green:255/255.0, blue: 191/255.0, alpha:0.1)
     
        let emotionImage = UIImage(named: "emotionBg")!
        let emotionColor = UIColor(red: 238/255.0, green:205/255.0, blue: 163/255.0, alpha:0.8)
     
            let casualImage = UIImage(named: "casualBg")!
          let casualColor = UIColor(red: 63/255.0, green:71/255.0, blue: 80/255.0, alpha:0.8)
    
        let expressionImage = UIImage(named: "background")!
         let expressionColor = UIColor(red: 63/255.0, green:71/255.0, blue: 80/255.0, alpha:0.8)
    
    var today = Date()
    var i : Int = 0
    
    let cellScale: CGFloat = 0.8

    var count = 0
    func makeDefaultLists(){
        if count == 0 {
        defaultLists.append(ListEntity(name: "Anger", custom: false, category: "Emotion")!)
        defaultLists.append(ListEntity(name: "Sad", custom: false, category: "Emotion")!)
        defaultLists.append(ListEntity(name: "Happy", custom: false, category: "Emotion")!)
        defaultLists.append(ListEntity(name: "Fear", custom: false, category: "Emotion")!)
        defaultLists.append(ListEntity(name: "Love", custom: false, category: "Emotion")!)
        defaultLists.append(ListEntity(name: "Excitement", custom: false, category: "Emotion")!)
            
        defaultLists.append(ListEntity(name: "Profession", custom: false, category: "Business")!)
        defaultLists.append(ListEntity(name: "Enterprise", custom: false, category: "Business")!)
        defaultLists.append(ListEntity(name: "Financial", custom: false, category: "Business")!)
        defaultLists.append(ListEntity(name: "Marketing", custom: false, category: "Business")!)
        
        defaultLists.append(ListEntity(name: "Compliments", custom: false, category: "Expression")!)
        defaultLists.append(ListEntity(name: "Criticism", custom: false, category: "Expression")!)
        defaultLists.append(ListEntity(name: "Personality", custom: false, category: "Expression")!)
        defaultLists.append(ListEntity(name: "Description", custom: false, category: "Expression")!)
        
        defaultLists.append(ListEntity(name: "Mental", custom: false, category: "Health")!)
        defaultLists.append(ListEntity(name: "Physical", custom: false, category: "Health")!)
       // defaultLists.append(ListEntity(name: "Environment", custom: false, category: "Health")!)
        //defaultLists.append(ListEntity(name: "Politics", custom: false, category: "Health")!)
            
        defaultLists.append(ListEntity(name: "Biology", custom: false, category: "Education")!)
        defaultLists.append(ListEntity(name: "Chemistry", custom: false, category: "Education")!)
        defaultLists.append(ListEntity(name: "Mathematics", custom: false, category: "Education")!)
        defaultLists.append(ListEntity(name: "Engineering", custom: false, category: "Education")!)
            
        dbListController.insertLists(newLists: defaultLists)
            count += 1
        }
    }
    
    func insertWordsDefaultList(){
        dbListController.insertWordsDefaultLists()
    }
    
        @objc func premiumTapped(_ sender: UITapGestureRecognizer? = nil){
            switch selectedCategory {
            case "Emotion":
                fetchWordsByCategory(category: "Emotion", image: emotionImage, color: .lightRed)
            case "Expression":
                fetchWordsByCategory(category: "Expression", image: casualImage, color: .teal)
            case "Business":
                fetchWordsByCategory(category: "Business", image: casualImage, color: .lightOrange )
            case "Education":
                fetchWordsByCategory(category: "Education", image: casualImage, color: .lightPurple)
            case "Health":
                fetchWordsByCategory(category: "Health", image: casualImage, color: .lightGreen)
            default:
                fetchWordsByCategory(category: "", image: mixImage, color: .lightPink)
            }
            collectionView.reloadData()
           /* let mainSB = UIStoryboard(name:"Main", bundle:nil)
            let premiumView = mainSB.instantiateViewController(identifier: "PremiumView") as! PremiumView
            premiumView.modalPresentationStyle = .fullScreen
            present(premiumView, animated: true, completion: nil)*/
    }
    @objc func addTapped(sender: UIButton){
         print("add")
        let pop = Popup()
        view.addSubview(pop)
       }
    
    @objc func addedTapped(sender: UIButton){
        let index = sender.tag
      let wordTitle = discoverList[index].title

        let word = dbWordController.getWordByTitle(title: wordTitle)
                let mainSB = UIStoryboard(name:"Main", bundle:nil)
                let pickListView = mainSB.instantiateViewController(identifier: "PickListView") as! PickListView
                 pickListView.word = word
        pickListView.modalPresentationStyle = .overFullScreen
       // pickListView.modalTransitionStyle = .coverVertical
        present(pickListView, animated: false, completion: nil)
                           //self.navigationController?.pushViewController(pickListView, animated: true)
     }
    
    func getWordByTitle(title: String) -> NSManagedObject?{
         
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
             return nil
         }
    var existingWord: NSManagedObject!
         
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
         //bad: quit fetch when found, not go through all records
         fetchRequest.predicate = NSPredicate(format: "title = %@", title)
         
         do{
             let result = try managedContext.fetch(fetchRequest)
             
            existingWord = result[0] as? NSManagedObject
            

         }catch{
             print("Word update unsuccessful")
         }
         return existingWord
     }
    
    @objc func shuffleTapped(sender: UIButton){
        print("shuufletap")
                       let mainSB = UIStoryboard(name:"Main", bundle:nil)
                       let listView = mainSB.instantiateViewController(identifier: "PickListView") as! PickListView
                              // listView.modalPresentationStyle = .fullScreen
                       //present(listView, animated: true, completion: nil)
                       self.navigationController?.pushViewController(listView, animated: true)
   }
    var counts = 0
    /*override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                    hideNavigationBar(animated: animated)
         }*/
      override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .veryLightGray//UIColor.teal.withAlphaComponent(1)//.lightGrey
           
           self.hideKeyboardWhenTappedAround()
           let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp))
           swipeUp.direction = .up
           collectionView.addGestureRecognizer(swipeUp)
           view.addSubview(premiumBtn)
           view.addSubview(discoverLbL)
           view.addSubview(categoryLbL)
           view.addSubview(categoryCollection)
           view.addSubview(premiumView)
           view.addSubview(bottomView)
           view.addSubview(topView)
           topView.addSubview(discoverLbL)
           topView.addSubview(premiumView)
           view.bringSubviewToFront(topView)
           premiumView.addSubview(premiumBtn)
           premiumView.addSubview(buttonLbL)
           if isPhone{
           }
           setUpCategory()

           let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
             
           let cellWidth = floor(screenSize.width * cellScale)
           let cellHeight = floor(screenSize.height * cellScale)
  
           view.addSubview(collectionView)
           self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
          
        // getWords()
        //makeDefaultLists()
          // insertWordsDefaultList()
           /*setupModalTexts()
           txtWordTitle.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
           txtWordCategory.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)*/
           popupView.layer.cornerRadius = 24
           popupView.backgroundColor = .white
           blurView.frame = self.view.bounds
           blurView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
           popupView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor).isActive = true
           popupView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor).isActive = true
          
           collectionView.dataSource = self
           collectionView.delegate = self
      
           var calendar = Calendar.current
           calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
          today = calendar.startOfDay(for: Date().localDate())
         // let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)
           setNavigationBar()
       }
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
        if Core.shared.isNewUSer(){
            getWords()
            makeDefaultLists()
            let introductionView = storyboard?.instantiateViewController(withIdentifier: "IntroductionViews") as! IntroductionViews
            introductionView.modalPresentationStyle = .fullScreen
            present(introductionView, animated: false)
        }
        fetchWords()
        handleCategoryChange(category: "Mix")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        
        let tap = UITapGestureRecognizer(target:self, action: #selector(premiumTapped(_:)))
        premiumView.addGestureRecognizer(tap)
        
        if (isPhone){
        
        //discoverLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/27)
        discoverLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/22)
      //  titleDescLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/45)
        categoryLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/30)
       // todayLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/30)
       // addBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/50)
         shuffleBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/50)
        buttonLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/47)

        //shuffleBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/55).isActive = true

       // premiumBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/55).isActive = true

       // premiumBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
       // premiumBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
       // premiumBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(safeArea.layoutFrame.height/50)).isActive = true
        //premiumBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        //premiumBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: premiumBtn.frame.width-(premiumBtn.frame.width/2))
        
        //premiumBtn.addSubview(buttonLbL)
        //buttonLbL.centerYAnchor.constraint(equalTo:premiumBtn.centerYAnchor).isActive = true
       // buttonLbL.trailingAnchor.constraint(equalTo: premiumBtn.trailingAnchor, constant: -safeArea.layoutFrame.width/20).isActive = true
    
        discoverLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/30).isActive = true
        discoverLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeAreaHeight/40)).isActive = true
       // titleDescLbL.topAnchor.constraint(equalTo: discoverLbL.bottomAnchor).isActive = true
        //titleDescLbL.leadingAnchor.constraint(equalTo: discoverLbL.leadingAnchor).isActive = true
            
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //topView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.15).isActive=true
        topView.bottomAnchor.constraint(equalTo: discoverLbL.bottomAnchor, constant: safeAreaHeight/50).isActive = true
        topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
            //topView.addShadow()
       // underlineView.widthAnchor.constraint(equalTo:safeArea.widthAnchor).isActive=true
        //underlineView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
       // underlineView.heightAnchor.constraint(equalToConstant: safeAreaHeight/150).isActive=true
                 
            
        premiumView.bottomAnchor.constraint(equalTo: discoverLbL.bottomAnchor).isActive = true
        premiumView.centerYAnchor.constraint(equalTo: discoverLbL.centerYAnchor).isActive = true
        premiumView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
        premiumView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.30).isActive=true
        premiumView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(safeArea.layoutFrame.height/50)).isActive = true
            
        //premiumBtn.topAnchor.constraint(equalTo: premiumView.topAnchor).isActive = true
        premiumBtn.heightAnchor.constraint(equalTo: premiumView.widthAnchor,  multiplier:0.25).isActive=true
        premiumBtn.widthAnchor.constraint(equalTo: premiumView.widthAnchor,  multiplier:0.25).isActive=true
        premiumBtn.leadingAnchor.constraint(equalTo: premiumView.leadingAnchor,constant: safeArea.layoutFrame.height/70).isActive = true
        premiumBtn.centerYAnchor.constraint(equalTo: premiumView.centerYAnchor).isActive=true
   
        buttonLbL.topAnchor.constraint(equalTo: premiumView.topAnchor).isActive = true
        buttonLbL.leadingAnchor.constraint(equalTo: premiumBtn.trailingAnchor, constant: safeArea.layoutFrame.height/70).isActive = true
        buttonLbL.centerYAnchor.constraint(equalTo: premiumView.centerYAnchor).isActive = true
        buttonLbL.trailingAnchor.constraint(equalTo: premiumView.trailingAnchor, constant: -safeArea.layoutFrame.height/70).isActive = true

       /* topView.addSubview(shuffleBtn)
        shuffleBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/55).isActive = true

          shuffleBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
          shuffleBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.2).isActive=true
           shuffleBtn.trailingAnchor.constraint(equalTo: premiumView.leadingAnchor, constant: -(safeArea.layoutFrame.height/50)).isActive = true
       
        */
       // todayLbL.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeArea.layoutFrame.height/45).isActive = true
               // todayLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeArea.layoutFrame.height/50)).isActive = true
               
               //collectionView.addShadow()
      
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeArea.layoutFrame.height/40).isActive = true
        collectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.44).isActive=true
        collectionView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.94).isActive=true
        collectionView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
      //  collectionView.addShadow()
        
        //shuffleIcon.centerYAnchor.constraint(equalTo: collectionView.topAnchor,constant: safeArea.layoutFrame.height/55).isActive = true
        // shuffleIcon.centerXAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: safeArea.layoutFrame.height/55).isActive = true
     //   shuffleIcon.layer.cornerRadius = 0.5 * shuffleIcon.bounds.size.width
    
       /* shuffleIcon.imageEdgeInsets = UIEdgeInsets(
                   top: shuffleIcon.frame.size.height/3,
                   left: shuffleIcon.frame.size.width/3,
                   bottom: shuffleIcon.frame.size.height/3,
                   right: shuffleIcon.frame.size.width/3)*/
             
                   // addBtn.centerYAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true

        //shuffleIcon.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive=true
        //shuffleIcon.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive=true
        //shuffleIcon.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
      //  shuffleIcon.backgroundColor = .white
       // view.bringSubviewToFront(shuffleIcon)
      //  bottomView.addCorner()
     //  bottomView.addShadow()
       
      //  bottomView.backgroundColor = .veryLightGray
      
            bottomView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: safeArea.layoutFrame.height/35).isActive = true//).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeArea.layoutFrame.height/35).isActive = true
        //bottomView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.35).isActive=true
        bottomView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.94).isActive=true
        bottomView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
           
        
        bottomView.addSubview(categoryLbL)
        categoryLbL.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: safeArea.layoutFrame.height/60).isActive = true
        categoryLbL.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: (safeArea.layoutFrame.height/50)).isActive = true
        
        bottomView.addSubview(categoryCollection)
        //categoryCollection.addShadow()
        categoryCollection.topAnchor.constraint(equalTo: categoryLbL.bottomAnchor, constant: safeArea.layoutFrame.height/45).isActive = true
        categoryCollection.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -safeArea.layoutFrame.height/45).isActive = true
        //categoryCollection.heightAnchor.constraint(equalTo: bottomView.heightAnchor,  multiplier:0.6).isActive=true
         categoryCollection.widthAnchor.constraint(equalTo: bottomView.widthAnchor,  multiplier:0.8).isActive=true
        
       // categoryCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeArea.layoutFrame.height/50)).isActive = true
         categoryCollection.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
  

             /*  addBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive=true
               addBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.12).isActive=true
               addBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        addBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        view.bringSubviewToFront(addBtn)*/

        }
        else{
            discoverLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/30)
            categoryLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/33)
             shuffleBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/50)
            buttonLbL.font = UIFont(name: "Helvetica-Bold", size: safeArea.layoutFrame.height/50)
            //shuffleBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/55).isActive = true
            
            topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            topView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.11).isActive=true
            topView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
            topView.addSubview(premiumView)
            
            premiumView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/55).isActive = true
            premiumView.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.06).isActive=true
            premiumView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.28).isActive=true
            premiumView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(safeArea.layoutFrame.height/50)).isActive = true
            
            premiumView.addSubview(premiumBtn)
            premiumBtn.topAnchor.constraint(equalTo: premiumView.topAnchor).isActive = true
            premiumBtn.heightAnchor.constraint(equalTo: premiumView.widthAnchor,  multiplier:0.20).isActive=true
            premiumBtn.widthAnchor.constraint(equalTo: premiumView.widthAnchor,  multiplier:0.20).isActive=true
            premiumBtn.leadingAnchor.constraint(equalTo: premiumView.leadingAnchor,constant: safeArea.layoutFrame.height/70).isActive = true
       
            premiumView.addSubview(buttonLbL)
            buttonLbL.topAnchor.constraint(equalTo: premiumView.topAnchor).isActive = true
            buttonLbL.leadingAnchor.constraint(equalTo: premiumBtn.trailingAnchor, constant: safeArea.layoutFrame.height/70).isActive = true
             buttonLbL.centerYAnchor.constraint(equalTo: premiumView.centerYAnchor).isActive = true
            buttonLbL.trailingAnchor.constraint(equalTo: premiumView.trailingAnchor, constant: -safeArea.layoutFrame.height/70).isActive = true
            
            topView.addSubview(discoverLbL)
            discoverLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/40).isActive = true
             discoverLbL.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: (safeArea.layoutFrame.height/25)).isActive = true
            
            topView.addSubview(shuffleBtn)
            shuffleBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeArea.layoutFrame.height/55).isActive = true
            shuffleBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.06).isActive=true
            shuffleBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.2).isActive=true
            shuffleBtn.trailingAnchor.constraint(equalTo: premiumView.leadingAnchor, constant: -(safeArea.layoutFrame.height/45)).isActive = true
            
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: safeArea.layoutFrame.height/40).isActive = true
            collectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.45).isActive=true
            collectionView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.94).isActive=true
            collectionView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            
           
 //---------           collectionView.addShadow()
           // shuffleIcon.centerYAnchor.constraint(equalTo: collectionView.topAnchor,constant: safeArea.layoutFrame.height/55).isActive = true
           // shuffleIcon.centerXAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: safeArea.layoutFrame.height/55).isActive = true
 //-----            shuffleIcon.layer.cornerRadius = 0.5 * shuffleIcon.bounds.size.width
                   /*shuffleIcon.imageEdgeInsets = UIEdgeInsets(
                              top: shuffleIcon.frame.size.height/3,
                              left: shuffleIcon.frame.size.width/3,
                              bottom: shuffleIcon.frame.size.height/3,
                              right: shuffleIcon.frame.size.width/3)
                        */
           // shuffleIcon.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
           // shuffleIcon.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
//---            shuffleIcon.backgroundColor = .white
           // view.bringSubviewToFront(shuffleIcon)
 //--                  bottomView.addCorner()
 //--                 bottomView.addShadow()
                  
 //--                  bottomView.backgroundColor = .veryLightGray
                 
            bottomView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: safeArea.layoutFrame.height/35).isActive = true//).isActive = true
            bottomView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeArea.layoutFrame.height/25).isActive = true
            //bottomView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:0.35).isActive=true
            bottomView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.94).isActive=true
            bottomView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    
            bottomView.addSubview(categoryLbL)
            categoryLbL.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: safeArea.layoutFrame.height/60).isActive = true
            categoryLbL.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: (safeArea.layoutFrame.height/50)).isActive = true
            
            bottomView.addSubview(categoryCollection)
//---- categoryCollection.addShadow()
            categoryCollection.topAnchor.constraint(equalTo: categoryLbL.bottomAnchor).isActive = true //constant: safeArea.layoutFrame.height/40).isActive = true
            //categoryCollection.heightAnchor.constraint(equalTo: bottomView.heightAnchor,  multiplier:0.85).isActive=true
            categoryCollection.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true //constant: -safeArea.layoutFrame.height/60).isActive = true
            categoryCollection.widthAnchor.constraint(equalTo: bottomView.widthAnchor,  multiplier:0.65).isActive=true
            categoryCollection.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            
//--           addBtn.layer.cornerRadius = 0.5 * addBtn.bounds.size.width
                   
               /*  addBtn.imageEdgeInsets = UIEdgeInsets(
                         top: addBtn.frame.size.height/3,
                         left: addBtn.frame.size.width/3,
                         bottom: addBtn.frame.size.height/3,
                         right: addBtn.frame.size.width/3)*/
                   
            addBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
            addBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:0.10).isActive=true
            addBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            addBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            view.bringSubviewToFront(addBtn)
//--         addBtn.backgroundColor = .white
            
        }
        topView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        topView.addSlightShadow()
        collectionView.addShadow()
         bottomView.addCorner()
         bottomView.addShadow()
         bottomView.backgroundColor = .veryLightGray
      //  categoryCollection.backgroundColor = .lightGrey
       // categoryCollection.addShadow()
        
       /* addBtn.layer.cornerRadius = 0.5 * addBtn.bounds.size.width
            
        addBtn.imageEdgeInsets = UIEdgeInsets(
                  top: addBtn.frame.size.height/3,
                  left: addBtn.frame.size.width/3,
                  bottom: addBtn.frame.size.height/3,
                  right: addBtn.frame.size.width/3)
        addBtn.backgroundColor = .white*/
        
    }
    
    @objc func handleSwipeUp(swipeGestureRecognizer: UISwipeGestureRecognizer){
        
       let touchPoint = swipeGestureRecognizer.location(in: self.collectionView)
       if let indexPath = collectionView.indexPathForItem(at: touchPoint){
        
        let selectedWord = discoverList[indexPath.row].title
     
              // dbWordController.deleteWord(title: selectedWord)
            discoverList.remove(at: indexPath.row)
       deleteFromList(category: selectedCategory, index: indexPath.row)
  
        UIView.transition(with: collectionView, duration: 1.0, options: .transitionCrossDissolve, animations: {self.collectionView.reloadData()}, completion: nil)
               
       }
        
    }
    
    func deleteCasual(){
        wordController.deleteAll()
    }
    func deleteFromList(category: String, index: Int){
        switch category{
            case "Health":
            healthList.remove(at: index)
            let newWord = fetchReplacingWord(category: "Health", image: mixImage, color: .lightGreen)
            healthList.insert(newWord, at: index)
            discoverList = healthList
           case "Emotion":
            emotionList.remove(at: index)
            let newWord = fetchReplacingWord(category: "Emotion", image: emotionImage, color: .lightRed)
            emotionList.insert(newWord, at: index)
              discoverList = emotionList
           case "Education":
            educationList.remove(at: index)
            let newWord = fetchReplacingWord(category: "Education", image: casualImage, color: .lightPurple)
            educationList.insert(newWord, at: index)
            discoverList = educationList
            
            case "Business":
               businessList.remove(at: index)
               let newWord = fetchReplacingWord(category: "Business", image: mixImage, color: .lightOrange)
                     businessList.insert(newWord, at: index)
                     discoverList = businessList
            case "Expression":
              expressionList.remove(at: index)
              let newWord = fetchReplacingWord(category: "Expression", image: mixImage, color: .teal)
                     expressionList.insert(newWord, at: index)
                     discoverList = expressionList
            default:
               mixList.remove(at: index)
               let newWord = fetchReplacingWord(category: "", image: mixImage, color: .lightPink)
                mixList.insert(newWord, at: index)
                     discoverList = mixList
        }
        
    }
    
  /*  @objc fileprivate func handleSegmentChange(){
          discoverList.removeAll()
          switch segmentedControl.selectedSegmentIndex {
          case 0:
             discoverList = mixList
             collectionView.reloadData()
          case 1:
            discoverList = emotionList
              collectionView.reloadData()
          case 2:
            discoverList = casualList
              collectionView.reloadData()
          default:
            discoverList = mixList
            collectionView.reloadData()
          }
      }*/
    func setupModalTexts(){
        // setup
           btnModal.isEnabled = false
           btnModal.setTitle("Add", for: .normal)
           txtWordDefinition.layer.borderWidth=1.0
           txtWordSentence.layer.borderWidth = 1.0
           txtWordDefinition.layer.borderColor = UIColor.lightGray.cgColor
           txtWordDefinition.layer.cornerRadius = 5
           txtWordSentence.layer.borderColor = UIColor.lightGray.cgColor
           txtWordSentence.layer.cornerRadius = 5
    }
 
    func setNavigationBar(){
        let image = UIImage(named: "TitleImage")
   
               let imageView = UIImageView(image: image)
               imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
               imageView.contentMode = .scaleAspectFit
               navigationItem.titleView = imageView
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
      //  self.navigationItem.leftBarButtonItem = addButton
        
      /*  let followButton = UIButton(type: .system)
        let followImage = UIImage(named: "follow")
       followButton.setImage(followImage, for: .normal)
       /* let width = navigationController?.navigationBar.frame.size.width
           let height = navigationController?.navigationBar.frame.size.height
         let bannerX = width!/2 - followImage!.size.width/2
         let bannerY = height!/2 - followImage!.size.height/2
        followButton.frame = CGRect(x: bannerX, y: bannerY, width: width!, height: height!)*/
        followButton.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)*/
        
    }
    

 /*  func animatedIn(desiredView: UIView){
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView)
        
        desiredView.center = backgroundView.center
      
        desiredView.transform = CGAffineTransform(translationX: 0, y: -desiredView.frame.height)
               desiredView.alpha = 0
               UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
                   desiredView.transform = .identity
                   desiredView.alpha = 1
                   
               })
    }
  @objc func animateOutCall(){
        animateOut (desiredView: popupView)
        animateOut(desiredView: blurView)
    }
    func animateOut (desiredView: UIView){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,animations: {
            desiredView.transform = CGAffineTransform(translationX: 0, y: -desiredView.frame.height)
                   desiredView.alpha = 0
               }
               ){(complete) in
                   if complete {
                       desiredView.removeFromSuperview()
                   }
                   
               }
    }*/

  //  @objc func addTapped(){
       // animatedIn(desiredView: blurView)
       // animatedIn(desiredView: popupView)
     //  let addModal = AddModal()
      //  let pop = Popup()
       // view.addSubview(pop)
       
      // }
    
   /* @IBAction func modalBtn(_ sender: Any) {
       /* if txtWordTitle.text!.isEmpty || txtWordCategory.text!.isEmpty {
            btnModal.isEnabled = false
            } else {
                btnModal.isEnabled = true
            }*/

        
        let newWord = Word(Id: 0, title: txtWordTitle.text!, wordType: txtWordType.text!, definition: txtWordDefinition.text!, sentence: txtWordSentence.text!, category: txtWordCategory.text! , date: self.today, favourited: false, added: true, learned: false)
        
       let count = wordController.checkDuplicate(title: txtWordTitle.text!)
        
        if count > 0 {
          showAlert(successful: false)
        }else{
             wordController.insertWord(newWord: newWord)
            showAlert(successful: true)
        }
        
       
        animateOut(desiredView: popupView)
        animateOut(desiredView: blurView)
         }
    
    func showAlert(successful:Bool){
        var title = ""
        var message = ""
        if successful{
           title = "Successful"
           message = "Word was successfully added to the database"
        }else{
        title = "Word already exists"
        message = "Please try adding with another word"
        }
        
        let addAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        addAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
         self.present(addAlert, animated: true, completion: nil)
    }*/
    
    func setUpCategory(){
       
           let allColor = UIColor(red: 255/255.0, green:153/255.0, blue: 102/255.0, alpha:0.9)
           let allBgColor = UIColor(red: 255/255.0, green:94/255.0, blue: 98/255.0, alpha:0.9)
                  
           let favouriteColor = UIColor(red: 220/255.0, green:36/255.0, blue: 48/255.0, alpha:0.3)
         
           let favouriteBgColor = UIColor(red: 123/255.0, green:67/255.0, blue: 151/255.0, alpha:0.3)
           
           let addedColor = UIColor(red: 67/255.0, green:206/255.0, blue: 162/255.0, alpha:0.9)
            let addedBgColor = UIColor(red: 24/255.0, green:90/255.0, blue: 157/255.0, alpha:0.3)
           let learnedColor = UIColor(red: 97/255.0, green:67/255.0, blue: 133/255.0, alpha:0.9)
                  
             let learnedeBgColor = UIColor(red: 81/255.0, green:99/255.0, blue: 149/255.0, alpha:0.3)
    
        categoryList.append(Category(title: "Mix", image: UIImage(named: "mixicon2")!, color: .lightPink, bgColor: allBgColor))
        categoryList.append(Category(title: "Expression", image: UIImage(named: "expressionicon")!, color: .teal,bgColor: favouriteBgColor))
        categoryList.append(Category(title: "Emotion", image: UIImage(named: "emotionicon")!, color: .lightRed,bgColor: addedBgColor))
        categoryList.append(Category(title: "Business", image: UIImage(named: "businessicon")!, color: .lightOrange,bgColor: learnedeBgColor))
        categoryList.append(Category(title: "Education", image: UIImage(named: "educationicon")!, color: .lightPurple,bgColor: learnedeBgColor))
        categoryList.append(Category(title: "Health", image: UIImage(named: "healthicon")!, color: .lightGreen,bgColor: learnedeBgColor))
       }
    
    func handleCategoryChange(category: String){
          selectedCategory = category
           switch category {
                 case "Emotion":
                 // categoryColor = UIColor(red: 97/255.0, green:67/255.0, blue: 133/255.0, alpha:0.8)
                  discoverList = emotionList
                  collectionView.reloadData()
                 case "Expression":
                  discoverList = expressionList
                     collectionView.reloadData()
                 case "Education":
                     discoverList = educationList
                     collectionView.reloadData()
                case "Business":
                     discoverList = businessList
                     collectionView.reloadData()
                case "Health":
                     discoverList = healthList
                    collectionView.reloadData()
            
                 default:
                 discoverList = mixList
                collectionView.reloadData()
          }
        //selectedCategory = category
       //   tableView.layer.borderColor = categoryColor.cgColor
         // tableView.backgroundColor = categoryColor
      }
    
    //--------------CollectionView FUNCTIONS-----------------//
     func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return discoverList.count
        }else{
            return categoryList.count
        }
       }
    
    //column margin - height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               if collectionView == self.collectionView{
                          return 10
                      }else{
                          return safeArea.layoutFrame.height/70
                }
   }
    
    //row margin - width
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if isPhone {
            if collectionView == self.collectionView{
                     return 10
            }else{
              return safeArea.layoutFrame.width/20
            }
        }else{
            if collectionView == self.collectionView{
                  return 10
            }else{
                  return safeArea.layoutFrame.width/8
           }
        }
    }
           
    
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionView{
                 return UIEdgeInsets(top: 0, left:0 , bottom: 0, right: 0)
            }else{
               return UIEdgeInsets(top: 0, left:0 , bottom:safeArea.layoutFrame.width/10, right: 0)
            }
   }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            
            let discover = discoverList[indexPath.item]
            cell.layer.cornerRadius = 10
            cell.setDiscover(discover: discover, index: indexPath.row)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCell", for: indexPath) as! MainCategoryCell
             let category = categoryList[indexPath.row]
             cell.setList(category:category)
            
           // cell.title.text = category.title
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              var size = CGSize()
        if isPhone{
            if collectionView == self.collectionView {
                size = CGSize(width: safeArea.layoutFrame.width/1.23, height: collectionView.frame.height)
            }else{
                size = CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/2.2)
                
                // CGSize(width: safeArea.layoutFrame.width/5, height: safeArea.layoutFrame.width/5)
            }
        }else{
            if collectionView == self.collectionView {
                size = CGSize(width: safeArea.layoutFrame.width/1.23, height: collectionView.frame.height)
            }else{
                size = CGSize(width: safeArea.layoutFrame.width/9, height: safeArea.layoutFrame.width/9)
            }
        }
     return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            let wordTitle = discoverList[indexPath.row].title
            let word = dbWordController.getWordByTitle(title: wordTitle)
        let mainSB = UIStoryboard(name:"Main", bundle:nil)
              let wordDisplay = mainSB.instantiateViewController(identifier: "DisplayView") as! DisplayView
            wordDisplay.modalPresentationStyle = .fullScreen
           // wordDisplay.modalTransitionStyle = .crossDissolve
            
               wordDisplay.currentWord = word
            
            present(wordDisplay, animated: true, completion: nil)
            //self.navigationController?.pushViewController(wordDisplay, animated: false)
        }
        else{
            let category = categoryList[indexPath.row].title
            handleCategoryChange(category: category)
        }
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
    
    func snapToNearestCell(scrollView: UIScrollView) {
         let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
         if let indexPath = self.collectionView.indexPathForItem(at: CGPoint(x: middlePoint, y: 0)) {
              self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
         }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.snapToNearestCell(scrollView: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.snapToNearestCell(scrollView: scrollView)
    }

    
  /* func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
       // let pageWidth: CGFloat = layout.itemSize.width + layout.minimumLineSpacing
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        let roundedIndex = round(index)

    print(roundedIndex)
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
      /*  let currentOffset = scrollView.contentOffset.x
          let targetOffset = CGFloat(targetContentOffset.pointee.x)
          var newTargetOffset:CGFloat = 0.0

          if targetOffset > currentOffset {
            newTargetOffset = CGFloat(ceilf(Float((CGFloat(Float(currentOffset)) / pageWidth) * pageWidth)))
          }
          else {
            newTargetOffset = CGFloat(floorf(Float((CGFloat(Float(currentOffset)) / pageWidth) * pageWidth)))
          }

          if newTargetOffset < 0.0 {
              newTargetOffset = 0.0
          }
          else if newTargetOffset > scrollView.contentSize.width {
              newTargetOffset = scrollView.contentSize.width
          }
          targetContentOffset.pointee = CGPoint(x: newTargetOffset, y: 0.0)*/
    }*/

    
    // --------------EXTERNAL API AND DATABASE FUNCTINOS-------------//

    
        func getWords(){
                //let apiString = "https://jobs.github.com/positions.json?search=node"
          guard let path = Bundle.main.path(forResource: "words", ofType: "json") else { return }
                
                let url = URL(fileURLWithPath: path)
                
             
                group.enter()
                
            let dataWord = URLSession.shared.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
                    
                   
                    //check if unsuccessful attempt to execute request
                    if let error = error{
                        print("Error : \(error)")
                    }else{
                        //successful execution of request
                        //get the data received from the request
                        if let jsonData = data{

                            if let jsonObj = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSArray{
                                
                                DispatchQueue.main.async {
                                for i in jsonObj{
                                    
                                        let title = (i as! NSObject).value(forKey: "title") as! String
                                        
                                    let type = (i as! NSObject).value(forKey: "wordType") as! String
                                    
                                    let definition = (i as! NSObject).value(forKey: "definition") as! String
                                    
                                    let sentence = (i as! NSObject).value(forKey: "sentence") as! String
                                    
                                    let category = (i as! NSObject).value(forKey: "category") as! String
                                    
                                    let newWord = Word(title: title, wordType: type, definition: definition, sentence: sentence, category: category , favourited: false, added: false, learned: false)
                                    
                                        self.wordList.append(newWord)
                                    }
                                    self.group.leave()
                                    }
                                }
                            }
                        }
                    }
                dataWord.resume()
                group.notify(queue: .main) {
                self.addWord(words: self.wordList)
               // let randomInt = Int.random(in: 1..<40)
            }
        }
        
    func addWord(words: [Word]){
        if words.count > 0{
           
             // group.enter()
             // DispatchQueue.main.async {
                self.wordController.insertWords(newWords: words)
               // self.group.leave()
                        //    }
            
          //  group.notify(queue: .main) {
            //    self.fetchTodaysWords()
            //}
            
        }
        else{
            print("Word creation unsuccessful")
        }
    }
    
    func fetchWords(){
        fetchWordsByCategory(category: "Emotion", image: emotionImage, color: .lightRed)
        fetchWordsByCategory(category: "Expression", image: casualImage, color: .teal)
        fetchWordsByCategory(category: "Business", image: casualImage, color: .lightOrange )
        fetchWordsByCategory(category: "Education", image: casualImage, color: .lightPurple)
        fetchWordsByCategory(category: "Health", image: casualImage, color: .lightGreen)
        fetchWordsByCategory(category: "", image: mixImage, color: .lightPink)
       }
    
    func fetchReplacingWord(category:String, image: UIImage, color: UIColor) -> Discover{
        let word = dbWordController.getNewWordByCategory(category:category)!
        let discover = Discover(title: word.title ?? "", wordType:word.wordType ?? "", definition: word.definition ?? "", featuredImage: image, color: color)
        return discover
    }
    
    func fetchWordsByCategory(category:String, image: UIImage, color: UIColor){
        discoverList.removeAll()
        let allWords = (dbWordController.getFiveWordsByCategory(category: category) ?? nil)!
          for word in allWords{
            let discover = Discover(title: word.title ?? "" , wordType: word.wordType ?? "", definition: word.definition ?? "", featuredImage: image, color: color)
        
                discoverList.append(discover)
                }
            switch category {
                case "Emotion":
                    emotionList = discoverList
                case "Expression":
                    expressionList = discoverList
                case "Business":
                    businessList = discoverList
                case "Education":
                    educationList = discoverList
                case "Health":
                    healthList = discoverList
                default:
                    mixList = discoverList
                }
       }
    
    func formatWordList(word: NSManagedObject) -> Word{
        var newWord: Word!
        if word != nil{
              let title = word.value(forKey: "title") as! String
               let wordType = word.value(forKey: "wordType") as! String
               let definition = word.value(forKey: "definition") as! String
               let sentence = word.value(forKey: "sentence") as! String
               let category = word.value(forKey: "category") as! String
               let favourite = word.value(forKey: "favourited") as! Bool
            let learned = word.value(forKey: "learned") as! Bool
 
               newWord = Word(title: title, wordType: wordType , definition: definition
                  ,sentence: sentence, category: category, favourited: favourite, added: false, learned:learned)
        }
        return newWord
       }
}



extension Date {
        func localDate() -> Date {
            let nowUTC = Date()
            let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
            guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

            return localDate
        }
}



class Core{
    static let shared = Core()
    
    func isNewUSer() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
/*class MySwipeGesture: UISwipeGestureRecognizer {
    var title = String()
}*/
