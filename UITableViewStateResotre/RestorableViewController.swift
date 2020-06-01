//
//  RestorableViewController.swift
//  UITableViewStateResotre
//
//  Created by Cirno MainasuK on 2020-6-1.
//  Copyright © 2020 MainasuK. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell { }

final class RestorableViewModel: NSObject {
    
    var safeAreaInsets: UIEdgeInsets?
    var contentOffset: CGPoint?
    
}

extension RestorableViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self), for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = "\(indexPath.section): \(indexPath.row)"
        return cell
    }
}

final class RestorableViewController: UIViewController {
    
    var viewModel: RestorableViewModel!
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        tableView.tableFooterView = UIView()
        return tableView
    }()

}

extension RestorableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
        
        tableView.delegate = self
        tableView.dataSource = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let contentOffset = viewModel.contentOffset,
        let safeAreaInsets = viewModel.safeAreaInsets {
            tableView.contentOffset.y = contentOffset.y + safeAreaInsets.top
        }
    }
    
}

// MARK: - UITableViewDelegate
extension RestorableViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.safeAreaInsets = scrollView.safeAreaInsets
        viewModel.contentOffset = scrollView.contentOffset
        print(scrollView.contentOffset)
    }
}
