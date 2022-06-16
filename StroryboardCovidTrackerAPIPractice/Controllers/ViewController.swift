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
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .systemYellow
        return table
    }()
    
    private var dayData: [DayData] = [] {
        didSet{
            DispatchQueue.main.async{ [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "COVID CASES"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        let nationalBTN = UIBarButtonItem(title: barbuttonTitle, style: .done, target: self, action: #selector(nationalHandler))
        navigationItem.rightBarButtonItem = nationalBTN
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func fetchData(){
        APICaller.shared.getCovidData(for: scope) { [weak self] result in
            
            switch result {
            case .success(let dayData): print("Success ftechData() in ViewController")
                self?.dayData = dayData
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


extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("=============daydata:\(dayData.count)")
        return dayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = dayData[indexPath.row]
        cell.textLabel?.text = createText(with: data)
        return cell
    }
    
    private func createText(with data: DayData) -> String?{
        let dateString = DateFormatter.modifiedStyleDayFormatter.string(from: data.date)
        return "\(dateString): \(data.count)"
    }
}
