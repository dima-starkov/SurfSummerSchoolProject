//
//  SearchViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 13.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Поиск"
        configureSearchBar()
    }
   

}

 private extension SearchViewController {
    
    func configureSearchBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                style: .plain,
                                                target: navigationController,
                                                action: #selector(self.navigationController?.popToRootViewController(animated:)))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 303, height: 32))
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
