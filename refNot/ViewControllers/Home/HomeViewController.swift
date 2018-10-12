//
//  HomeViewController.swift
//  refNot
//
//  Created by Gleb Shendrik on 08/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let isAuth = UserDefaults.standard.bool(forKey: "isAuth")
        
                if !isAuth {
        let storyboard1 = UIStoryboard(name: "Authentication", bundle: nil)
        let authVC = storyboard1.instantiateViewController(withIdentifier: "AuthorizationController") as! AuthorizationViewController
        present(authVC, animated: true, completion: nil)
        
                }
    }
}
