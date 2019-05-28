//
//  NewFreindViewController.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 25.01.2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class NewFreindViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newName.becomeFirstResponder()
    }

    // MARK: - Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = newName.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        saveBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        saveBarButton.isEnabled = false
        return true
    }

}
