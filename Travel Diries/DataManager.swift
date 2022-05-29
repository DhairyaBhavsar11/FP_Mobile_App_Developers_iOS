//
//  DataManager.swift
//  Travel Diries
//
//  Created by Vraj Patel on 21/05/22.
//

import Foundation

class SiteInfo : NSObject, NSCoding {
    
    var siteTitle : String? = nil
    var siteLocation : SiteCordinates? = nil
    var photos : [Data]? = nil
    
    init(siteTitle: String, siteLocation: SiteCordinates?, photos: [Data]?) {
        self.siteTitle = siteTitle
        self.siteLocation = siteLocation
        self.photos = photos
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(siteTitle, forKey: "siteTitle")
        aCoder.encode(siteLocation, forKey: "siteLocation")
        aCoder.encode(photos, forKey: "photos")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "siteTitle") as! String
        let name = aDecoder.decodeObject(forKey: "siteLocation") as? SiteCordinates
        let shortname = aDecoder.decodeObject(forKey: "photos") as? [Data]
        self.init(siteTitle: id, siteLocation: name, photos: shortname)
    }
    
}

class SiteCordinates : NSObject, NSCoding {
    var lat : Double? = nil
    var long : Double? = nil
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(long, forKey: "long")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "lat") as! Double
        let name = aDecoder.decodeObject(forKey: "long") as! Double
        self.init(lat: id, long: name)
    }
    
   

    
}

class DataManager {
    
    static var instance = DataManager()
    
//    func saveIntoUserDefault() {
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: appDelegate.arrSiteDetail)
//        userDefaults.set(encodedData, forKey: "SiteDetails")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            userDefaults.synchronize()
//        }
//    }
//    
//    func getDataFromUserDefault() {
//        let userDefaults = UserDefaults.standard
//        let decoded  = userDefaults.data(forKey: "SiteDetails")
//        if decoded != nil {
//            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [SiteInfo]
//            appDelegate.arrSiteDetail.removeAll()
//            appDelegate.arrSiteDetail = decodedTeams
//        }
//    }
}
