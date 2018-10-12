//
//  MenuService.swift
//  refNot
//
//  Created by Gleb Shendrik on 08/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//


protocol HasMenuService {
    var menuService: MenuService { get }
}

class MenuService {
    func wishlistMenu () -> [Menu] {
        return MenuRepository.menus.filter { !$0.watched }
    }
}
