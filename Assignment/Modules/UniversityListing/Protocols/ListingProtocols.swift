//
//  ListingViewProtocol.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation

//MARK: ListingViewProtocol
protocol ListingViewProtocol: AnyObject {
    func showUniversities(_ universities: [University])
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func refreshData()
}

//MARK: ListingPresenterProtocol
protocol ListingPresenterProtocol: AnyObject {
    var view: ListingViewProtocol? { get set }
    func viewDidLoad()
    func didSelectUniversity(_ university: University)
    func refreshUniversities()
}

//MARK: ListingRouterProtocol
protocol ListingRouterProtocol: AnyObject {
    func navigateToDetails(for university: University)
}
