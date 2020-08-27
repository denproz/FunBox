//
//  ParsingService.swift
//  FunBox
//
//  Created by Denis Prozukin on 26.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation

enum ParsingError: Error {
	case failedToGetData
	case failedToParseData
}

protocol ParsingService {
	var articles: [Article] { get set }
	func parse(completion: @escaping ([Article]) -> Void)
}
