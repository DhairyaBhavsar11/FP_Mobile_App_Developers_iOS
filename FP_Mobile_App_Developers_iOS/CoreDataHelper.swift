//
//  CoreDataHelper.swift
//  Travel Diries
//
//  Created by Jinesh Patel on 26/05/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    static var instance : CoreDataHelper = CoreDataHelper()
    
    /// To save name into core data
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
    
    /// To update location's lat and long values into coredata as per Site
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
    
    /// To update image in core data as per Site
    func updateImage(title : String, image : UIImage) {
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
                    if obj.sitePhotos == nil {
                        var arrImg : [UIImage] = []
                        arrImg.append(image)
                        obj.sitePhotos = arrImg as NSObject
                    } else {
                        var arrImg = obj.sitePhotos as! [UIImage]
                        arrImg.append(image)
                        obj.sitePhotos = arrImg as NSObject
                    }
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /// To get travel data from core data and store into array
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
