//
//  School.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/8/22.
//

import Foundation
import UIKit

// Model for school
struct School: Codable {
    var dbn: String
    var schoolName: String
    var schoolBoro: String?
    var schoolOverview: String
    var schoolCity: String
    var Latitude: String?
    var Longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case schoolBoro = "boro"
        case schoolOverview = "overview_paragraph"
        case schoolCity = "city"
        case Latitude
        case Longitude
    }
}
