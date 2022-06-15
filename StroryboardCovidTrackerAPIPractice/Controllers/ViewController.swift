//
//  ViewController.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-14.
//

import UIKit

class ViewController: UIViewController {

    private var scope: APICaller.DataScop = .national
    
    lazy var barbuttonTitle : String = {
        switch scope{
            case .national: return "National"
            case .state(let state): return state.name
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "COVID CASES"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
        
        let nationalBTN = UIBarButtonItem(title: barbuttonTitle, style: .done, target: self, action: #selector(nationalHandler))
        navigationItem.rightBarButtonItem = nationalBTN
    }
    
    private func fetchData(){
        APICaller.shared.getCovidData(for: scope) { result in
            switch result {
            case .success(let data): print("Success ftechData() in ViewController")
            case .failure(let error): print("Error fetchData in ViewController:): \(error.localizedDescription)")
            }
        }
    }
    
    @objc func nationalHandler(){
         let vc = FilterViewController()
         let navVC = UINavigationController(rootViewController: vc)
         present(navVC, animated: true)
    }


}

