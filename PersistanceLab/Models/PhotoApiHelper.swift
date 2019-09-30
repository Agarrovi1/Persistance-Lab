//
//  PhotoApiHelper.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation

class PhotoApiHelper {
    private init() {}
    static let manager = PhotoApiHelper()
    
    func getPhotoWrapper(urlString: String,completionHandler: @escaping (Result<PhotoWrapper,AppError>) -> ()) {
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.badURL))
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let wrapper = try JSONDecoder().decode(PhotoWrapper.self, from: data)
                    completionHandler(.success(wrapper))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
