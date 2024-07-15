//
//  ListingRouter.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import UIKit

class ListingRouter: ListingRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToDetails(for university: University) {
        guard let listingVC = viewController as? ListingViewProtocol else { return }
        let detailsVC = DetailsBuilder.build(with: university, listingViewController: listingVC)
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
