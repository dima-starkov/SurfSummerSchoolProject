//
//  MainViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Connstants
    
    private enum Constants {
        static let collectionViewPadding: CGFloat = 16
        static let hSpaceBetweenItems: CGFloat = 7
        static let vSpaceBetweenItems: CGFloat = 8
    }

    //MARK: - Properties
    
    var model: DetailItemDataModel = .init()
    
    //MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getDefaultPosts()
        configureAppearance()
        confugureModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

}

private extension MainViewController {
    func configureAppearance() {
        configureCollectionView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .black
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
    }
    
    func confugureModel() {
        model.didItemsUpdate = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: - collectionView delegate
    
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
    
    //MARK: - collectionView layout
    
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
