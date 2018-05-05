//
//  CoreDataHandler.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-16.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import CoreData

// OBS! Kan bli problem nu när du ändrat Int16 till Double Height. Håll koll på detta och ta bort tidigare entries!

class CoreDataHandler: NSObject {
    
    static let deskSettingKey : String = "DeskSetting"
    static let deskSettingName : String = "name"
    static let deskSettingHeight : String = "height"
    
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    // Save setting to Core Data
    class func saveSetting(name:String, height:Double) {
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
    
    // Get desk setting. Returns all desk settings
    class func getSettings() -> [DeskSetting]? {
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
    
    // Returns the height (double) of an entrie if name matches
    class func getHeightFromSettingName(name: String) -> Double {
        let context = getContext()
        var height : Double = 0
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeskSetting")
        let pred = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = pred
        do {
            let deskSettingList = try context.fetch(fetchRequest)
            for setting in deskSettingList as! [DeskSetting] {
                height = setting.height
            }
        } catch {
            print("failed to fetch desk setting")
        }
        return height
    }
    
    // Deletes desk setting from DeskSetting by attribute: name.
    class func deleteSetting(name: String) {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeskSetting")
        let pred = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = pred
        do {
            let deskSettingList = try context.fetch(fetchRequest)
            for setting in deskSettingList as! [DeskSetting] {
                context.delete(setting)
            }
        } catch {
            print("Failed to delete setting")
        }
        do {
            try context.save()
        } catch {
            print("Faled to save deletion")
        }
    }

    // Returns an String array of names of settings
    class func getSettingStringArray() -> [String] {
        var settingList : [String] = []
        if let list = getSettings() {
            for setting in list {
                if let name = setting.name {
                    settingList.append(name)
                }
            }
        }
        return settingList
    }
    
    

}
