//
//  UICollectionViewCell+Extensions.swift
//  FunBox
//
//  Created by Denis Prozukin on 17.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
	func setUpAppearance(shadowRadius: CGFloat, shadowOpacity: Float, cornerRadius: CGFloat = 10, color: UIColor = .systemRed) {
		backgroundColor = color
		contentView.layer.cornerRadius = layer.cornerRadius
		layer.cornerRadius = cornerRadius
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = shadowOpacity
		layer.shadowRadius = shadowRadius
		layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
	}
}
