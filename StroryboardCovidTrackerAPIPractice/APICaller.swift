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
    
    public func getCovidData(for scope: DataScop, completion: @escaping((Result<[DayData], Error>) -> Void)){
        let urlString: String
        switch scope{
            case .national: urlString = "https://api.covidtracking.com/v2/us/daily.json"
            case .state(let state): urlString = "https://api.covidtracking.com/v2/states/\(state.state_code.lowercased())/daily.json"
        }
        
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(CovidDataResponse.self, from: data)
                print("SUCCESS result: \(result)|| resultcount: \((result).data.count)")
              
            }
            catch{
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
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


