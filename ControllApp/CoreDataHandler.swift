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
    
    static let deskSettingKey : String = "DeskSetting"
    static let deskSettingName : String = "name"
    static let deskSettingHeight : String = "height"
    
    static let globalStatus : String = "GlobalStatus"
    static let globalStatusDescription = "gsDescription"
    static let globalStatusHeight : String = "height"
    
    static let globalStatusCurrentHeight : String = "CurrentHeight"
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    // Save setting to Core Data
    class func saveSetting(name:String, height:Int16) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: deskSettingKey, in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(name, forKey: deskSettingName)
        managedObject.setValue(height, forKey: deskSettingHeight)
        do {
            try context.save()
            
        } catch {
            print("Faled to save desk setting")
            
        }
    }
    
    // Save global status to Core Data
    class func saveGlobalStatus(height: Int16) {
        let context = getContext()
        var globalList : [GlobalStatus]? = []
        do {
            globalList = try context.fetch(GlobalStatus.fetchRequest())
        } catch {
            print("Failed to fetch Global Status")
        }
        let entity = NSEntityDescription.entity(forEntityName: globalStatus, in: context)
        if globalList?.count == 0 {
            let managedObject = NSManagedObject(entity: entity!, insertInto: context)
            managedObject.setValue(globalStatusCurrentHeight, forKey: globalStatusDescription)
            managedObject.setValue(height, forKey: globalStatusHeight)
        }else {
            // Kod för att uppdatera ett objekt istället för att lägga till
        }
        do {
            try context.save()
        } catch {
            print("Faled to save global status")
        }
       
    }
    
    // Get desk setting. Returns all desk settings
    class func getSetting() -> [DeskSetting]? {
        let context = getContext()
        var deskSettingList : [DeskSetting]? = nil
        do {
            deskSettingList = try context.fetch(DeskSetting.fetchRequest())
            return deskSettingList
        } catch {
            print("Failed to fetch Desk Settings")
            return deskSettingList
        }
    }
    
    class func getGlobalSetting() {
        
    }

}
