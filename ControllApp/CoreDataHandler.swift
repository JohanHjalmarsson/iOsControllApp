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
    
    class func getHeightFromSettingName(name: String) -> Double {
        var height : Double = 0
        if let list = getSettings() {
            for setting in list {
                if let settingName = setting.name {
                    if settingName == name {
                        height =  setting.height
                        break;
                    }
                }
            }
        }
        return height
    }

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
