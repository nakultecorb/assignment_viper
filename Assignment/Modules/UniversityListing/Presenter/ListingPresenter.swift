//
//  ListingPresenter.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation
class ListingPresenter: ListingPresenterProtocol {
    weak var view: ListingViewProtocol?
    private let interactor: ListingInteractorProtocol
    private let router: ListingRouterProtocol
    
    init(view: ListingViewProtocol, interactor: ListingInteractorProtocol, router: ListingRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoading()
        fetchUniversities()
    }
    
    func refreshUniversities() {
        fetchUniversities()
    }
    
    private func fetchUniversities() {
        interactor.fetchUniversities { [weak self] result in
            self?.view?.hideLoading()
            switch result {
            case .success(let universities):
                self?.view?.showUniversities(universities)
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    self?.view?.showError(networkError.message)
                } else {
                    self?.view?.showError("An unexpected error occurred.")
                }
            }
        }
    }
    
    func didSelectUniversity(_ university: University) {
        router.navigateToDetails(for: university)
    }
}


