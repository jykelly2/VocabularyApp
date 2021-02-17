//
//  TestingView.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-21.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

struct Question {
    let questionText: String
    let options: [String]
    let correctAns: String
    var wrongAns: Int
    var isAnswered: Bool
}

struct QuestionBase {
    let title: String
    let definition: String
    let sentence: String
}

class TestingView: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let wordController = WordController()
     let dbWordController = DbWordController()
    let quizController = QuizController()
    let isPhone = UIDevice.isPhone
    var count: Int = 0
    var takenQuiz : Quiz!
    private var questionBaseList = [QuestionBase]()
    private var optionList = [Int]()
    private var titleList = [String]()
    
    var resultList = [Result]()
    
    var currentList: ListEntity?
    
    var questionsArray = [Question]()
    var score: Int = 0
    var currentQuestionNumber = 1
    var progress: Float = 0.0

    let screenScale = UIScreen.main.scale
    let screenBounds = UIScreen.main.bounds
   // var myCollectionView: UICollectionView!
    
     let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 1
            
        let myCollectionView=UICollectionView(frame: .zero, collectionViewLayout: layout)
            myCollectionView.register(QuizCell.self, forCellWithReuseIdentifier: "QuizCell")
            myCollectionView.showsHorizontalScrollIndicator = false
            myCollectionView.translatesAutoresizingMaskIntoConstraints=false
            myCollectionView.backgroundColor=UIColor.white
             myCollectionView.isPagingEnabled = true
        return myCollectionView
    }()
    
    let progressBar: UIProgressView = {
        let pb = UIProgressView()
        pb.translatesAutoresizingMaskIntoConstraints = false
        pb.progressTintColor = .lightBlue
        //pb.progressViewStyle = .bar
        pb.progress = 0.0
        pb.backgroundColor = .lightGrey
        return pb
    }()
    
   /* let btnPrev: UIButton = {
        let btn=UIButton()
        btn.setTitle("< Previous", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.orange
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()*/
    
    let btnNext: UIButton = {
        let btn=UIButton()
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.teal
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnNextAction), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    let lblQueNumber: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.gray
        lbl.textAlignment = .left
        //lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblScore: UILabel = {
        let lbl=UILabel()
        //lbl.text="Score: 0"
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let titleLbL: UILabel = {
          let lbl=UILabel()
          lbl.translatesAutoresizingMaskIntoConstraints=false
          lbl.textAlignment = .center
          lbl.minimumScaleFactor = 0.1
          lbl.adjustsFontSizeToFitWidth = true
          lbl.numberOfLines = 1
          return lbl
      }()
    
    lazy var closeBtn: UIButton = {
         let btn = UIButton.init(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "closeicon")?.withRenderingMode(.alwaysTemplate)
        img?.withTintColor(.darkGray)
         btn.clipsToBounds = true
        btn.layer.backgroundColor = UIColor.lightGray.cgColor
        btn.setImage(img, for: .normal)
         btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
         return btn
    }()
    
    let headerView : UIView = {
                 let view = UIView()
                     view.translatesAutoresizingMaskIntoConstraints = false
                 view.backgroundColor = .lightGrey
                 return view
    }()
    
    @objc func closeView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.hideNavigationBar(animated: true)
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
           loadingView.removeFromSuperview()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
         view.backgroundColor = UIColor.white
        
        
        if currentList != nil{
            titleLbL.text = currentList?.name!
            progress = Float(Float(1) / Float((currentList?.rawWords!.count)!))
        }else{
            progress = Float(Float(1) / Float((15)))
            titleLbL.text = takenQuiz.category
        }
    
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
    
        view.addSubview(myCollectionView)
        view.addSubview(progressBar)
        view.addSubview(headerView)
        headerView.addSubview(closeBtn)
        headerView.addSubview(titleLbL)
        view.addSubview(progressBar)
        view.addSubview(lblScore)
        view.addSubview(btnNext)
        fetchWords()
        fetchTitles()
       // print(questionBaseList.count)
        questionBaseList.shuffle()
        getQuestions()
        //print(questionsArray.count)
    }
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
            let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        
        if isPhone{
            headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier:0.14).isActive=true
            headerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive=true
            
            titleLbL.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/32)
            lblScore.font = UIFont(name: "Helvetica-Bold", size: safeAreaHeight/37)
            
            titleLbL.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/30).isActive=true

            closeBtn.imageView?.tintColor = .white
              closeBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaWidth/60).isActive = true
              closeBtn.heightAnchor.constraint(equalTo: headerView.widthAnchor,  multiplier:0.085).isActive=true
              closeBtn.widthAnchor.constraint(equalTo: headerView.widthAnchor,  multiplier:0.085).isActive=true
              closeBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -safeAreaWidth/50).isActive = true
            
            closeBtn.drawCicleByFive()
            
            
            progressBar.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.015).isActive=true
            progressBar.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9).isActive=true
            progressBar.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: safeAreaHeight/60).isActive=true
            progressBar.layer.cornerRadius = safeAreaHeight/120
            progressBar.clipsToBounds = true
                      
            lblScore.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: safeAreaHeight/40).isActive=true
                       //lblScore.text = "Score: \(score) / \(questionsArray.count)"
           lblScore.text = "Score: \(score)"
         
            
           // myCollectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor,  multiplier:1).isActive=true
            myCollectionView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,  multiplier:1).isActive=true
            myCollectionView.topAnchor.constraint(equalTo: lblScore.bottomAnchor).isActive=true
          //  myCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive=true
           // myCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive=true
        
            
            let btnLabelSize = safeAreaWidth/20
            
           // btnPrev.titleLabel?.font = UIFont(name: "Helvetica", size: btnLabelSize)
            btnNext.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: btnLabelSize)
            myCollectionView.bottomAnchor.constraint(equalTo: btnNext.topAnchor).isActive=true
            btnNext.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.15).isActive=true
            btnNext.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive=true
            btnNext.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -safeAreaHeight/30).isActive=true
            
            btnNext.layer.cornerRadius = safeAreaHeight/25
            btnNext.addSlightShadow()
            
            /*self.view.addSubview(btnNext)
            btnNext.heightAnchor.constraint(equalTo: btnPrev.heightAnchor).isActive=true
            btnNext.widthAnchor.constraint(equalTo: btnPrev.widthAnchor).isActive=true
            btnNext.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive=true
            btnNext.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive=true
            */
            //lblQueNumber.font = UIFont.systemFont(ofSize: screenSize.width/55)
  
         /*   self.view.addSubview(lblQueNumber)
            //lblQueNumber.heightAnchor.constraint(equalToConstant: 20).isActive=true
            //lblQueNumber.widthAnchor.constraint(equalToConstant: 150).isActive=true
            lblQueNumber.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20).isActive=true
            lblQueNumber.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: safeAreaHeight/50).isActive=true
            lblQueNumber.text = "Question: \(1) / \(questionsArray.count)"*/
            
        }else{
            
        }
        headerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive=true
         titleLbL.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive=true
        lblScore.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive=true
        progressBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive=true
        btnNext.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive=true
    }
        
    func getRandomNumbers(exception: String){
        optionList.removeAll()
        var count = 0
            while count < 3{
                var random: Int = 0
                if currentList == nil{
                 random = Int.random(in: 0..<2)
                }else{
                    random = Int.random(in: 0..<(currentList?.words!.count)!)
                }
                if titleList[random] == exception{
                   // print(titleList[random])
                    //print(exception)
                    print("again")
                }else{
                optionList.append(random)
                    count += 1
                }
            }
    }
    
    func getQuestions(){
        if takenQuiz.type == "Definition"{
            definitionQuestions(mix: false, odd: false)
        }else if takenQuiz.type == "Sentence"{
           sentenceQuestions(count: 0)
        }else{
            
            if questionBaseList.count % 2 == 0 {
                definitionQuestions(mix: true, odd: false)
              sentenceQuestions(count: questionBaseList.count/2)
            } else {
                definitionQuestions(mix: true, odd: true)
              sentenceQuestions(count: (questionBaseList.count-1)/2)
            }
        }
    }
    func sentenceQuestions(count: Int){
        for i in count..<questionBaseList.count{
            let title = questionBaseList[i].title
             getRandomNumbers(exception: title)
            let sentence = questionBaseList[i].sentence
            let blankSentence = sentence.replacingOccurrences(of: title.lowercased() , with: "_________ ")
            
            let que = Question(questionText: blankSentence, options: [title, titleList[optionList[0]], titleList[optionList[1]], titleList[optionList[2]]].shuffled(), correctAns: title,wrongAns: -1, isAnswered: false)
                questionsArray.append(que)
         }
    }
    
    func definitionQuestions(mix:Bool, odd: Bool){
        var questionCount = questionBaseList.count
         if mix && odd{
            questionCount = (questionBaseList.count-1)/2
         }else if mix {
            questionCount = questionBaseList.count/2
        }
         for i in 0..<questionCount{
            let title = questionBaseList[i].title
            getRandomNumbers(exception: title)
            let que = Question(questionText: questionBaseList[i].definition, options: [title, titleList[optionList[0]], titleList[optionList[1]], titleList[optionList[2]]].shuffled(), correctAns: title,wrongAns: -1, isAnswered: false)
            questionsArray.append(que)
        }
    }
    
    func fetchWords(){
        if currentList == nil{
            let questionWords = dbWordController.getFifteenWordsByCategory(category: takenQuiz.category)
            print(questionWords!.count)
            if questionWords!.count < 3 {
                let alert = UIAlertController(title: "Not Enough Words",
                message: "You need at least 5 words", preferredStyle: .alert)     
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                 _ in
                    self.navigationController?.popToRootViewController(animated: true)
                 }))
                self.present(alert, animated: true, completion: nil)
            }
            formatWordForList(words: questionWords!)
        }else{
            formatWordForList(words: (currentList?.words)!)
        }
    }

    func  fetchTitles(){
        if currentList != nil{
            for word in currentList!.words!{
                titleList.append(word.title!)
            }
        }else{
            let words = dbWordController.getThirtyWordsTitle()
            if words != nil{
                for word in words! {
                    //let title = word.value(forKey: "title") as! String
                    //titleList.append(word)
                    print(word)
                }
                titleList = words!
            }
        }
    }
    
    func formatWordList(words: [NSManagedObject]){
        for word in words {
            
            let title = word.value(forKey: "title") as! String
            let definition = word.value(forKey: "definition") as! String
            let sentence = word.value(forKey: "sentence") as! String
            
            let question = QuestionBase(title: title, definition: definition, sentence: sentence)
            
            questionBaseList.append(question)
        }
    }
    
    func formatWordForList(words: [WordEntity]){
           for word in words {
            
            let question = QuestionBase(title: word.title!, definition: word.definition!, sentence: word.sentence!)
            questionBaseList.append(question)
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return questionsArray.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as! QuizCell
          cell.question=questionsArray[indexPath.row]
          cell.delegate=self
          return cell
      }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var time = DispatchTimeInterval.seconds(0)
        if count == 0{
            time = DispatchTimeInterval.seconds(3)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.count += 1
            if self.btnNext.isHidden == true{
                cell.alpha = 0
              UIView.animate(withDuration: 0.3 ,
                              delay: 0, usingSpringWithDamping:  0.7, initialSpringVelocity: 1 , options: .curveEaseIn,
                          animations: {
                         cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                           
                        },
                            completion: { finish in
                              UIView.animate(withDuration: 0.3){
                             cell.transform = CGAffineTransform.identity
                              cell.alpha = 1
                        }
                    })
        }
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           setQuestionNumber()
       }
       
       func setQuestionNumber() {
           let x = myCollectionView.contentOffset.x
           let w = myCollectionView.bounds.size.width
           let currentPage = Int(ceil(x/w))
           if currentPage < questionsArray.count {
               lblQueNumber.text = "Question: \(currentPage+1) / \(questionsArray.count)"
               currentQuestionNumber = currentPage + 1
           }
       }
 

 @objc func btnNextAction(sender: UIButton) {
        btnNext.isHidden = true
        if currentQuestionNumber == questionsArray.count {
            takenQuiz.score = score
            //quizController.insertQuiz(newResult: takenQuiz)
            let mainSB = UIStoryboard(name:"Main", bundle:nil)
          let result = mainSB.instantiateViewController(identifier: "ResultsView") as! ResultsView
            if currentList == nil{
            result.category = takenQuiz.category
            }else{
                result.listName = currentList?.name as! String
            }
            result.quizResult = resultList
            result.type = takenQuiz.type
            result.score = score
            self.navigationController?.pushViewController(result, animated: false)
            return
        }
        
        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        //if sender == btnNext {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= questionsArray.count ? 0 : 1
            progressBar.progress += progress
       /* } else {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x - collectionBounds.size.width))
            currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
        }*/
        self.moveToFrame(contentOffset: contentOffset)
        lblQueNumber.text = "Question: \(currentQuestionNumber) / \(questionsArray.count)"
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myCollectionView.contentOffset.y ,width : self.myCollectionView.frame.width,height : self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
}
extension TestingView: QuizCellDelegate {
    func didChooseAnswer(btnTitle: String, btnIndex: Int) {
        btnNext.isHidden = false
        let centerIndex = getCenterIndex()
        guard let index = centerIndex else { return }
        questionsArray[index.item].isAnswered=true
        
        var question = questionsArray[index.item]
        var isCorrect = false
        
        if question.correctAns != btnTitle {
             questionsArray[index.item].wrongAns = btnIndex
            
            //score -= 1
        } else {
            score += 1
            isCorrect = true
        }
        lblScore.text = "Score: \(score)"
        myCollectionView.reloadItems(at: [index])
 
        let result = Result(question: question.questionText, correctAns: question.correctAns, selectedAns: btnTitle, isCorrect: isCorrect)
         resultList.append(result)
        
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
        let index = myCollectionView.indexPathForItem(at: center)
        return index
    }
}

