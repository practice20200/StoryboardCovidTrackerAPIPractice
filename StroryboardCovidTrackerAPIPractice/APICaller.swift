//
//  File.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-15.
//

import Foundation
class APICaller{
    static let shared = APICaller()
    private init() {}
    
    private struct Constants{
        static let allStatesURL = URL(string: "https://api.covidtracking.com/v2/states.json")
    }
    
    enum DataScop{
        case national
        case state(State)
    }
    
    public func getCovidData(for scope: Data, completion: @escaping((Result<String, Error>) -> Void)){}
    
    public func getStateList(completion: @escaping((Result<[State], Error>) -> Void)){
        guard let url = Constants.allStatesURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(StateListResponse.self, from: data)
                let states = result.data
                completion(.success(states))
            }
            catch{
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


