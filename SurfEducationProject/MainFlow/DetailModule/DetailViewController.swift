//
//  DetailViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 14.08.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Views
    
    let tableView = UITableView()
    
    //MARK: - Properties
    
    var model: DetailItemModel?

    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }

}

//MARK: - Private methods

private extension DetailViewController {
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
        
        tableView.register(UINib(nibName: "\(DetailImageTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTitleTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTextTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTextTableViewCell.self)")
    }
    func configureNavigationController() {
        guard let name = model?.title else { return}
        configureNavigationBar(title: name)
        configureBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

//MARK: - TableView delegate

extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageTableViewCell.self)")
            if let cell = cell as? DetailImageTableViewCell {
                cell.cofigure(with: model)
                return cell
            }
           
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
            if let cell = cell as? DetailTitleTableViewCell {
                cell.configure(with: model)
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTextTableViewCell.self)")
            if let cell = cell as? DetailTextTableViewCell {
                cell.configure(with: model)
                return cell
            }
          
        default:
            fatalError()
        
        }
        return UITableViewCell()
    }
    
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    
}
