//
//  SelfConfiguringCell.swift
//  FunBox
//
//  Created by Denis Prozukin on 15.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
	static var reuseIdentifier: String { get set }
	func configure(with article: Article)
}

