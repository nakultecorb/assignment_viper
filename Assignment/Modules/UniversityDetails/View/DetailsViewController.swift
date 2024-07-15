//
//  DetailsViewController.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import UIKit

class DetailsViewController: UIViewController {
    var presenter: DetailsPresenterProtocol!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        self.navigationItem.backButtonTitle = ""
        presenter.viewDidLoad()
        setupRefreshButton()
    }
    
    private func setupRefreshButton() {
        let refreshIcon = UIImage(systemName: "arrow.clockwise")
        let refreshButton = UIBarButtonItem(image: refreshIcon, style: .plain, target: self, action: #selector(refreshButtonTapped))
        refreshButton.tintColor = .black
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc private func refreshButtonTapped() {
        presenter.refreshButtonTapped()
    }
    
}

extension DetailsViewController: DetailsViewProtocol {
    func displayUniversityDetails(_ university: University) {
        nameLabel.text = university.name
        stateLabel.text = university.stateProvince ?? "Not Available"
        countryLabel.text = university.country
        countryCodeLabel.text = university.countryCode
        websiteLabel.text = university.webPages.first ?? "Not Available"
    }
}
