//
//  BuyButton.swift
//  FunBox
//
//  Created by Denis Prozukin on 17.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpButton()
	}
	
	override var isEnabled: Bool {
		didSet {
			backgroundColor = isEnabled ? .systemGreen : .systemGray
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not a storyboard button, na-ah.")
	}
	
	convenience init(title: String) {
		self.init()
		setTitle(title, for: .normal)
	}
	
	func setUpButton() {
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		titleLabel?.textColor = .white
		titleLabel?.adjustsFontSizeToFitWidth = true
		backgroundColor = .systemGreen
		setTitle("Купить", for: .normal)
		
		layer.cornerRadius = 25
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowRadius = 8
		layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
	}
}
