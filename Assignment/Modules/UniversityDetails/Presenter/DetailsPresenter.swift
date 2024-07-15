//
//  DetailsPresenter.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    private let router: DetailsRouterProtocol
    private let university: University
    
    init(view: DetailsViewProtocol, router: DetailsRouterProtocol, university: University) {
        self.view = view
        self.router = router
        self.university = university
    }
    
    func viewDidLoad() {
        view?.displayUniversityDetails(university)
    }
    
    func refreshButtonTapped() {
        router.dismissAndRefreshListing()
    }
}
