//
//  UIView+Extensions.swift
//  FunBox
//
//  Created by Denis Prozukin on 17.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

extension UIView {
	func addGradientBackground(firstColor: UIColor, secondColor: UIColor, cornerRadius: CGFloat = 10) {
		clipsToBounds = true
		layer.masksToBounds = false
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
		gradientLayer.frame = bounds
		gradientLayer.startPoint = CGPoint(x: 0, y: 0.6)
		gradientLayer.endPoint = CGPoint(x: 0, y: 1.3)
		gradientLayer.cornerRadius = cornerRadius
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
