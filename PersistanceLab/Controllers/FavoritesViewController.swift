//
//  FavoritesViewController.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var favPhotos = [Photo]() {
        didSet {
            favTableView.reloadData()
        }
    }
    @IBOutlet weak var favTableView: UITableView!
    
    private func setDelegates() {
        favTableView.delegate = self
        favTableView.dataSource = self
    }
    private func loadFavPhotos() {
        do {
            favPhotos = try PhotoPersistance.manager.getPhotos()
        } catch {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavPhotos()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favTableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let fav = favPhotos[indexPath.row]
        ImageHelper.manager.getImage(urlString: fav.previewURL) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    cell.favImageView.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Favorites"
    }
}
