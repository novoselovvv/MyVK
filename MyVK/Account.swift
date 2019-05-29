//
//  Account.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 29/05/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class Account: NSObject {
    private override init() { }
    
    public static let shared = Account()
    
    var tokken: String?
    var id: String?
}
