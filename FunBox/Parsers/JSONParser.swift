//
//  JSONParser.swift
//  FunBox
//
//  Created by Denis Prozukin on 26.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation

class JSONParser: ParsingService {
	var articles: [Article] = []
	
	func parse(completion: @escaping ([Article]) -> Void) {
		guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
		let url = URL(fileURLWithPath: path)
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			let arrayOfArticles = try decoder.decode([Article].self, from: data)
			articles = arrayOfArticles
			completion(articles)
		} catch let error {
			print(error.localizedDescription)
		}
	}
	
	
}
