//
//  AuthorizationViewController.swift
//  refNot
//
//  Created by Gleb Shendrik on 01/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userAuth: UIButton!
    @IBOutlet weak var userReg: UIButton!
    @IBOutlet weak var userRecovery: UIButton!
    
    var authorizationViewModel = AuthorizationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userAuth.backgroundColor = .burntYellow
        
        _ = userLogin.rx.text.map{$0 ?? ""}.bind(to: authorizationViewModel.emailText)
        _ = userPassword.rx.text.map{$0 ?? ""}.bind(to: authorizationViewModel.passwordText)
        
        _ = authorizationViewModel.isValid.bind(to: userAuth.rx.isEnabled)
        authorizationViewModel.isValid.subscribe(onNext: {[unowned self] isValid in
            self.authLabel.textColor = isValid ? .green : .red
//            self.authLabel.text = isValid ? "Enabled" : "Not Enabled"
            print("isValid \(isValid)")
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func userAuth(_ sender: Any) {
    }
    
    @IBAction func userReg(_ sender: Any) {
    }
    
    @IBAction func userRecovery(_ sender: Any) {
    }
    
}
