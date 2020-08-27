//
//  StoreFrontCell.swift
//  FunBox
//
//  Created by Denis Prozukin on 15.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class StoreFrontCell: UICollectionViewCell, SelfConfiguringCell {
	static var reuseIdentifier = "StoreFrontCell"
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title1)
		label.textColor = .white
		label.textAlignment = .center
		label.sizeToFit()
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let priceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textAlignment = .left
		label.text = "Цена"
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let priceValueLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textAlignment = .right
		label.textColor = .white
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let quantityLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textAlignment = .left
		label.text = "Количество"
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let quantityValueLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textAlignment = .right
		label.textColor = .white
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let separatorView: UIView = {
		let separator = UIView()
		separator.backgroundColor = .opaqueSeparator
		separator.translatesAutoresizingMaskIntoConstraints = false
		separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
		return separator
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("No storyboard cells.")
	}
	
	private func setUpCell() {
		setUpConstraints()
		setUpAppearance(shadowRadius: 8.0, shadowOpacity: 0.3)
		addGradientBackground(firstColor: .systemGreen, secondColor: .white, cornerRadius: layer.cornerRadius)
	}
	
	private func setUpConstraints() {
		let priceStackView = UIStackView(arrangedSubviews: [priceLabel, priceValueLabel])
		priceStackView.axis = .horizontal
		priceStackView.translatesAutoresizingMaskIntoConstraints = false
		
		let quantityStackView = UIStackView(arrangedSubviews: [quantityLabel, quantityValueLabel])
		quantityStackView.axis = .horizontal
		quantityStackView.translatesAutoresizingMaskIntoConstraints = false
		
		let cellStackView = UIStackView(arrangedSubviews: [nameLabel, separatorView, priceStackView, quantityStackView])
		cellStackView.axis = .vertical
		cellStackView.translatesAutoresizingMaskIntoConstraints = false
		cellStackView.distribution = .fill
		cellStackView.spacing = 8
		
		cellStackView.setCustomSpacing(32, after: separatorView)
		
		addSubview(cellStackView)
		
		cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
		cellStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
	
	func configure(with article: Article) {
		nameLabel.text = article.name
		priceValueLabel.text = "\(article.price) руб."
		quantityValueLabel.text = "\(article.quantity) шт."
	}
}
