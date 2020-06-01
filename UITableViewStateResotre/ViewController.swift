//
//  ViewController.swift
//  UITableViewStateResotre
//
//  Created by Cirno MainasuK on 2020-6-1.
//  Copyright © 2020 MainasuK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let restorableViewModel = RestorableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(ViewController.buttonPressed(_:)), for: .touchUpInside)
    }

    @objc private func buttonPressed(_ sender: UIButton) {
        let viewController = RestorableViewController()
        viewController.viewModel = restorableViewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

}

