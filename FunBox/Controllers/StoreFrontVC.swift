//
//  ViewController.swift
//  FunBox
//
//  Created by Denis Prozukin on 13.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit
import CSV
import SnapKit

class StoreFrontVC: UIViewController {
	enum Section {
		case main
	}
	
	var articles = [Article]() 
	fileprivate var storeFrontCollectionView: UICollectionView!
	fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, Article>!
	fileprivate var snapshot: NSDiffableDataSourceSnapshot<Section, Article>!
	
	convenience init(articles: [Article]) {
		self.init()
		self.articles = articles
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
		configureDataSource()
		applySnapshot(animated: false)
		configureBuyButton()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		applySnapshot(animated: false)
	}
}
// MARK: - Extensions
extension StoreFrontVC {
	private func configureCollectionView() {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
		
		view.addSubview(collectionView)
		view.backgroundColor = .systemBackground
		
		collectionView.snp.makeConstraints { (make) in
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
		
		collectionView.backgroundColor = .systemBackground
		collectionView.isScrollEnabled = false
		
		collectionView.register(StoreFrontCell.self, forCellWithReuseIdentifier: StoreFrontCell.reuseIdentifier)
		
		storeFrontCollectionView = collectionView
	}
	
	private func configureLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
			let sideInset: CGFloat = 5
			
			let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			item.contentInsets = .init(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)
			
			let groupWidth = environment.container.contentSize.width * 0.93
			let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .fractionalWidth(1.0))
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
			
			let section = NSCollectionLayoutSection(group: group)
			
			let sectionSideInset = (environment.container.contentSize.width - groupWidth) / 2
			let sectionTopInset = (environment.container.contentSize.height - groupWidth) / 10
			section.contentInsets = NSDirectionalEdgeInsets(top: sectionTopInset, leading: sectionSideInset, bottom: 0, trailing: sectionSideInset)
			section.orthogonalScrollingBehavior = .groupPaging
			
			return section
		}
		return layout
	}
	
	private func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: storeFrontCollectionView, cellProvider: { (collectionView, indexPath, article) -> UICollectionViewCell? in
			self.configure(StoreFrontCell.self, with: article, for: indexPath)
		})
	}
	
	private func applySnapshot(animated: Bool) {
		snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
		
		snapshot.appendSections([.main])
		snapshot.appendItems(articles)
		
		dataSource.apply(snapshot, animatingDifferences: animated)
	}
	
	private func reloadSnapshot(animated: Bool = false) {
		var snapshot = dataSource.snapshot()
		snapshot.reloadItems(articles)
		dataSource.apply(snapshot, animatingDifferences: animated)
	}
	
	private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with article: Article, for indexPath: IndexPath) -> T {
		guard let cell = storeFrontCollectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)")}
		cell.configure(with: article)
		return cell
	}
	
	private func configureBuyButton() {
		let button = CustomButton(title: "Купить")
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
		
		view.addSubview(button)
		
		button.snp.makeConstraints { (make) in
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
			make.height.lessThanOrEqualTo(50).priority(.medium)
		}
	}
	
	@objc private func buyButtonTapped() {
		var visibleRect = CGRect()
		visibleRect.origin = storeFrontCollectionView.contentOffset
		visibleRect.size = storeFrontCollectionView.bounds.size
		let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
		guard let visibleIndexPath: IndexPath = storeFrontCollectionView.indexPathForItem(at: visiblePoint), let article = dataSource.itemIdentifier(for: visibleIndexPath) else { return }
		print(article.name)
	}
}


