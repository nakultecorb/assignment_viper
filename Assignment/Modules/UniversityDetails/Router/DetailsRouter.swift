//
//  DetailsRouter.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
import UIKit

class DetailsRouter: DetailsRouterProtocol {
    weak var viewController: UIViewController?
    weak var listingViewController: ListingViewProtocol?
    
    init(viewController: UIViewController, listingViewController: ListingViewProtocol) {
        self.viewController = viewController
        self.listingViewController = listingViewController
    }
    
    func dismissAndRefreshListing() {
        viewController?.navigationController?.popViewController(animated: true)
        listingViewController?.refreshData()
    }
}
