//
//  QuizController.swift
//  VocabLearn
//
//  Created by Jun K on 2020-06-22.
//  Copyright © 2020 Jun K. All rights reserved.
//

import Foundation
import UIKit
import CoreData


public class QuizController{
    
    func insertQuiz(newResult: Quiz){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
               return
           }
           
           let managedContext = appDelegate.persistentContainer.viewContext
           
           let QuizEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "QuizEntity", in: managedContext)
           
           //if we have access to quiz table
           if (QuizEntity != nil){
              
                   let quizEntity = NSManagedObject(entity: QuizEntity!, insertInto: managedContext)
                  
            quizEntity.setValue(newResult.type, forKey: "type")
            quizEntity.setValue(newResult.category, forKey: "category")
            quizEntity.setValue(newResult.list, forKey: "list")
            quizEntity.setValue(newResult.score, forKey: "score")
            quizEntity.setValue(newResult.date, forKey: "date")

                   do{
                       //to perform insert operation on database table
                       try managedContext.save()
                       print("successful");
                       
                   }catch let error as NSError{
                       print("Insert quiz failed...\(error)")
                   }
               }
           
       }
    
}
