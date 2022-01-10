//
//  SchoolTableViewCell.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/8/22.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    var school: School? {
        didSet {
            schoolNameLabel.text = school?.schoolName
            schoolCityLabel.text = school?.schoolCity
            schoolBoroLabel.text = school?.schoolBoro
            schoolOverviewLabel.text = school?.schoolOverview
            
            if let boro = school?.schoolBoro {
                switch boro {
                case "M":
                    borderView.backgroundColor = schoolListCellBackgroundColor.manhattanBackgroundColor
                case "K":
                    borderView.backgroundColor = schoolListCellBackgroundColor.brooklynBackgroundColor
                case "X":
                    borderView.backgroundColor = schoolListCellBackgroundColor.bronxBackgroundColor
                case "Q":
                    borderView.backgroundColor = schoolListCellBackgroundColor.queenBackgroundColor
                case "R":
                    borderView.backgroundColor = schoolListCellBackgroundColor.statenIslandBackgroundColor
                default:
                    borderView.backgroundColor = .white
                }
            }
        }
    }
    
    let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "School Name"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    let schoolCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City, zip"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    let schoolBoroLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Boro"
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.textAlignment = .center
        
        return label
    }()
    
    let schoolOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "School Overview"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    // configure the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        borderView.addSubview(schoolNameLabel)
        schoolNameLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 8).isActive = true
        schoolNameLabel.leftAnchor.constraint(equalTo: borderView.leftAnchor, constant: 8).isActive = true
        schoolNameLabel.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -8).isActive = true
        
        borderView.addSubview(schoolBoroLabel)
        schoolBoroLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5).isActive = true
        schoolBoroLabel.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -5).isActive = true
        schoolBoroLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        borderView.addSubview(schoolCityLabel)
        schoolCityLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 5).isActive = true
        schoolCityLabel.leftAnchor.constraint(equalTo: borderView.leftAnchor, constant: 5).isActive = true
        schoolCityLabel.rightAnchor.constraint(equalTo: schoolBoroLabel.leftAnchor, constant: 5).isActive = true
        
        borderView.addSubview(schoolOverviewLabel)
        schoolOverviewLabel.topAnchor.constraint(equalTo: schoolCityLabel.bottomAnchor, constant: 5).isActive = true
        schoolOverviewLabel.leftAnchor.constraint(equalTo: borderView.leftAnchor, constant: 8).isActive = true
        schoolOverviewLabel.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -8).isActive = true
        schoolOverviewLabel.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8).isActive = true
        
        addSubview(borderView)
        borderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        borderView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        borderView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
