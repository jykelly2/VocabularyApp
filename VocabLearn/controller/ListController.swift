//
//  ListController.swift
//  VocabLearn
//
//  Created by Jun K on 2020-07-02.
//  Copyright © 2020 Jun K. All rights reserved.
//


import Foundation
import UIKit
import CoreData


public class ListController{
    
    func insertList(newList: List){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
               return
           }
           
           let managedContext = appDelegate.persistentContainer.viewContext
           
           let ListEntity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: managedContext)
        
           if (ListEntity != nil){
              
                   let ListEntity = NSManagedObject(entity: ListEntity!, insertInto: managedContext)
                  
            ListEntity.setValue(newList.name, forKey: "name")
                   do{
                       //to perform insert operation on database table
                       try managedContext.save()
                       print("successful");
                       
                   }catch let error as NSError{
                       print("Insert List failed...\(error)")
                   }
               }
       }
    func getLists() -> [NSManagedObject]?{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return nil
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListEntity")
       
          // fetchRequest.fetchOffset = 10;
           //fetchRequest.fetchLimit = 10;
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
}
