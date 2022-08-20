//
//  SearchViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 13.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
//MARK: -Constants
    
    private enum Constants {
        static let collectionViewPadding: CGFloat = 16
        static let hSpaceBetweenItems: CGFloat = 7
        static let vSpaceBetweenItems: CGFloat = 8
    }
    
//MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    let resultIsEmptyView = ResultsIsEmptyView()
    let searchBarIsEmptyView = SearchBarIsEmptyView()
    
//MARK: -Properties
    
    var model: DetailItemDataModel = .init()
    var items = [DetailItemModel]()
    var filteredData = [DetailItemModel]()
    private var timer: Timer?
    
//MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        model.loadPosts { [weak self] isSuccess in
            guard let strongSelf = self else { return }
            if isSuccess {
                strongSelf.items = strongSelf.model.items
            }
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confugureNavigationBar()
        configureSearchBar()
        configureCollectionView()
        configureViewWhenResultsIsEmpty()
        configureViewWhenSearchBarIsEmpty()
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
     
     func configureCollectionView() {
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
         collectionView.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
     }
     
     func configureViewWhenResultsIsEmpty() {
         view.addSubview(resultIsEmptyView)
         resultIsEmptyView.isHidden = true
         resultIsEmptyView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
            resultIsEmptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultIsEmptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultIsEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultIsEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }
     func configureViewWhenSearchBarIsEmpty() {
         view.addSubview(searchBarIsEmptyView)
         searchBarIsEmptyView.isHidden = false
         searchBarIsEmptyView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
            searchBarIsEmptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBarIsEmptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBarIsEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarIsEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
     }
    
}

//MARK: - CollectionView

extension SearchViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.isEmpty ? 0 : filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? MainItemCollectionViewCell else { return UICollectionViewCell() }
        let itemModel = filteredData[indexPath.row]
        cell.confugure(with: itemModel)
        return cell
    }
    
//MARK: - CollectionViewLayout
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = model.items[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - SearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData.removeAll()
        if searchText.isEmpty {
            collectionView.isHidden = true
            resultIsEmptyView.isHidden = true
            searchBarIsEmptyView.isHidden = false
        } else {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { [weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.filteredData = strongSelf.model.items.filter({$0.title.contains(searchText)})
            if strongSelf.filteredData.isEmpty {
                strongSelf.collectionView.isHidden = true
                strongSelf.searchBarIsEmptyView.isHidden = true
                strongSelf.resultIsEmptyView.isHidden = false
                strongSelf.collectionView.reloadData()
            } else {
                strongSelf.resultIsEmptyView.isHidden = true
                strongSelf.searchBarIsEmptyView.isHidden = true
                strongSelf.collectionView.isHidden = false
                strongSelf.collectionView.reloadData()
                print(strongSelf.filteredData[0])
                }
            })
        }
    }
    
    private func checkSearchText(item: DetailItemModel, searchText: String) -> Bool{
        return item.title.lowercased().contains(searchText.lowercased())
    }
    
    
}

extension SearchViewController: UIGestureRecognizerDelegate {
    
}
