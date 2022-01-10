//
//  ViewController.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/8/22.
//

import UIKit

class SchoolViewController: UIViewController {
    // MARK: - Variables
    private var client: SchoolClient?
    private var schools = [School]()
    
    let cellId = "schoolCell"
    let schoolTabel = UITableView()
    
    // Search Controller
    var resultSearchController = UISearchController()
    private var filteredSchools = [School]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = SchoolClient()
        self.configureTable(tableView: self.schoolTabel)
        
        // Fetch school data and display in the tableview
        client?.fetchSchoolData(completion: { schools, error in
            if error != nil {
                print(error!)
            } else {
                if let schools = schools {
                    self.schools.append(contentsOf: schools)
                    
                    DispatchQueue.main.async {
                        self.schoolTabel.reloadData()
                    }
                }
            }
        })
        
        title = "NYC Schools"
        self.view.backgroundColor = .white
    }

    // Configure tableview
    private func configureTable(tableView: UITableView) {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Add search controller to the tableview
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
}

// MARK: - TableViewDataSource and TableViewDelegate
extension SchoolViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredSchools.count
        } else {
            return schools.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SchoolTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        if (resultSearchController.isActive) {
            let school = self.filteredSchools[indexPath.row]
            cell.school = school
        } else {
            let school = self.schools[indexPath.row]
            cell.school = school
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schoolDetailView = SchoolDetailViewController()
        
        if (resultSearchController.isActive) {
            let school = self.filteredSchools[indexPath.row]
            schoolDetailView.school = school
            self.resultSearchController.isActive = false
        } else {
            let school = self.schools[indexPath.row]
            schoolDetailView.school = school
        }
        
        self.navigationController?.pushViewController(schoolDetailView, animated: true)
    }
}

// MARK: - Search Results Update
extension SchoolViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredSchools.removeAll(keepingCapacity: false)
        
        self.filteredSchools = self.schools.filter({ (school) -> Bool in
            return school.schoolName.lowercased().contains(searchController.searchBar.text!.lowercased())
        })

        self.schoolTabel.reloadData()
    }
}
