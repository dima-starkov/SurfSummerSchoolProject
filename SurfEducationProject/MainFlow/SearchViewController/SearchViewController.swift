//
//  SearchViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 13.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confugureNavigationBar()
        configureSearchBar()
    }
}

//MARK: - Private methods

 private extension SearchViewController {
     func confugureNavigationBar() {
         let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                                 style: .plain,
                                                 target: navigationController,
                                          action: #selector(self.navigationController?.popViewController(animated:)))
         backButton.tintColor = .black
         navigationItem.leftBarButtonItem = backButton
         navigationController?.interactivePopGestureRecognizer?.delegate = self
         navigationItem.title = "Поиск"
     }
    
    func configureSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 303, height: 32))
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
}

//MARK: -  SearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SearchViewController: UIGestureRecognizerDelegate {
    
}
