//
//  ViewControllerTableViewCell.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-16.
//

import UIKit
import Elements

class ViewControllerTableViewCell: UITableViewCell {
    
    lazy var dateLable: BaseUILabel = {
        let label = BaseUILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    lazy var numberLabel: BaseUILabel = {
        let label = BaseUILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()


    lazy var contentStack: HStack = {
        let stack = HStack()
        stack.addArrangedSubview(dateLable)
        stack.addArrangedSubview(numberLabel)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    func setupView() {
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant:  20),
            contentStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            contentStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
    }

}
