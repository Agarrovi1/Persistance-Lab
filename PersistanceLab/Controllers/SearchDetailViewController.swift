//
//  SearchDetailViewController.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    //MARK: - Properties
    var photo: Photo?
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    //MARK: - Actions
    @IBAction func favButtonPressed(_ sender: UIButton) {
        guard let photo = photo else {return}
        do {
            try PhotoPersistance.manager.save(newPhoto: photo)
        } catch {
            print(error)
        }
    }
    
    //MARK: - Functions
    private func loadLabels() {
        guard let photo = photo else {return}
        likesLabel.text = "Likes: \(photo.likes ?? 0)"
        favoritesLabel.text = "Favorites: \(photo.favorites ?? 0)"
        tagLabel.text = "Tags: \(photo.tags)"
    }
    private func loadImage() {
        guard let photo = photo else {return}
        ImageHelper.manager.getImage(urlString: photo.webformatURL) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
        loadImage()
    }

}
