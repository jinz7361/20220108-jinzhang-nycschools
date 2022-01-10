//
//  schoolSATRecord.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/9/22.
//

import Foundation

// Model for school SAT Record
struct SchoolSATRecord: Codable {
    let dbn: String
    let schoolName: String
    let numOfSATTestTaker: String
    let readingAvgScore: String
    let mathAvgScore: String
    let writingAvgScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case numOfSATTestTaker = "num_of_sat_test_takers"
        case readingAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
}
