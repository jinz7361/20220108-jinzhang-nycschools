//
//  SchoolClient.swift
//  20220108-JinZhang-NYCSchools
//
//  Created by Grace on 1/8/22.
//

import Foundation

class SchoolClient {
    var session: URLSession?
    
    // Make request to fetch school data, return an array of school
    func fetchSchoolData(completion: @escaping ([School]?, Error?) -> Void) {
        guard let url = URL(string: schoolsURL) else {
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
                let schools = try jsonDecoder.decode([School].self, from: Data(strData.utf8))
                completion(schools, nil)
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
