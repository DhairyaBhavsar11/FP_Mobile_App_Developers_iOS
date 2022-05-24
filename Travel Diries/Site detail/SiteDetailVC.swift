//
//  SiteDetailVC.swift
//  Travel Diries
//
//  Created by dhairya bhavsar on 2022-05-24.
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
