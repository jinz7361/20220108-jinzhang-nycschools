//
//  SchoolDetailViewController.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/9/22.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    // MARK: - Variables
    var school: School? {
        didSet {
            if let dbn = school?.dbn {
                fetchSchoolSATResult(dbn)
            }
        }
    }
    
    let cellID = "schoolDetailTableCell"
    let schoolDetailTable = UITableView()
    
    private var schoolSATRecordClient: SchoolSATRecordClient?
    private var schoolSATRecord: SchoolSATRecord?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "School Information"
        view.backgroundColor = .white
        self.configureTabel(tableView: schoolDetailTable)
        
    }
    
    // Configure tableview
    private func configureTabel(tableView: UITableView) {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SchoolDetailTableCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    // Fetch School SAT results
    private func fetchSchoolSATResult(_ dbn: String) {
        schoolSATRecordClient = SchoolSATRecordClient()
        
        schoolSATRecordClient?.fetchSchoolSATRecord(dbn, completion: { schoolSATRecord, error in
            if error != nil {
                print(error!)
            } else {
                if let schoolSATRecord = schoolSATRecord {
                    self.schoolSATRecord = schoolSATRecord
                    
                    DispatchQueue.main.async {
                        self.schoolDetailTable.reloadData()
                    }
                }
            }
        })
    }
}

// MARK: - TableViewDataSource and TableViewDelegate
extension SchoolDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SchoolDetailTableCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.school = self.school
        cell.setupSATScores(self.schoolSATRecord)
        
        return cell
    }
    
}
