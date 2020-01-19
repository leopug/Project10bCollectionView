//
//  ViewController.swift
//  Project1
//
//  Created by Ana Caroline de Souza on 11/12/19.
//  Copyright © 2019 Ana e Leo Corp. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [String]()
    var picturesLabels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viwer Da Massa"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(shareTapped))
        
        loadImagesListFromBundle()
        collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell.")
        }
        
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        cell.photoName.text = picturesLabels[indexPath.item]
        
        return cell
    }
    
    
    func loadImagesListFromBundle() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        
        let itemsFilteredSorted = items.filter({$0.hasPrefix("nssl")}).sorted()
        for (index, item) in itemsFilteredSorted.enumerated() {
            picturesLabels.append("Picture \(index+1)")
            pictures.append(item)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                    vc.selectedImage = pictures[indexPath.row]
                    navigationController?.pushViewController(vc, animated: true)
                }
    }

    @objc func shareTapped(){
        let recommendationMessage = "Yeah, i definitely recommend this app, you should try now!"
        let vc = UIActivityViewController(activityItems: [recommendationMessage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated:true)
    }
    
}

