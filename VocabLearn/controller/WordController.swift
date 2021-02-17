//
//  WordController.swift
//  VocabLearn
//
//  Created by Jun K on 2020-05-21.
//  Copyright © 2020 Jun K. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class WordController{
    
    // --------------------- ADD Functions ------------------------------//
func insertWords(newWords:[Word]){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let WordEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "WordEntity", in: managedContext)
    
    //if we have access to Word table
    if (WordEntity != nil){
        for word in newWords{
            let wordEntity = NSManagedObject(entity: WordEntity!, insertInto: managedContext)
            
            wordEntity.setValue(word.title, forKey: "title")
            wordEntity.setValue(word.wordType, forKey: "wordType")
            wordEntity.setValue(word.definition, forKey: "definition")
            wordEntity.setValue(word.sentence, forKey: "sentence")
            wordEntity.setValue(word.category, forKey: "category")
            wordEntity.setValue(word.favourited, forKey: "favourited")
             wordEntity.setValue(word.added, forKey: "added")
             wordEntity.setValue(word.learned, forKey: "learned")

            do{
                //to perform insert operation on database table
                try managedContext.save()
                print("successful");
                
            }catch let error as NSError{
                print("Insert Word failed...\(error)")
            }
        }
    }
}
    func insertWord(newWord:Word){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let WordEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "WordEntity", in: managedContext)
        
        //if we have access to Word table
        if (WordEntity != nil){
           
                let wordEntity = NSManagedObject(entity: WordEntity!, insertInto: managedContext)
               
                      wordEntity.setValue(newWord.title, forKey: "title")
                      wordEntity.setValue(newWord.wordType, forKey: "wordType")
                      wordEntity.setValue(newWord.definition, forKey: "definition")
                      wordEntity.setValue(newWord.sentence, forKey: "sentence")
                      wordEntity.setValue(newWord.category, forKey: "category")
//                      wordEntity.setValue(newWord.date, forKey: "date")
            wordEntity.setValue(newWord.favourited, forKey: "favourited")
                       wordEntity.setValue(newWord.added, forKey: "added")
                       wordEntity.setValue(newWord.learned, forKey: "learned")

                do{
                    //to perform insert operation on database table
                    try managedContext.save()
                    print("successful");
                    
                }catch let error as NSError{
                    print("Insert Word failed...\(error)")
                }
            }
        
    }
    
    // --------------------- UPDATE Functions ------------------------------//
    func checkDuplicate(title: String) -> Int{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return 0
        }

        var entitiesCount = 0
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
         //bad: quit fetch when found, not go through all records
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do{
            //let result = try managedContext.fetch(fetchRequest)
            //get only first
            entitiesCount = try managedContext.count(for: fetchRequest)
    
        }catch{
            print("Word update unsuccessful")
        }
        return entitiesCount
    }
    //better function replacement for updates
    func checkFavourited(title: String){
           
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
               return
           }
           var favourited = false
           let managedContext = appDelegate.persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
            //bad: quit fetch when found, not go through all records
           fetchRequest.predicate = NSPredicate(format: "title = %@", title)
           
           do{
               let result = try managedContext.fetch(fetchRequest)
              let existingWord = result[0] as! NSManagedObject
            favourited = existingWord.value(forKey: "favourited") as! Bool
            favourited = !favourited
            existingWord.setValue(favourited, forKey: "favourited")
            do{
                try managedContext.save()
                print("Word update Successful")
            }catch{
                print("Word update unsuccessful")
            }
           }catch{
               print("Word update unsuccessful")
           }
       }
    //better function replacement for updates
    func checkLearned(title: String){
              
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                  return
              }
              var learned = false
              let managedContext = appDelegate.persistentContainer.viewContext
              
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
               //bad: quit fetch when found, not go through all records
              fetchRequest.predicate = NSPredicate(format: "title = %@", title)
              
              do{
                  let result = try managedContext.fetch(fetchRequest)
                 let existingWord = result[0] as! NSManagedObject
               learned = existingWord.value(forKey: "learned") as! Bool
               learned = !learned
               existingWord.setValue(learned, forKey: "learned")
               do{
                   try managedContext.save()
                   print("Word update Successful")
               }catch{
                   print("Word update unsuccessful")
               }
              }catch{
                  print("Word update unsuccessful")
              }
          }
    
    func updateWordFavourited(title: String, favourited: Bool){
          
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
          
          fetchRequest.predicate = NSPredicate(format: "title = %@", title)
          
          do{
              let result = try managedContext.fetch(fetchRequest)
               //bad: quit fetch when found, not go through all records
              let existingWord = result[0] as! NSManagedObject
           
              existingWord.setValue(favourited, forKey: "favourited")
              
              
              do{
                  try managedContext.save()
                  print("Word update Successful")
              }catch{
                  print("Word update unsuccessful")
              }
          }catch{
              print("Word update unsuccessful")
          }
          
      }
    
    func updateWordlearned(title: String, learned: Bool){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
         //bad: quit fetch when found, not go through all records
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            let existingWord = result[0] as! NSManagedObject
         
            existingWord.setValue(learned, forKey: "learned")
            
            
            do{
                try managedContext.save()
                print("Word update Successful")
            }catch{
                print("Word update unsuccessful")
            }
        }catch{
            print("Word update unsuccessful")
        }
        
    }
    
    
    // --------------------- DELETE Functions ------------------------------//
    func deleteWord(title: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            let existingWord = result[0] as! NSManagedObject
            
            managedContext.delete(existingWord)
            
            do{
                try managedContext.save()
                print("Word delete Successful")
            }catch{
                print("Word delete unsuccessful")
            }
            
        }catch{
            
        }
    }
    func deleteAll(){
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
          
         let a = "Casual"
          fetchRequest.predicate = NSPredicate(format: "category = %@", a)
          
          do{
              let result = try managedContext.fetch(fetchRequest)
   
            for i in 1...result.count{
                let del = result[i] as! NSManagedObject
                  managedContext.delete(del)
            }
            
              
              do{
                  try managedContext.save()
                  print("Word delete Successful")
              }catch{
                  print("Word delete unsuccessful")
              }
              
          }catch{
              
          }
      }
    // --------------------- GET Functions ------------------------------//
    
    func getAllWordsDateSort() -> [NSManagedObject]?{
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return nil
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
          let sort = NSSortDescriptor(key: "date", ascending: true)
          fetchRequest.sortDescriptors = [sort]
          
        fetchRequest.fetchBatchSize = 20
          do{
              let result = try managedContext.fetch(fetchRequest)
              return result as? [NSManagedObject]
          }catch{
              print("Data fetching Unsuccessful")
          }
          return nil
      }
    
    func getAllWordsAlphabetSort() -> [NSManagedObject]?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        fetchRequest.fetchBatchSize = 20
        let sort = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
    }
    func getAllWordsSearched(search: String) -> [NSManagedObject]?{
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
             return nil
         }
         
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
         fetchRequest.fetchBatchSize = 20
        let searchPredicate = NSPredicate(format: "title beginswith[c] %@",search)
        fetchRequest.predicate = searchPredicate
         let sort = NSSortDescriptor(key: "title", ascending: true)
         fetchRequest.sortDescriptors = [sort]
         
         do{
             let result = try managedContext.fetch(fetchRequest)
             return result as? [NSManagedObject]
         }catch{
             print("Data fetching Unsuccessful")
         }
         return nil
     }
    
    func getWordsByCategory(category: String) -> [NSManagedObject]?{
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return nil
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        
         let categoryPredicate = NSPredicate(format: "(category ==%@)",category)
        fetchRequest.predicate = categoryPredicate
        let sort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
        
    }
    func getFiveWordsByCategory(category: String) -> [NSManagedObject]?{
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                 return nil
             }
             
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        if category != ""{
            let categoryPredicate = NSPredicate(format: "(category ==%@)",category)
           fetchRequest.predicate = categoryPredicate
        }
            //fetchRequest.fetchOffset = 5;
            fetchRequest.fetchLimit = 5;
           let sort = NSSortDescriptor(key: "date", ascending: true)
                    fetchRequest.sortDescriptors = [sort]
           do{
               let result = try managedContext.fetch(fetchRequest)
               return result as? [NSManagedObject]
           }catch{
               print("Data fetching Unsuccessful")
           }
           return nil
           
       }
    
    func getTenWords() -> [NSManagedObject]?{
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return nil
          }
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
     
         fetchRequest.fetchOffset = 10;
         fetchRequest.fetchLimit = 10;
       // let sort = NSSortDescriptor(key: "date", ascending: true)
               //  fetchRequest.sortDescriptors = [sort]
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
        
    }
    
    func getThirtyWordsTitle() -> [NSManagedObject]?{
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                 return nil
             }
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        
           // fetchRequest.fetchOffset = 2;
            fetchRequest.fetchLimit = 2;
          // let sort = NSSortDescriptor(key: "date", ascending: true)
                  //  fetchRequest.sortDescriptors = [sort]
           do{
               let result = try managedContext.fetch(fetchRequest)
               return result as? [NSManagedObject]
           }catch{
               print("Data fetching Unsuccessful")
           }
           return nil
           
       }
    
    func getQuestionWords(category: String, list: String) -> [NSManagedObject]?{
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                 return nil
             }
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        
         var predicate = NSPredicate()
        if category != "Mix" && list == "Mix"{
         predicate = NSPredicate(format: "(category ==%@)",category)
           
        }else if list != "Mix"{
            predicate = listPredicate(list: list, category:category)
        }
             fetchRequest.predicate = predicate
        
           // fetchRequest.fetchOffset = 10;
            fetchRequest.fetchLimit = 10;
          // let sort = NSSortDescriptor(key: "date", ascending: true)
                  //  fetchRequest.sortDescriptors = [sort]
           do{
               let result = try managedContext.fetch(fetchRequest)
               return result as? [NSManagedObject]
           }catch{
               print("Data fetching Unsuccessful")
           }
           return nil
           
       }
    func listPredicate(list: String, category: String) -> NSPredicate {
        
         var predicate = NSPredicate()
        if category == "Mix"{
        switch list {
                   case "Favourite":
                       predicate = NSPredicate(format: "(favourited =%d)",true)
                    case "Added":
                        predicate = NSPredicate(format: "(added =%d)",true)
                    default:
                       predicate = NSPredicate(format: "(learned =%d)",true)
                   }
        }else{
            switch list {
                    case "Favourite":
                        predicate = NSPredicate(format: "favourited =%d AND category ==%@",true, category)
                    case "Added":
                        predicate = NSPredicate(format: "(added =%d AND category ==%@)",true, category)
                    default:
                        predicate = NSPredicate(format: "(learned =%d AND category ==%@)",true, category)
            }
        }
        
        return predicate
    }

    func getNewWordByCategory(category: String) -> NSManagedObject?{
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return nil
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
     if category != ""{
         let categoryPredicate = NSPredicate(format: "(category ==%@)",category)
        fetchRequest.predicate = categoryPredicate
     }
         fetchRequest.fetchOffset = 1;
         fetchRequest.fetchLimit = 1;
        //let sort = NSSortDescriptor(key: "date", ascending: true)
        //fetchRequest.sortDescriptors = [sort]
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result[0] as? NSManagedObject
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
        
    }
    
    func getAllWordsFavourite() -> [NSManagedObject]?{
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                 return nil
             }
             
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
           
            let favouritePredicate = NSPredicate(format: "(favourited =%d)", true)
           fetchRequest.predicate = favouritePredicate
           //let sort = NSSortDescriptor(key: "date", ascending: true)
                   // fetchRequest.sortDescriptors = [sort]
        let sort = NSSortDescriptor(key: "title", ascending: true)
               fetchRequest.sortDescriptors = [sort]
           do{
               let result = try managedContext.fetch(fetchRequest)
               return result as? [NSManagedObject]
           }catch{
               print("Data fetching Unsuccessful")
           }
           return nil
           
       }
    func getAllWordsAdded() -> [NSManagedObject]?{
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                   return nil
               }
               
               let managedContext = appDelegate.persistentContainer.viewContext
               
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
             
              let favouritePredicate = NSPredicate(format: "(added =%d)", true)
             fetchRequest.predicate = favouritePredicate
             //let sort = NSSortDescriptor(key: "date", ascending: true)
                      //fetchRequest.sortDescriptors = [sort]
        let sort = NSSortDescriptor(key: "title", ascending: true)
               fetchRequest.sortDescriptors = [sort]
             do{
                 let result = try managedContext.fetch(fetchRequest)
                 return result as? [NSManagedObject]
             }catch{
                 print("Data fetching Unsuccessful")
             }
             return nil
             
         }
    func getAllWordsLearned() -> [NSManagedObject]?{
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                   return nil
               }
               
               let managedContext = appDelegate.persistentContainer.viewContext
               
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
             
              let favouritePredicate = NSPredicate(format: "(learned =%d)", true)
             fetchRequest.predicate = favouritePredicate
            // let sort = NSSortDescriptor(key: "date", ascending: true)
                     // fetchRequest.sortDescriptors = [sort]
        let sort = NSSortDescriptor(key: "title", ascending: true)
               fetchRequest.sortDescriptors = [sort]
             do{
                 let result = try managedContext.fetch(fetchRequest)
                 return result as? [NSManagedObject]
             }catch{
                 print("Data fetching Unsuccessful")
             }
             return nil
             
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
    
    func getTodaysWords() -> [NSManagedObject]?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WordEntity")
        
        /*ac.addAction(UIAlertAction(title: "Show only recent", style: .default) { [unowned self] _ in
            let twelveHoursAgo = Date().addingTimeInterval(-43200)
            self.commitPredicate = NSPredicate(format: "date > %@", twelveHoursAgo as NSDate)
            self.loadSavedData()
        })*/
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone //NSTimeZone.local

        // Get today's beginning & end
        let dateFrom = calendar.startOfDay(for: Date().localDate()) // eg. 2016-10-10 00:00:00

       print(dateFrom)
        // Set predicate as date being today's date
        let fromPredicate = NSPredicate(format: "(date ==%@)",dateFrom as NSDate)
        //let toPredicate = NSPredicate(format: "%@ < %@", date as NSDate, dateTo! as NSDate)
        //let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest.predicate = fromPredicate
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
    }
}
