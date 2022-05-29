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
