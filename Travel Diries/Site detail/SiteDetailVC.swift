//
//  SiteDetailVC.swift
//  Travel Diries
//
//  Created by Vraj Patel on 21/05/22.
//

import UIKit

class SiteDetailVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var siteInfo : SiteInfo?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        siteInfo = appDelegate.arrSiteDetail[index!]
        
        let item = UINavigationItem()
        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        navigationBar.items = [item]
        navigationBar.topItem?.title = siteInfo?.siteTitle ?? ""
    }
    
    @objc func addTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnLocationClick(_ sender: Any) {
        
        let locationVC = LocationVC(nibName: "LocationVC", bundle: nil)
        locationVC.siteInfo = siteInfo
        locationVC.index = index
        self.navigationController?.pushViewController(locationVC, animated: true)
        
    }
    
    @IBAction func btnGalleryClick(_ sender: Any) {
        let galleryVC = GalleryVC(nibName: "GalleryVC", bundle: nil)
        galleryVC.siteInfo = siteInfo
        galleryVC.index = index
        self.navigationController?.pushViewController(galleryVC, animated: true)
    }
    
}
