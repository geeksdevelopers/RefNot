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
import RxFlow

enum DemoStep: Step {
    case apiKey
    case apiKeyIsComplete
    
    case movieList
    
    case moviePicked (withMovieId: Int)
    case castPicked (withCastId: Int)
    
    case settings
    case settingsDone
    case about
}


class AuthorizationViewController: UIViewController {
    typealias ViewModelType = AuthorizationViewModel
    
    //    MARK: UI
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userAuth: UIButton!
    @IBOutlet weak var userReg: UIButton!
    @IBOutlet weak var userRecovery: UIButton!
    
    //    MARK: Properties
    var authorizationViewModel: ViewModelType!
    let disposeBag = DisposeBag()
    
    //    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        configure(with: authorizationViewModel)
    }
    
    //    MARK: Functions
    func configure(with viewModel: ViewModelType) {
        userLogin.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.email)
            .disposed(by: disposeBag)
        
        userPassword.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.password)
            .disposed(by: disposeBag)
        
        userAuth.backgroundColor = viewModel.btnColor
        userAuth.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)
        
        viewModel.output.errorsObservable
            .subscribe(onNext: { [unowned self] (error) in
                self.presentError(error)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.loginResultObservable
            .subscribe(onNext: { [unowned self] (user) in
                self.presentMessage("User successfully signed in")
            })
            .disposed(by: disposeBag)
        
//        userAuth.backgroundColor = authorizationViewModel.btnColor
//        userAuth.titleLabel?.font = authorizationViewModel.btnTextSize
//        _ = userLogin.rx.text.map{$0 ?? ""}.bind(to: authorizationViewModel.emailText)
//        _ = userPassword.rx.text.map{$0 ?? ""}.bind(to: authorizationViewModel.passwordText)
//
//        _ = authorizationViewModel.isValid.bind(to: userAuth.rx.isEnabled)
//        authorizationViewModel.isValid.subscribe(onNext: {[unowned self] isValid in
//            self.authLabel.textColor = isValid ? .green : .red
//            //            self.authLabel.text = isValid ? "Enabled" : "Not Enabled"
//            print("isValid \(isValid)")
//        }).disposed(by: disposeBag)
    }
    
    @IBAction func userAuth(_ sender: Any) {
        

        
        //      Успешно авторизовались
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userReg(_ sender: Any) {
    }
    
    @IBAction func userRecovery(_ sender: Any) {
    }
    
}
extension AuthorizationViewController {
    static func create(with viewModel: ViewModelType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AuthorizationController") as! AuthorizationViewController
        controller.authorizationViewModel = viewModel
        return controller
    }
}
