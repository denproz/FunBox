//
//  BackEndCell.swift
//  FunBox
//
//  Created by Denis Prozukin on 18.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit
import SnapKit

class BackEndCell: UICollectionViewCell, SelfConfiguringCell {
	static var reuseIdentifier = "BackEndCell"
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textColor = .white
		label.textAlignment = .left
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.highlightedTextColor = .lightText
		return label
	}()
	
	let quantityLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textAlignment = .right
		label.textColor = .white
		label.highlightedTextColor = .lightText
		return label
	}()
	
	let detailDisclosureImage: UIImageView = {
		let imageView = UIImageView()
		let normalImage = UIImage(systemName: "chevron.right")!.withTintColor(.white, renderingMode: .alwaysOriginal)
		let highlightedImage = normalImage.withTintColor(.lightText, renderingMode: .alwaysOriginal)
		imageView.image = normalImage
		imageView.highlightedImage = highlightedImage
		imageView.contentMode = .scaleAspectFit
		return imageView
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
		let rightViewsStack = UIStackView(arrangedSubviews: [quantityLabel, detailDisclosureImage])
		rightViewsStack.axis = .horizontal
		rightViewsStack.spacing = 8
		
		let stackView = UIStackView(arrangedSubviews: [nameLabel, rightViewsStack])
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		
		addSubview(stackView)
		
		stackView.snp.makeConstraints { (make) in
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
			make.top.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-16)
		}
	}
	
	func configure(with article: Article) {
		nameLabel.text = article.name
		quantityLabel.text = "\(article.quantity) шт."
	}
}
