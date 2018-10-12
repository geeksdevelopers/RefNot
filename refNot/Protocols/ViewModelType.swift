//
//  ViewModelType.swift
//  refNot
//
//  Created by Gleb Shendrik on 04/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
}
