//
//  DeatailsProtocols.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import Foundation

//MARK: DetailsViewProtocol
protocol DetailsViewProtocol: AnyObject {
    func displayUniversityDetails(_ university: University)
}

//MARK: DetailsPresenterProtocol
protocol DetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func refreshButtonTapped()
}

//MARK: DetailsRouterProtocol
protocol DetailsRouterProtocol: AnyObject {
    func dismissAndRefreshListing()
}
