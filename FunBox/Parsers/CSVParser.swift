//
//  CSVParser.swift
//  FunBox
//
//  Created by Denis Prozukin on 25.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation
import CSV

class CSVParser: ParsingService {
	var articles: [Article] = []
	
	func parse(completion: @escaping ([Article]) -> Void) {
		guard let bundlePath = Bundle.main.path(forResource: "data", ofType: "csv"), let stream = InputStream(fileAtPath: bundlePath) else { return }
		do {
			let csv = try CSVReader(stream: stream, trimFields: true)
			while let row = csv.next() {
				let article = Article(fromRow: row)
				articles.append(article)
			}
			completion(articles)
		} catch let error {
			print("There was an error parsing csv: \(error.localizedDescription)")
		}
	}
}



