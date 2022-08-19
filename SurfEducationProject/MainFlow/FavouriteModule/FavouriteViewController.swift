//
//  FavouriteViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    //MARK: - Views
    
    let tableView = UITableView()
    
    //MARK: - Properties
    
    var model = [DetailItemModel]()
    
    //MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearance()
        configureNavigationBar()
        confugureModel()
        print(model.count)
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
        model = FavoriteStorage.shared.favoritesItems
        tableView.reloadData()
    }
    
    func presentAlertToDeleteItem(item: DetailItemModel) {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: " Да,точно", style: .destructive) {_ in
            guard let index = self.model.firstIndex(where: {$0.id == item.id}) else { return }
            self.tableView.beginUpdates()
            FavoriteStorage.shared.removeItem(item: item)
            self.model = FavoriteStorage.shared.favoritesItems
            let indexSet = IndexSet(integer: index)
            self.tableView.deleteSections(indexSet, with: .automatic)
            self.tableView.endUpdates()
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
}

//MARK: -UITableView

extension FavouriteViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemModel = model[indexPath.section]
        
        switch indexPath.row % 3 {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteImageTableViewCell.self)")
            if let cell = cell as? FavoriteImageTableViewCell {
                cell.configure(with: itemModel)
                cell.didTapHeartButton = {
                    self.presentAlertToDeleteItem(item: itemModel)
                }
                return cell
            }
           
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
            if let cell = cell as? DetailTitleTableViewCell {
                cell.configure(with: itemModel)
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavoriteDetailTextTableViewCell.self)")
            if let cell = cell as? FavoriteDetailTextTableViewCell {
                cell.configure(with: itemModel)
                return cell
            }
          
        default:
            fatalError()
        
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model[indexPath.section]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
