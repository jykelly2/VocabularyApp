//
//  DbWordController.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-04.
//  Copyright © 2020 Jun K. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class DbWordController{
    
    func getWordByTitle(title: String) -> WordEntity?{
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
             return nil
         }
        var existingWord: WordEntity!
         
         let managedContext = appDelegate.persistentContainer.viewContext     
              let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
              fetchRequest.predicate = NSPredicate(format: "title = %@", title)
         do{
             let result = try managedContext.fetch(fetchRequest)
             existingWord = result[0]
         }catch{
             print("Word update unsuccessful")
         }
         return existingWord
    }
    func checkDuplicate(title: String) -> Int{
           
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
               return 0
           }
           var entitiesCount = 0
           let managedContext = appDelegate.persistentContainer.viewContext
           
            let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
           do{
               entitiesCount = try managedContext.count(for: fetchRequest)
       
           }catch{
               print("Word update unsuccessful")
           }
           return entitiesCount
       }
    
    func getLearnedWords() -> [WordEntity]?{
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                        return nil
              }
                   let managedContext = appDelegate.persistentContainer.viewContext
                   
                 let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

                  fetchRequest.predicate = NSPredicate(format: "(learned =%d)", true)
                 do{
                    return try managedContext.fetch(fetchRequest)
                 }catch{
                     print("Data fetching Unsuccessful")
                 }
        return nil
      }
    func getFavouriteWords() -> [WordEntity]?{
                  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                           return nil
                 }
                      let managedContext = appDelegate.persistentContainer.viewContext
                      
                    let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

                     fetchRequest.predicate = NSPredicate(format: "(favourited =%d)", true)
                    do{
                       return try managedContext.fetch(fetchRequest)
                    }catch{
                        print("Data fetching Unsuccessful")
                    }
           return nil
         }
    func getAddedWords() -> [WordEntity]?{
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                             return nil
                   }
                        let managedContext = appDelegate.persistentContainer.viewContext
                        
                      let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

                       fetchRequest.predicate = NSPredicate(format: "(added =%d)", true)
                      do{
                         return try managedContext.fetch(fetchRequest)
                      }catch{
                          print("Data fetching Unsuccessful")
                      }
             return nil
           }
    
    func getLearnedWordsCount() -> Int{
         var count = 0
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                      return 0
            }
                 let managedContext = appDelegate.persistentContainer.viewContext
                 
               let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

                fetchRequest.predicate = NSPredicate(format: "(learned =%d)", true)
               do{
                count = try managedContext.fetch(fetchRequest).count
               }catch{
                   print("Data fetching Unsuccessful")
               }
         return count
    }
    func getFavouritedWordsCount() -> Int{
            var count = 0
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                         return 0
               }
                    let managedContext = appDelegate.persistentContainer.viewContext
                    
                  let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

                   fetchRequest.predicate = NSPredicate(format: "(favourited =%d)", true)
                  do{
                   count = try managedContext.fetch(fetchRequest).count
                  }catch{
                      print("Data fetching Unsuccessful")
                  }
            return count
       }
    func getAddedWordsCount() -> Int{
               var count = 0
                   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                            return 0
                  }
                       let managedContext = appDelegate.persistentContainer.viewContext
                       
                     let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

                      fetchRequest.predicate = NSPredicate(format: "(added =%d)", true)
                     do{
                      count = try managedContext.fetch(fetchRequest).count
                     }catch{
                         print("Data fetching Unsuccessful")
                     }
               return count
          }
    
    func getAllWordsAlphabeticalSort() -> [WordEntity]?{
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                  return nil
              }
              
              let managedContext = appDelegate.persistentContainer.viewContext
              
            let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()

             fetchRequest.fetchBatchSize = 20
            let sort = NSSortDescriptor(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [sort]
            do{
                 
                return try managedContext.fetch(fetchRequest)
            }catch{
                print("Data fetching Unsuccessful")
            }
            return nil
    }
    func getFiveWordsByCategory(category: String) -> [WordEntity]?{
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                  return nil
              }
              
              let managedContext = appDelegate.persistentContainer.viewContext
              
            let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
         if category != ""{
             let categoryPredicate = NSPredicate(format: "(category ==%@)",category)
            fetchRequest.predicate = categoryPredicate
         }
            // fetchRequest.fetchOffset = 2;
             fetchRequest.fetchLimit = 4;
            //let sort = NSSortDescriptor(key: "date", ascending: true)
            //fetchRequest.sortDescriptors = [sort]
            do{
                 
                return try managedContext.fetch(fetchRequest)
            }catch{
                print("Data fetching Unsuccessful")
            }
            return nil
            
        }
    
    func getFifteenWordsByCategory(category: String) -> [WordEntity]?{
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                    return nil
                }
                
                let managedContext = appDelegate.persistentContainer.viewContext
                
              let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
           if category != "Mix"{
               let categoryPredicate = NSPredicate(format: "(category ==%@)",category)
              fetchRequest.predicate = categoryPredicate
           }
               //fetchRequest.fetchOffset = 5;
               fetchRequest.fetchLimit = 4;
              do{
                  return try managedContext.fetch(fetchRequest)
              }catch{
                  print("Data fetching Unsuccessful")
              }
              return nil
              
    }
    
    func getThirtyWordsTitle() -> [String]?{
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                   return nil
               }
        
              var titles = [String]()
              let managedContext = appDelegate.persistentContainer.viewContext
               
              let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
          
             // fetchRequest.fetchOffset = 2;
                //fetchRequest.propertiesToFetch = ["title"]
              fetchRequest.fetchLimit = 5;
             do{
               
                let words = try (managedContext.fetch(fetchRequest))
                for word in words{
                    titles.append(word.title!)
                }
                 return titles
             }catch{
                 print("Data fetching Unsuccessful")
             }
             return nil
             
     }
    
    //if offset reached end, go back to begenning
    func getNewWordByCategory(category: String) -> WordEntity?{
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return nil
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
                  if category != ""{
                      let categoryPredicate = NSPredicate(format: "(category ==%@)",category)
                     fetchRequest.predicate = categoryPredicate
                  }
         //fetchRequest.fetchOffset = 5;
         fetchRequest.fetchLimit = 1;
        //let sort = NSSortDescriptor(key: "date", ascending: true)
        //fetchRequest.sortDescriptors = [sort]
        do{
            return try managedContext.fetch(fetchRequest).first
        }catch{
            print("Data fetching Unsuccessful")
        }
        return nil
        
    }
    
    func checkLearned(title: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
         //bad: quit fetch when found, not go through all records
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do{
           let result = try managedContext.fetch(fetchRequest)
           let existingWord = result[0]
            existingWord.learned = !existingWord.learned
            try existingWord.managedObjectContext?.save()
            print("successful");
          }catch let error as NSError{
                print("Insert List failed...\(error)")
          }
    }
    func favouriteWord(title: String){
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return
          }
          let managedContext = appDelegate.persistentContainer.viewContext
          let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
           //bad: quit fetch when found, not go through all records
          fetchRequest.predicate = NSPredicate(format: "title = %@", title)
          
          do{
             let result = try managedContext.fetch(fetchRequest)
             let existingWord = result[0]
            existingWord.favourited = !existingWord.favourited
              try existingWord.managedObjectContext?.save()
              print("successful");
            }catch let error as NSError{
                  print("Insert List failed...\(error)")
            }
      }
    
    func deleteWord(title: String){
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
              return
          }
          
          let managedContext = appDelegate.persistentContainer.viewContext
          
         let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "title = %@", title)
          
          do{
              let result = try managedContext.fetch(fetchRequest)
              let existingWord = result[0]
              
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
}
