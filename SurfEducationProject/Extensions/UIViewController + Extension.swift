//
//  UIViewController + Extension.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 21.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func configureNavigationBar(title: String) {
        navigationItem.title = title
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .standartBlack()
        navigationItem.rightBarButtonItem = searchButton
    }

    @objc private func didTapSearchButton() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                                style: .plain,
                                                target: navigationController,
                                                action: #selector(self.navigationController?.popToRootViewController(animated:)))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
}
