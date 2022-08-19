//
//  TokenContainer.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct TokenContainer {
    let token: String
    let receivingDate: Date
    
    var tokenExpirinngTime: TimeInterval {
        39600
    }
    
    var isExpired: Bool {
        Date(timeIntervalSinceNow: -tokenExpirinngTime) > receivingDate
    }
}
