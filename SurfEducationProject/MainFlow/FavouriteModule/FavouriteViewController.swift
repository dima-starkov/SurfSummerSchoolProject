//
//  FavouriteViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    private enum cellType {
        case image
        case title
        case content
        
    }
    
    //MARK: - Views
    
    let tableView = UITableView()
    
    //MARK: - Properties
    
    var model: DetailItemDataModel = .init()
    
    
    //MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        model.getDefaultPosts()
        confugureModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearance()
        configureNavigationBar()
        
    }
   
}

//MARK: - Private methods

private extension FavouriteViewController {
    
    func configureAppearance() {
        confugureTableView()
    }
    
    func confugureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "\(FavoriteImageTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(FavoriteImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTitleTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(FavoriteDetailTextTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(FavoriteDetailTextTableViewCell.self)")
    }
    
    
    
    func configureNavigationBar() {
        navigationItem.title = "Избранное"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func didTapSearchButton() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func confugureModel() {
        model.didItemsUpdate = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

//MARK: -UITableView

extension FavouriteViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count * 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = model.items[indexPath.row]
        switch indexPath.row % 3 {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteImageTableViewCell.self)")
            if let cell = cell as? FavoriteImageTableViewCell {
                cell.configure(with: model)
                return cell
            }
           
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
            if let cell = cell as? DetailTitleTableViewCell {
                cell.configure(with: model)
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteDetailTextTableViewCell.self)")
            if let cell = cell as? FavoriteDetailTextTableViewCell {
                cell.configure(with: model)
                return cell
            }
          
        default:
            fatalError()
        
        }
        return UITableViewCell()
    }
    
    
}
