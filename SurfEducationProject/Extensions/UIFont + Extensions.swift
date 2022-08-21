//
//  UIFont + Extensions.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 21.08.2022.
//

import Foundation
import UIKit

extension UIFont {
    static func semibold24() -> UIFont {
        .systemFont(ofSize: 24, weight: .semibold)
    }
    static func semibold16()-> UIFont {
        .systemFont(ofSize: 16, weight: .semibold)
    }
    static func medium18()-> UIFont {
        .systemFont(ofSize: 18, weight: .medium)
    }
    static func regular18()-> UIFont {
        .systemFont(ofSize: 18, weight: .regular)
    }
    static func medium16()-> UIFont {
        .systemFont(ofSize: 16, weight: .medium)
    }
    static func regular14()-> UIFont {
        .systemFont(ofSize: 14, weight: .regular)
    }
    static func medium12()-> UIFont {
        .systemFont(ofSize: 12, weight: .medium)
    }
    static func regular12()-> UIFont {
        .systemFont(ofSize: 12, weight: .regular)
    }
    static func medium10()-> UIFont {
        .systemFont(ofSize: 10, weight: .medium)
    }
    static func light12() -> UIFont {
        .systemFont(ofSize: 12, weight: .light)
    }
    
}
