//
//  Secrets.swift
//  PersistanceLab
//
//  Created by Angela Garrovillas on 9/30/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
struct Secrets {
    static let apiKey = "13796459-1f28e6be7544e57cf485862e5"
    
    static func getUrlWith(query: String) -> String {
        let query = query.lowercased()
        return "https://pixabay.com/api/?key=\(self.apiKey)&q=\(query)"
    }
}
