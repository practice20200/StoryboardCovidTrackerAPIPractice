//
//  ViewController.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-14.
//

import UIKit
import Charts

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
        table.register(ViewControllerTableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .systemYellow
        return table
    }()
    
    private var dayData: [DayData] = [] {
        didSet{
            DispatchQueue.main.async{ [weak self] in
                self?.tableView.reloadData()
                self?.createGraph()
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
    
    private func createGraph(){
        let headerView = UIView( frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.5))
        headerView.clipsToBounds = true
        view.backgroundColor = .systemBackground
        
        let chart = BarChartView(frame:  CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.5))
        let set = dayData.prefix(30)
        var entries: [BarChartDataEntry] = []
        
        for index in 0 ..< set.count {
            let data = set[index]
            entries.append(.init(x: Double(index), y: Double(data.count)))
        }
        
        let dataSet = BarChartDataSet( entries: entries )
        let data: BarChartData = BarChartData(dataSet: dataSet)
        chart.data =  data
        
        //Layout
        dataSet.colors = ChartColorTemplates.pastel()
        chart.rightAxis.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.dragDecelerationEnabled = true
        chart.dragDecelerationFrictionCoef = 0.6
        chart.backgroundColor = .systemBackground
        chart.doubleTapToZoomEnabled = false
        chart.animate(xAxisDuration: 0.0, yAxisDuration: 2.0, easingOption: .easeOutQuart)
//        chart.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        
        headerView.addSubview(chart)
        tableView.tableHeaderView = headerView
    }
    
    @objc func nationalHandler(){
         let vc = FilterViewController()
         vc.completion = { [weak self] state in
            self?.scope = .state(state)
            self?.fetchData()
            self?.barbuttonTitle = state.name
         }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let data = dayData[indexPath.row]
        cell.dateLable.text = DateFormatter.modifiedStyleDayFormatter.string(from: data.date)
        cell.numberLabel.text = String(data.count)
        
        return cell
    }
    
    private func createText(with data: DayData) -> String?{
        let dateString = DateFormatter.modifiedStyleDayFormatter.string(from: data.date)
        return "\(dateString): \(data.count)"
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Date / Number"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .secondarySystemBackground
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let uiView = UIView()
//        uiView.backgroundColor = .systemBackground
//    }
}

