//
//  OtherGroupTableViewController.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 09/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class OtherGroupTableViewController: UITableViewController, UISearchBarDelegate {
    
    var otherGroupList = ["1", "2", "3"]
    var selectedGroup = ""

    @IBOutlet weak var mySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySearchBar.delegate = self
        
//        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//
//        tableView.addGestureRecognizer(hideKeyboardGesture)
     }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherGroupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OtherGroupTableViewCell
        cell.otherGroupLabel.text = otherGroupList[indexPath.row]
        return cell
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selected = otherGroupList[indexPath.row]
        selectedGroup = selected
        return indexPath
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        let text = mySearchBar.text!
        if text != "" {
            if otherGroupList.contains(text) {
                otherGroupList = [text]
                tableView.reloadData()
            } else {
                showLoginError()
            }
        }
    }
    
    func showLoginError() {
        // создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Такой группы нет", preferredStyle: .alert)
        // создаем кнопку
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // добавляем кнопку
        alert.addAction(action)
        // показываем сообщение
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        self.tableView.endEditing(true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! GroupTableViewController
//        destVC.groupList.append(selectedGroup)
    }
}
