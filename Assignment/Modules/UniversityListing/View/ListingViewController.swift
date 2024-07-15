//
//  ListingViewController.swift
//  Assignment
//
//  Created by Nakul Sharma on 15/07/24.
//

import UIKit

class ListingViewController: UITableViewController {
    var presenter: ListingPresenterProtocol!
    private var universities: [University] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.title = "List of Universities"
            setupTableView()
            presenter.viewDidLoad()
        }

        private func setupTableView() {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UniversityCell")
        }
}

// MARK: - UITableViewDataSource
extension ListingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath)
        
        let university = universities[indexPath.row]
        
        // Configure the cell
        var content = cell.defaultContentConfiguration()
        content.text = university.name
        content.secondaryText = university.country
        
        // Ensure the cell can display the full name without truncation
        content.textProperties.numberOfLines = 0
        content.secondaryTextProperties.numberOfLines = 1
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListingViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUniversity = universities[indexPath.row]
        presenter.didSelectUniversity(selectedUniversity)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Provide an estimated height for performance optimization
    }
}

// MARK: - ListingViewProtocol
extension ListingViewController: ListingViewProtocol {
    func showUniversities(_ universities: [University]) {
        self.universities = universities
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        // Show loading indicator (e.g., activity indicator)
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    func hideLoading() {
        // Hide loading indicator
        navigationItem.rightBarButtonItem = nil
    }
    
    func refreshData() {
        presenter.refreshUniversities()
    }
}
