//
//  ImageHelper.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    private init() {}
    static let manager = ImageHelper()
    
    func getImage(urlString: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        guard let url = URL(string: urlString) else {
           return completionHandler(.failure(.badURL))
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.notAnImage))
                }
            }
        }
    }
}
