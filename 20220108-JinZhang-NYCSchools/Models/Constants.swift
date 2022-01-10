//
//  Constants.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/8/22.
//

import Foundation
import UIKit

public let schoolsURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$select=dbn,school_name,overview_paragraph,city,boro,Latitude,Longitude"
public let schoolSATResultsURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"

struct schoolListCellBackgroundColor {
    static let manhattanBackgroundColor = UIColor(red: 255/255, green: 228/255, blue: 122/255, alpha: 1.0) /* #ffe47a */

    static let brooklynBackgroundColor = UIColor(red: 255/255, green: 169/255, blue: 135/255, alpha: 1.0) /* #ffa987 */

    static let queenBackgroundColor = UIColor(red: 135/255, green: 235/255, blue: 255/255, alpha: 1.0) /* #87ebff */

    static let bronxBackgroundColor = UIColor(red: 163/255, green: 255/255, blue: 135/255, alpha: 1.0) /* #a3ff87 */

    static let statenIslandBackgroundColor = UIColor(red: 255/255, green: 135/255, blue: 203/255, alpha: 1.0) /* #ff87cb */
}
