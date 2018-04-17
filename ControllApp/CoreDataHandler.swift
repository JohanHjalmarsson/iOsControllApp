//
//  CoreDataHandler.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-16.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func savePerson(name:String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(name, forKey: "name")
        do {
            try context.save()
            return true
        } catch {
            print("Faled to save person")
            return false
        }
    }
    
    class func getPersonList() -> [Person]? {
        let context = getContext()
        var personList:[Person]? = nil
        do {
            personList = try context.fetch(Person.fetchRequest())
            return personList
        } catch {
            print("Failed to get PersonList")
            return personList
        }
    }

}
