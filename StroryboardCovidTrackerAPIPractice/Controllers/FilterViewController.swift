//
//  FilterViewController.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-14.
//

import UIKit

class FilterViewController: UIViewController {
    
    var completion: ((State) -> Void)?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .red
        return table
    }()
    
    private var states: [State] = [] {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Select State"
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        fetchStates()
        
        let closeBTN = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeHandler))
        navigationItem.rightBarButtonItem = closeBTN
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchStates(){
        APICaller.shared.getStateList { [weak self] result in
            switch result {
            case .success(let states):
                self?.states = states
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func closeHandler(){
        dismiss(animated: true, completion: nil)
    }

}


extension FilterViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let state = states[indexPath.row]
        completion?(state)
        dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = states[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = state.name
        return cell
    }
    
    
}
