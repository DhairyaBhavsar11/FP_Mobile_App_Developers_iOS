//
//  GalleryVC.swift
//  Travel Diries
//
//  Created by Vraj Patel on 21/05/22.
//

import UIKit

class GalleryVC: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagePicker = UIImagePickerController()
    
    var siteInfo : SiteInfo?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        siteInfo = appDelegate.arrSiteDetail[index!]
        DataManager.instance.getDataFromUserDefault()
        
        let item = UINavigationItem()
        item.rightBarButtonItem = UIBarButtonItem(title: "Add Photo", style: .plain, target: self, action: #selector(addPhotosTapped))
        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        navigationBar.items = [item]
        navigationBar.topItem?.title = siteInfo?.siteTitle ?? ""
        
        self.collectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        collectionView.reloadData()
    }
    
    @objc func addTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    
    @objc func addPhotosTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getImageData(img : UIImage) -> Data? {
        guard let data = img.jpegData(compressionQuality: 0.5) else { return nil}
        let encoded = try! PropertyListEncoder().encode(data)
        return encoded
    }
    
    func loadImage(data : Data) -> UIImage? {
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        return image
    }
    
}

extension GalleryVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imgData = getImageData(img: image)
            let localSite = appDelegate.arrSiteDetail[index!]
            let site = localSite
            if site.photos?.count == nil {
                site.photos = [Data]()
            }
            site.photos?.append(imgData!)
            
            appDelegate.arrSiteDetail[index!] = site
            DataManager.instance.saveIntoUserDefault()
        }
        collectionView.reloadData()
        picker.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        let imgData = getImageData(img: image)
        let localSite = appDelegate.arrSiteDetail[index!]
        let site = localSite
        site.photos?.append(imgData!)
        
        appDelegate.arrSiteDetail[index!] = site
        DataManager.instance.saveIntoUserDefault()
        
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
        
    }
}

extension GalleryVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.arrSiteDetail[index!].photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        cell.img.image = loadImage(data: appDelegate.arrSiteDetail[index!].photos![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 6, height: 100.0)
    }
    
}
