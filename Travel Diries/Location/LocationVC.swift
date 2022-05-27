//
//  LocationVC.swift
//  Travel Diries
//
//  Created by Vraj Patel on 21/05/22.
//

import UIKit
import MapKit
import CoreLocation

class LocationVC: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var map: MKMapView!
    
    var siteInfo :  SiteInfo?
    var index : Int?
    
    let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta:
    0.01)
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        siteInfo = appDelegate.arrSiteDetail[index!]
        let item = UINavigationItem()
        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        if siteInfo?.siteLocation == nil {
            item.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        }
        navigationBar.items = [item]
        
        navigationBar.topItem?.title = "\(siteInfo?.siteTitle ?? "")'s Location"

        var coordinate = CLLocationCoordinate2D(latitude: siteInfo?.siteLocation?.lat ?? 00, longitude: siteInfo?.siteLocation?.long ?? 00)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        map.addAnnotation(annotation)
        
        if siteInfo?.siteLocation == nil {
            print("Site pin is empty")
            if (CLLocationManager.locationServicesEnabled())
            {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
            }
        } else {
            print("Site pin is already stored")
        }
    }

    @objc func addTapped() {
        self.navigationController?.popViewController(animated: true)
    }
				    
    @objc func saveTapped() {
        print("Save tapped")
        print("Lat : \(locationManager.location?.coordinate.latitude) , long : \(locationManager.location?.coordinate.longitude)")
        
        let localSite = appDelegate.arrSiteDetail[index!]
        let site = localSite
        site.siteLocation = SiteCordinates(lat: locationManager.location?.coordinate.latitude ?? 0.0, long: locationManager.location?.coordinate.longitude ?? 0.0)
        
        appDelegate.arrSiteDetail[index!] = site
        DataManager.instance.saveIntoUserDefault()
        self.navigationController?.popViewController(animated: true)
    }
}

extension LocationVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
            
            var coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            
        }
    }
}
