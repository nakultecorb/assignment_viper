//
//  ListingBuilder.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import UIKit

class ListingBuilder {
    static func build() -> ListingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListingViewController") as! ListingViewController
        
        let interactor = ListingInteractor(networkService: NetworkService(), cacheManager: CacheManager.shared)
        let router = ListingRouter(viewController: viewController)
        let presenter = ListingPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
