//
//  SchoolDetailTableCell.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/9/22.
//

import UIKit
import MapKit

class SchoolDetailTableCell: UITableViewCell {
    var school: School? {
        didSet {
            schoolNameLabel.text = school?.schoolName
            schoolOverviewLabel.text = school?.schoolOverview
            
            if let lat = school?.Latitude, let lot = school?.Longitude {
                self.addSchoolAnnotation(Double(lat) ?? 0.0, Double(lot) ?? 0.0)
            }
        }
    }
    
    lazy var schoolMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        
        return mapView
    }()
    
    lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    lazy var schoolOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    lazy var numOfSATTakers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of SAT Test Takers: "
        
        return label
    }()
    
    lazy var readingScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Average Reading Score: "
        
        return label
    }()
    
    lazy var mathScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Average Math Score: "
        
        return label
    }()
    
    lazy var writingScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Average Writing Score: "
        
        return label
    }()
    
    lazy var schoolSATRecordView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(numOfSATTakers)
        numOfSATTakers.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        numOfSATTakers.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        numOfSATTakers.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        view.addSubview(readingScore)
        readingScore.topAnchor.constraint(equalTo: numOfSATTakers.bottomAnchor, constant: 3).isActive = true
        readingScore.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        readingScore.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        view.addSubview(mathScore)
        mathScore.topAnchor.constraint(equalTo: readingScore.bottomAnchor, constant: 3).isActive = true
        mathScore.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        mathScore.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        view.addSubview(writingScore)
        writingScore.topAnchor.constraint(equalTo: mathScore.bottomAnchor, constant: 3).isActive = true
        writingScore.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        writingScore.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        return view
    }()
    
    // configure the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(schoolMapView)
        schoolMapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        schoolMapView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        schoolMapView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        schoolMapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(schoolNameLabel)
        schoolNameLabel.topAnchor.constraint(equalTo: schoolMapView.bottomAnchor, constant: 16).isActive = true
        schoolNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        schoolNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        addSubview(schoolOverviewLabel)
        schoolOverviewLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5).isActive = true
        schoolOverviewLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        schoolOverviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: schoolOverviewLabel.bottomAnchor, constant: 16).isActive = true
        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(schoolSATRecordView)
        schoolSATRecordView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16).isActive = true
        schoolSATRecordView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        schoolSATRecordView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        schoolSATRecordView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }
    
    // Add selected school to map
    private func addSchoolAnnotation(_ lat: Double, _ lot: Double) {
        let schoolAnnotation = MKPointAnnotation()
        schoolAnnotation.title = self.school?.schoolName
        schoolAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lot)
        schoolMapView.addAnnotation(schoolAnnotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: schoolAnnotation.coordinate, span: span)
        schoolMapView.setRegion(region, animated: true)
    }
    
    // configure fetched SAT results
    func setupSATScores(_ schoolSATRecord: SchoolSATRecord?) {
        numOfSATTakers.text = "Number of SAT Test Takers: " + (schoolSATRecord?.numOfSATTestTaker ?? "N/A")
        readingScore.text = "Average Reading Score: " +  (schoolSATRecord?.readingAvgScore ?? "N/A")
        mathScore.text = "Average Math Score: " + (schoolSATRecord?.mathAvgScore ?? "N/A")
        writingScore.text = "Average Writing Score: " + (schoolSATRecord?.writingAvgScore ?? "N/A")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
