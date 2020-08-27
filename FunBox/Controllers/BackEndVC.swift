//
//  BackEndVC.swift
//  FunBox
//
//  Created by Denis Prozukin on 13.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit
import CSV
import SnapKit

class BackEndVC: UIViewController {
	enum Section {
		case main
	}
	
	var articles = [Article]()
	fileprivate var backEndCollectionView: UICollectionView!
	fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, Article>!
	fileprivate var snapshot: NSDiffableDataSourceSnapshot<Section, Article>!
	
	convenience init(articles: [Article]) {
		self.init()
		self.articles = articles
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureAddBarButton() 
		configureCollectionView()
		configureDataSource()
		applySnapshot(animated: false)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		reloadSnapshot()
	}
}
// MARK: - Extensions
extension BackEndVC {
	func configureCollectionView() {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
		collectionView.delegate = self
		
		view.addSubview(collectionView)
		view.backgroundColor = .systemBackground
		
		collectionView.snp.makeConstraints { (make) in
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
		
		collectionView.backgroundColor = .systemBackground
		collectionView.register(BackEndCell.self, forCellWithReuseIdentifier: BackEndCell.reuseIdentifier)
		backEndCollectionView = collectionView
	}
	
	func configureLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
			let inset: CGFloat = 8
			
			let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			item.contentInsets = .init(top: inset, leading: inset, bottom: inset, trailing: inset)
			
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
			
			let section = NSCollectionLayoutSection(group: group)
			
			return section
		}
		return layout
	}
	
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: backEndCollectionView, cellProvider: { (collectionView, indexPath, article) -> UICollectionViewCell? in
			self.configure(BackEndCell.self, with: article, for: indexPath)
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
		guard let cell = backEndCollectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)")}
		cell.configure(with: article)
		return cell
	}
	
	private func configureAddBarButton() {
		let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonPressed))
		barButton.tintColor = .systemGreen
		navigationItem.rightBarButtonItem = barButton
	}
	
	@objc private func onAddButtonPressed() {
		let vc = AddVC()
		vc.delegate = self
		navigationController?.present(vc, animated: true, completion: nil)
	}
}

extension BackEndVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		backEndCollectionView.deselectItem(at: indexPath, animated: true)
		guard let article = dataSource.itemIdentifier(for: indexPath) else { return	}
		let vc = EditVC()
		
		vc.delegate = self
		vc.article = article
		
		navigationController?.present(vc, animated: true)
	}
}

extension BackEndVC: EditModalHandler {
	func editModalDismissed() {
		reloadSnapshot()
	}
}

extension BackEndVC: AddModalHandler {
	func addModalDismissed() {
		applySnapshot(animated: false)
	}
}




