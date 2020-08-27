//
//  HostTabBarController.swift
//  FunBox
//
//  Created by Denis Prozukin on 21.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit
import CSV

class HostTabBarVC: UITabBarController {
	private var storeFrontVC: StoreFrontVC!
	private var backEndVC: BackEndVC!
	private var parsingService: ParsingService = CSVParser()
	
	private var storeFrontArticles = [Article]()
	private var articles = [Article]() {
		didSet {
			storeFrontArticles = articles.filter { $0.quantity > 0 }
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loadArticles()
		
		NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: .didUpdateData, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(addData), name: .didAddData, object: nil)
		
		storeFrontVC = StoreFrontVC(articles: articles)
		backEndVC = BackEndVC(articles: articles)
		
		viewControllers = [storeFrontVC, backEndVC].map {
			UINavigationController(rootViewController: $0)
		}
		
		storeFrontVC.configureNavigationBar(title: "Store-Front")
		storeFrontVC.configureTabBarItemWithSFSymbols(title: "Store-Front",
																									unselectedName: "cart",
																									selectedName: "cart.fill")
		
		backEndVC.configureNavigationBar(title: "Back-End", preferredLargeTitle: true, isNavBarHidden: false)
		backEndVC.configureTabBarItemWithSFSymbols(title: "Back-End",
																							 unselectedName: "wrench",
																							 selectedName: "wrench.fill")
	}
	
	private func loadArticles() {
		parsingService.parse { (articles) in
			self.articles = articles
		}
	}
	
	@objc private func updateData(notification: Notification) {
		if let article = notification.userInfo?["article"] as? Article {
			if let index = articles.firstIndex(where: {$0.id == article.id}) {
				articles[index] = article
				storeFrontVC.articles = storeFrontArticles
				backEndVC.articles = articles
			}
		}
	}
	
	@objc private func addData(notification: Notification) {
		if let article = notification.userInfo?["article"] as? Article {
			articles.append(article)
			storeFrontVC.articles = storeFrontArticles
			backEndVC.articles = articles
		}
	}
}

