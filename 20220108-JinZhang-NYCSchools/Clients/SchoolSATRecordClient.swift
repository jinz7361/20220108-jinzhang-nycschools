//
//  SchoolSATRecordClient.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Jin on 1/9/22.
//

import UIKit

class SchoolSATRecordClient {
    var session: URLSession?
    
    // Make a request to fetch school SAT result from dbn, return a schoolSATRecord
    func fetchSchoolSATRecord(_ dbn: String, completion: @escaping (SchoolSATRecord?, Error?) -> Void) {
        guard let url = URL(string: schoolSATResultsURL + "?dbn=\(dbn)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let strData = String(data: data, encoding: .utf8)!
            do {
                let jsonDecoder = JSONDecoder()
                let schoolSATRecords = try jsonDecoder.decode([SchoolSATRecord].self, from: Data(strData.utf8))
                if !schoolSATRecords.isEmpty {
                    completion(schoolSATRecords[0], nil)
                } else {
                    completion(nil, error)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
