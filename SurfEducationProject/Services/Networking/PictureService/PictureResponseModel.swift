//
//  PictureResponseModel.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation
struct PictureResponseModel: Decodable {
    
    let id: String
    let title: String
    let content: String
    let photoUrl: String
    
    var date: Date {
            Date(timeIntervalSince1970: publicationDate / 1000)
        }

        // MARK: - Private Properties
    
    private let publicationDate: Double
}
