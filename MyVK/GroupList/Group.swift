//
//  Group.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 07/02/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

struct Group {
    let name: String
    let about: String
    let image: UIImage
    
    static func fetchGroup() -> [Group] {
        let g1 = Group(name: "Mercedes-Benz (W205)", about: "Auto", image: .init(imageLiteralResourceName: "mercedes"))
        let g2 = Group(name: "Wylsacom", about: "MediaGroup", image: .init(imageLiteralResourceName: "wylsa"))
        let g3 = Group(name: "MyNefteyugansk", about: "News", image: .init(imageLiteralResourceName: "yugansk"))
        let g4 = Group(name: "Appleinsider", about: "MediaGroup", image: .init(imageLiteralResourceName: "appleisider"))
        return [g1, g2, g3, g4]
    }
}
