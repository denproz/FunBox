//
//  XMLParser.swift
//  FunBox
//
//  Created by Denis Prozukin on 26.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation
import SWXMLHash

class XMLParser: ParsingService {
	var articles: [Article] = []
	
	func parse(completion: @escaping ([Article]) -> Void) {
		guard let path = Bundle.main.path(forResource: "data", ofType: "xml") else { return }
		let url = URL(fileURLWithPath: path)
		do {
			let data = try Data(contentsOf: url)
			let xml = SWXMLHash.parse(data)
			for elem in xml["root"]["element"].all {
				let name = elem["name"].element!.text
				let price = Double(elem["price"].element!.text)!
				let quantity = Int(elem["quantity"].element!.text)!
				let article = Article(name: name, price: price, quantity: quantity)
				articles.append(article)
			}
			completion(articles)
		} catch let error {
			print(error.localizedDescription)
		}
	}
}
