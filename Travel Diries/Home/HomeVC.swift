//
//  HomeVC.swift
//  Travel Diries
//
//  Created by Vraj Patel on 21/05/22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager.instance.getDataFromUserDefault()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataManager.instance.getDataFromUserDefault()
        collectionView.reloadData()
    }

    @IBAction func btnAddSiteClick(_ sender: Any) {
        let alert = UIAlertController(title: "Travel diaries", message: "Enter place name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Plese enter name here"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print("Text field: \(textField!.text!)")
            self.savePlace(title: textField!.text!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func savePlace(title : String) {
        var objSiteDetail = SiteInfo(siteTitle: title, siteLocation: nil, photos: nil)
        appDelegate.arrSiteDetail.append(objSiteDetail)
        collectionView.reloadData()
        DataManager.instance.saveIntoUserDefault()
        
    }
    
    
    
}

extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.arrSiteDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        cell.lblSiteName.text = appDelegate.arrSiteDetail[indexPath.row].siteTitle ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 6, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let siteDetailVC = SiteDetailVC(nibName: "SiteDetailVC", bundle: nil)
        siteDetailVC.siteInfo = appDelegate.arrSiteDetail[indexPath.row]
        siteDetailVC.index = indexPath.row
        self.navigationController?.pushViewController(siteDetailVC, animated: true)
    }
}
