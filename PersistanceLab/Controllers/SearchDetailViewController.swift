//
//  SearchDetailViewController.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    var photo: Photo?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
    }
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
        loadImage()
        // Do any additional setup after loading the view.
    }

}
