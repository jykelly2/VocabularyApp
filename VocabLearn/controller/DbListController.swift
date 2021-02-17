//
//  DbListController.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-04.
//  Copyright © 2020 Jun K. All rights reserved.
//

import UIKit
import CoreData

public class DbListController{
    let dbWordController = DbWordController()
    func insertList(newList: ListEntity){
        do{
           try newList.managedObjectContext?.save()
         print("successful");
                       
        }catch let error as NSError{
                print("Insert List failed...\(error)")
             }
    }
    
    func insertLists(newLists: [ListEntity]){
            for list in newLists{
              do{
                 try list.managedObjectContext?.save()
               print("successful");
                             
              }catch let error as NSError{
                      print("Insert List failed...\(error)")
                   }
            }
        }
    
    func insertWordsDefaultLists(){
        
        //Emotions
        let happy = ["Enlightment", "Appreciation"]
        let fear = ["Anxious", "Distrust"]
       let anger = ["Upset", "Furious"]
        let sad = ["Depress", "Melancholy"]
        
        
        //Business
        let political = ["Impeachment","Legislation"]
         let compliments = ["Enchanting","Appealing"]
       let professional = ["Standard", "Excecutive"]
        let marketing = ["Bargain", "Endorsed"]
        
        let policalList = getList(title: "Political")
        let angerList = getList(title: "Anger")
        let sadList = getList(title: "Sad")
        let professionalList = getList(title: "Professional")
        let complimentsList = getList(title: "Compliments")
        
        
        let marketingList = getList(title: "Marketing")
        let happyList = getList(title: "Happy")
        let fearList = getList(title: "Fear")
        
        for word in happy{
         let addingWord = dbWordController.getWordByTitle(title: word)
         happyList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
        for word in fear{
         let addingWord = dbWordController.getWordByTitle(title: word)
         fearList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
        for word in marketing{
         let addingWord = dbWordController.getWordByTitle(title: word)
         marketingList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
        for word in political{
                let addingWord = dbWordController.getWordByTitle(title: word)
                policalList?.addToRawWords(addingWord!)
                   do {
                    try addingWord?.managedObjectContext?.save()
                    }catch{
                      print("not saved")
                    }
               }
        
        for word in anger{
         let addingWord = dbWordController.getWordByTitle(title: word)
         angerList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
        for word in sad{
         let addingWord = dbWordController.getWordByTitle(title: word)
         sadList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
        for word in compliments{
         let addingWord = dbWordController.getWordByTitle(title: word)
            complimentsList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
        for word in professional{
         let addingWord = dbWordController.getWordByTitle(title: word)
         professionalList?.addToRawWords(addingWord!)
            do {
             try addingWord?.managedObjectContext?.save()
             }catch{
               print("not saved")
             }
        }
   }
    

    func deleteList(list: ListEntity){
        
        guard let managedContext = list.managedObjectContext else{
            return
        }
            managedContext.delete(list)
           do{
            try managedContext.save()
            print("successful");
                          
           }catch let error as NSError{
                   print("Insert List failed...\(error)")
                }
       }
    
    func getList(title:String) -> ListEntity?{
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                  return nil
              }
              let managedContext = appDelegate.persistentContainer.viewContext
         
             let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
             fetchRequest.predicate = NSPredicate(format: "name = %@", title)
        
           
            do{
                return try managedContext.fetch(fetchRequest).first
            }catch{
                print("Data fetching Unsuccessful")
            }
            return nil
            
        }
       
    func getLists() -> [ListEntity]?{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return nil
            }
            let managedContext = appDelegate.persistentContainer.viewContext
       
           let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()

           let sort = NSSortDescriptor(key: "name", ascending: true)
           fetchRequest.sortDescriptors = [sort]
          do{
              return try managedContext.fetch(fetchRequest)
          }catch{
              print("Data fetching Unsuccessful")
          }
          return nil
          
      }
    
    func getListsByCategory(category: String) -> [ListEntity]?{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return nil
            }
            let managedContext = appDelegate.persistentContainer.viewContext
       
            let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
        
            fetchRequest.predicate = NSPredicate(format: "category = %@", category)
        
            let sort = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sort]
          do{
              return try managedContext.fetch(fetchRequest)
          }catch{
              print("Data fetching Unsuccessful")
          }
          return nil
          
      }
    
    func getCustomLists() -> [ListEntity]?{
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                   return nil
               }
               let managedContext = appDelegate.persistentContainer.viewContext
          
                let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "(custom =%d)", true)
              let sort = NSSortDescriptor(key: "name", ascending: true)
               fetchRequest.sortDescriptors = [sort]
             do{
                 return try managedContext.fetch(fetchRequest)
             }catch{
                 print("Data fetching Unsuccessful")
             }
             return nil
             
         }
    
    func getDefaultLists() -> [ListEntity]?{
                 guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                     return nil
                 }
                 let managedContext = appDelegate.persistentContainer.viewContext
            
                let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
        
                fetchRequest.predicate = NSPredicate(format: "(custom =%d)", false)
                let sort = NSSortDescriptor(key: "name", ascending: true)
                fetchRequest.sortDescriptors = [sort]
               do{
                   return try managedContext.fetch(fetchRequest)
               }catch{
                   print("Data fetching Unsuccessful")
               }
               return nil
               
           }
    
    func checkListDuplicate(title: String) -> Int{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return 0
        }

        var entitiesCount = 0
        let managedContext = appDelegate.persistentContainer.viewContext
        
             let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
             fetchRequest.predicate = NSPredicate(format: "name = %@", title)
         //bad: quit fetch when found, not go through all records
        
        do{
            //let result = try managedContext.fetch(fetchRequest)
            //get only first
            entitiesCount = try managedContext.count(for: fetchRequest)
    
        }catch{
            print("Word update unsuccessful")
        }
        return entitiesCount
    }

}
