//
//  Article.swift
//  FunBox
//
//  Created by Denis Prozukin on 15.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation

class Article: Codable, Hashable  {
	var name: String
	var price: Double
	var quantity: Int
	let id = UUID()
	
	private enum CodingKeys: String, CodingKey {
		case name, price, quantity
	}
	
	init(name: String, price: Double, quantity: Int) {
		self.name = name
		self.price = price
		self.quantity = quantity
	}
	
	convenience init(fromRow row: [String]) {
		self.init(name: row[0], price: Double(row[1]) ?? 0.0, quantity: Int(row[2]) ?? 0)
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func == (lhs: Article, rhs: Article) -> Bool {
		lhs.id == rhs.id
	}
}



