//
//  ViewController.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class SearchPhotoViewController: UIViewController {

    //MARK: - Properties
    var photos = [Photo]() {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    var searchString: String? = nil {
        didSet {
            loadData()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Functions
    private func setDelegates() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
    private func loadData() {
        guard let searchString = searchString else  {return}
        guard searchString != "" else {return}
        let urlFromSearch = Secrets.getUrlWith(query: searchString)
        PhotoApiHelper.manager.getPhotoWrapper(urlString: urlFromSearch) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let wrapper):
                DispatchQueue.main.async {
                    self.photos = wrapper.hits
                }
            }
        }
        
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SearchDetailViewController,
            let cell = sender as? PhotoCollectionViewCell,
            let indexPath = photoCollectionView.indexPath(for: cell) else {return}
        destination.photo = photos[indexPath.row]
    }

}

//MARK: - Extensions
extension SearchPhotoViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.row]
        
        ImageHelper.manager.getImage(urlString: photo.previewURL) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        return cell
    }
}

extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
