//
//  Alphabet.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 21/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

@IBDesignable class Alphabet: UIControl {
    
    var link: AlphabetViewController?
    
    var lettersButton: [UIButton] = []
    var stackView: UIStackView!

    var abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯ"
    
    func updateStackView(_ letter: Character) {
        for (index, char) in abc.enumerated() {
            if char == letter {
                let a = stackView.arrangedSubviews[index]
                a.isHidden = false
            }
        }
    }
    
    func setupView() {
        for letter in abc {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            button.setTitleColor(.blue, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectLetter(_ :)), for: .touchUpInside)
            lettersButton.append(button)
            button.isHidden = true
        }
        
        stackView = UIStackView(arrangedSubviews: self.lettersButton)
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        var button: [UIButton] = []
        let arrayButtonVisible = stackView.arrangedSubviews
        for i in arrayButtonVisible {
            if !i.isHidden {
                button.append(i as! UIButton)
            }
        }
        let index = button.index(of: sender)
        link?.scrollTable(index!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
}
