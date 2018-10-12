//
//  UIViewController+Extensions.swift
//  refNot
//
//  Created by Gleb Shendrik on 04/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentError(_ error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
    func presentMessage(_ message: String) {
        let alertController = UIAlertController(title: "Message",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}
