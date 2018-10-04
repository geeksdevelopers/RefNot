//
//  AuthorizationViewModel.swift
//  refNot
//
//  Created by Gleb Shendrik on 02/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import Foundation
import RxSwift


protocol User {
    var emailText: BehaviorSubject<String> {get set}
    var passwordText: BehaviorSubject<String> {get set}
}

struct AuthorizationViewModel: User {
    var emailText = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { email, password in
            
            email.count >= 3 && password.count >= 3
        }
    }
}
