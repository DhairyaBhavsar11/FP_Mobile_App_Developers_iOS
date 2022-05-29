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
    
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataHelper.instance.getTravelData()
        
        let objLocation = appDelegate.arrTravelData[index!] as! LocationEntity
        
        let item = UINavigationItem()
        item.rightBarButtonItem = UIBarButtonItem(title: "Add Photo", style: .plain, target: self, action: #selector(addPhotosTapped))
        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        navigationBar.items = [item]
        navigationBar.topItem?.title = objLocation.siteName ?? ""
        
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
}

extension GalleryVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let obj = appDelegate.arrTravelData[index!] as? LocationEntity
            let siteName = obj?.siteName ?? ""
            CoreDataHelper.instance.updateImage(title: siteName, image: image)
            CoreDataHelper.instance.getTravelData()
        }
        collectionView.reloadData()
        picker.dismiss(animated: true, completion: nil);
    }
}

extension GalleryVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let objLocation = appDelegate.arrTravelData[index!] as? LocationEntity
        let arrImage = objLocation?.sitePhotos as? [UIImage]
        if let arr = arrImage {
            return arr.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        let objLocation = appDelegate.arrTravelData[index!] as? LocationEntity
        let arrImage = objLocation?.sitePhotos as? [UIImage]
        cell.img.image = arrImage![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 6, height: 100.0)
    }
    
}
