//
//  CoreDataHelper.swift
//  Travel Diries
//
//  Created by Jinesh Patel on 26/05/22.
//

import Foundation
import CoreData
import UIKit

class EntityLocation : NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityLocation> {
        return NSFetchRequest<EntityLocation>(entityName: "LocationEntity")
    }

    @NSManaged public var siteName: String?
    @NSManaged public var siteLat: NSNumber?
    @NSManaged public var siteLong: NSNumber?
    @NSManaged public var sitePhotos: UIImage?
}

class PhotoLocation : NSManagedObject {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoLocation> {
//        return NSFetchRequest<PhotoLocation>(entityName: "LocationPhoto")
//    }

    @NSManaged public var sitePhoto: Data?

}

class CoreDataHelper {
    static var instance : CoreDataHelper = CoreDataHelper()
    
    
    
    func save(name : String) {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        let objEntityLocation = NSEntityDescription.insertNewObject(forEntityName: "LocationEntity", into: managedContext) as! LocationEntity
        
        objEntityLocation.siteName = name
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateLocation(title : String, lat : Double, long : Double) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationEntity")
        fetchRequest.predicate = NSPredicate(format: "siteName = %@", title)
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! LocationEntity
                    obj.siteLat = lat
                    obj.siteLong = long
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getTravelData() {
        appDelegate.arrTravelData.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocationEntity")
        
        do {
            appDelegate.arrTravelData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
