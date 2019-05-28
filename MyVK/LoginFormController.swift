//
//  LoginFormController.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 17/12/2018.
//  Copyright © 2018 Виктор Новосёлов. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    // MARK: Переменные
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Жизненый цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor.lightGray
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваеваем его UIScrollView
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // второе - когда она пропадет
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Насктройка клавиатуры
    
    // когда клавиатура появится
    @objc func keyboardWasShown(notification: Notification) {
        // получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
        
    }
    
    // метод подтверждающий переход
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // проверяем данные
        let checkResult = checkUserData()
        // если данные не верны, вызываем ошибку
        if !checkResult {
            showLoginError()
        }
        // вернем результат
        return checkResult
    }
    
    func checkUserData() -> Bool {
        // получаем текст логина
        let login = loginTextField.text!
        // получаем текст пароля
        let password = passwordTextField.text!
        // проверяем верны ли они
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные", preferredStyle: .alert)
        // создаем кнопку
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // добавляем кнопку
        alert.addAction(action)
        // показываем сообщение
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
    }
    
}
