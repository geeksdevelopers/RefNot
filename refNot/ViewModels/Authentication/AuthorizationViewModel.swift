//
//  AuthorizationViewModel.swift
//  refNot
//
//  Created by Gleb Shendrik on 02/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import Foundation
import RxSwift


protocol UserProtocol {
    var emailText: BehaviorSubject<String> {get set}
    var passwordText: BehaviorSubject<String> {get set}
}

protocol TextValid {
    var isValid: Observable<Bool> {get}
}

protocol TextFormatType {
    var btnColor: UIColor {get}
    var btnTextColor: UIColor {get}
    var btnTextSize: UIFont {get}
}

extension TextFormatType {
    var btnColor: UIColor {
        return .burntYellow
    }
    var btnTextColor: UIColor {
        return .white
    }
    var btnTextSize: UIFont {
        return .systemFont(ofSize: 12)
    }
}

extension TextValid {
    
}
    

class AuthorizationViewModel: ViewModelProtocol, TextFormatType {
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let signInDidTap: AnyObserver<Void>
    }
    
    struct Output {
        let loginResultObservable: Observable<User>
        let errorsObservable: Observable<Error>
    }
    // MARK: - Public properties
    let input: Input
    let output: Output
    
    // MARK: - Private properties
    private let emailSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let loginResultSubject = PublishSubject<User>()
    private let errorsSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    private var credentialsObservable: Observable<Credentials> {
        return Observable.combineLatest(emailSubject.asObservable(), passwordSubject.asObservable()) { (email, password) in
            return Credentials(email: email, password: password)
        }
    }
    
    // MARK: - Init and deinit
    init(_ loginService: AuthenticationServiceProtocol) {
        
        input = Input(email: emailSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      signInDidTap: signInDidTapSubject.asObserver())
        
        
        output = Output(loginResultObservable: loginResultSubject.asObservable(),
                        errorsObservable: errorsSubject.asObservable())
        
        signInDidTapSubject
            .withLatestFrom(credentialsObservable)
            .flatMapLatest { credentials in
                return loginService.signIn(with: credentials).materialize()
            }
            .subscribe(onNext: { [weak self] event in
                switch event {
                case .next(let user):
                    self?.loginResultSubject.onNext(user)
                case .error(let error):
                    self?.errorsSubject.onNext(error)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
//
//
//    var emailText = BehaviorSubject<String>(value: "")
//    var passwordText = BehaviorSubject<String>(value: "")
//    var btnTextSize: UIFont = .systemFont(ofSize: 16)
//
//    var isValid: Observable<Bool> {
//        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { email, password in
//
//            email.count >= 3 && password.count >= 3
//        }
//    }
}
