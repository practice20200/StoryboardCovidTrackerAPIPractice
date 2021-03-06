//
//  FilterViewControllerTableViewCell.swift
//  StroryboardCovidTrackerAPIPractice
//
//  Created by Apple New on 2022-06-15.
//

import UIKit
import Elements

class FilterViewControllerTableViewCell: UITableViewCell {
    
    lazy var numberLabel: BaseUILabel = {
        let label = BaseUILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var arrowImageView: BaseUIImageView = {
        let iv = BaseUIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iv.layer.cornerRadius = 15
        iv.contentMode = .center
        iv.clipsToBounds = true
        return iv
    }()


    lazy var contentStack: HStack = {
        let stack = HStack()
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(arrowImageView)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    func setupView() {
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant:  15),
            contentStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
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
