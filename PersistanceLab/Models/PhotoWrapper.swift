//
//  PhotoWrapper.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
struct PhotoWrapper: Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let likes: Int
    let favorites: Int
    let tags: String
    let previewURL: String
    let webformatURL: String
    let id: Int
    
}
