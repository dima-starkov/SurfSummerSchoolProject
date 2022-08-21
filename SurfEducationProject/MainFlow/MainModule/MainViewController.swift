//
//  MainViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
//MARK: - Constants
    
    private enum Constants {
        static let collectionViewPadding: CGFloat = 16
        static let hSpaceBetweenItems: CGFloat = 7
        static let vSpaceBetweenItems: CGFloat = 8
    }
    
//MARK: - Events

//MARK: - Properties
    
    var model: DetailItemDataModel = .init()
    var favoriteStorage = FavoriteStorage.shared
    
//MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let loadErrorView = PostLoadErrorView()
    let refresh = UIRefreshControl()
    
//MARK: -UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        configureAppearance()
        favoriteStorage.itemsRemoved = { [weak self] item in
            if let index = self?.model.items.firstIndex(where: {$0.title == item.title}) {
                let indexPath = IndexPath(item: index, section: 0)
                self?.collectionView.reloadItems(at: [indexPath])
            }
        }
    }

}

private extension MainViewController {
    
    func loadPosts() {
        model.loadPosts { [weak self] isCompletion in
            if isCompletion {
                DispatchQueue.main.async {
                    self?.confugureModel()
                    self?.collectionView.reloadData()
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                self?.presentLoadErrorView()
                }
            }
        }
    }
    
    func configureAppearance() {
        configureNavigationBar()
        configureCollectionView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .standartBlack()
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func didTapSearchButton() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        collectionView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc func reloadData() {
        collectionView.refreshControl?.beginRefreshing()
        loadPosts()
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    
    func confugureModel() {
        model.didItemsUpdate = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }

    func presentLoadErrorView() {
        collectionView.isHidden = true
        view.addSubview(loadErrorView)
        loadErrorView.isHidden = false
        
        loadErrorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadErrorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadErrorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadErrorView.topAnchor.constraint(equalTo: view.topAnchor),
            loadErrorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadErrorView.tryUpdate = { [weak self] in
            self?.loadErrorView.isHidden = true
            self?.collectionView.isHidden = false
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = false
            self?.loadPosts()
            
        }
    }
}

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
//MARK: - CollectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? MainItemCollectionViewCell else { return UICollectionViewCell() }
        let itemModel = model.items[indexPath.row]
        cell.confugure(with: itemModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK: - CollectionView layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let itemWidth = (view.frame.width - Constants.collectionViewPadding * 2 - Constants.hSpaceBetweenItems) / 2
           return CGSize(width: itemWidth, height: itemWidth / 168 * 246)
       
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return Constants.vSpaceBetweenItems
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return Constants.hSpaceBetweenItems
       }
    
}
