//
//  ImageLoader.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 17.08.2022.
//

import Foundation
import UIKit

struct ImageLoader {
    let queueForLoad = DispatchQueue.global(qos: .utility)
    let session = URLSession(configuration: .default)
    
    func loadImage(from url: URL,onLoadWasCompleted: @escaping (Result<UIImage,Error>)->Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(.failure(error))
            }
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            onLoadWasCompleted(.success(image))

        }.resume()
    }
}
