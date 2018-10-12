//
//  AuthenticationService.swift
//  refNot
//
//  Created by Gleb Shendrik on 04/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth
import SwiftyJSON

protocol AuthenticationServiceProtocol {
    func signIn(with credentials: Credentials) -> Observable<User>
}

class AuthenticationService: AuthenticationServiceProtocol {
    func signIn(with credentials: Credentials) -> Observable<User> {
        return Observable.create { observer in
            
            var user: User!
            
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (data, error) in
                
                guard error == nil else {
                    
                    print("puk puk error")
                    return}
                
                let userId = data?.user.email
                let username = data?.user.email
                let email = data?.user.email
                
                user = User(userId: userId!, name: username!, email: email!)
                observer.onNext(user)
            }
            
            return Disposables.create()
        }
    }
    
    func createUser (email: String, passwd: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: passwd) { (data, error) in
            
            if error == nil {
                guard let user = data?.user else { return }
                guard let email = user.email else { return }
                
                UserDefaults.standard.set(true, forKey: "isRegistered")
                
                let userData = ["email": email, "points": 1000] as [String : Any]
                
                completionHandler(true, nil)
            } else {
                completionHandler(false, error)
            }
        }
    }
}
