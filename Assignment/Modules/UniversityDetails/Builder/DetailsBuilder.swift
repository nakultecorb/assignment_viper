//
//  DetailsBuilder.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import UIKit

class DetailsBuilder {
    static func build(with university: University, listingViewController: ListingViewProtocol) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        let router = DetailsRouter(viewController: viewController, listingViewController: listingViewController)
        let presenter = DetailsPresenter(view: viewController, router: router, university: university)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
