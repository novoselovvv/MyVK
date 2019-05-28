//
//  AlphabetViewController.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 21/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit
import Contacts

class AlphabetViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var alphabetView: Alphabet!
    
    // MARK: - Properties
    var abc = [Character]()
    
    var contact: [Contacts]! {
        didSet {
            sortedByKeys(contact)
            tableView.reloadData()
        }
    }
    
    var myContacts = [[Contacts]]()
    let contactSearchController = UISearchController(searchResultsController: nil)
    var filteredContacts = [Contacts]() // массив контактов при поиске
    
    // MARK: - Методы
    
    // Прокручивание таблицы при выборе буквы
    func scrollTable(_ index: Int) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    // Сортировка контактов по первой букве
    func sortedByKeys(_ contact: [Contacts]) {
        var contacts = Dictionary(grouping: contact) { (person) -> Character in
            return person.name.first!
        }
        
        abc = contacts.keys.sorted()
        var newArrayContacts = [[Contacts]]()
        
        abc.forEach { (key) in
//            alphabetView.updateStackView(key)
            newArrayContacts.append(contacts[key]!)
            myContacts = newArrayContacts
        }
    }
    
    // Получение контактов из устройства
    private func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed ti request access:", err)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    var contactMyPhone = [Contacts]()
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        contactMyPhone.append(Contacts(name: contact.givenName + " " + contact.familyName, avatarImage: "blackMale48", contactFotoAlbum: nil))
                        self.contact = contactMyPhone
                    })
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
            } else {
                print("Access denied..")
            }
        }
    }
    
    // Получение массива отфильтрованных контактов при поиске
    func filterContentForSearchText(_ searchText: String) {
        filteredContacts = contact.filter({ (contact: Contacts) -> Bool in
            return contact.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchByEmpty() -> Bool {
        // возвращает true если нет текста или nil
        return contactSearchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return contactSearchController.isActive && !searchByEmpty()
    }
    
    // MARK: - Жизненый цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.dataSource = self
        tableView.delegate = self
//        sortedByKeys(contact)
        
//        alphabetView.link = self
        
        fetchContacts()
        
        // Setup the Search Controller
        contactSearchController.searchResultsUpdater = self
        contactSearchController.obscuresBackgroundDuringPresentation = false // true - скрывает table view и показывает view с результатами
        contactSearchController.searchBar.placeholder = "Search Contact"
        navigationItem.searchController = contactSearchController // добавляет строку поиска в navigation controller
        navigationItem.hidesSearchBarWhenScrolling = false // скрывает или отображает строку поиска при прокрутке
        definesPresentationContext = true // скрывает строку поиска при переходе на другой экран
    }
    
    // MARK: - UnwindSegue
    
    @IBAction func unwindToNewFriendVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! NewFreindViewController
        let name = sourceViewController.newName.text!
        let contact = Contacts(name: name, avatarImage: "blackMale48", contactFotoAlbum: nil)
        self.contact.append(contact)
    }
}

// MARK: - DataSource

extension AlphabetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let contact = myContacts[section].first
        let letter = contact?.name.first
        if contactSearchController.isActive {
            return nil
        } else {
            return String(letter!)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return 1
        } else {
            return myContacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredContacts.count
        } else {
            return myContacts[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendsTableViewCell
        let contact: Contacts
        if isFiltering() {
            contact = filteredContacts[indexPath.row]
        } else {
            contact = myContacts[indexPath.section][indexPath.row]
        }
//        let contact = myContacts[indexPath.section][indexPath.row]
        cell.contact = contact
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        if editingStyle == .delete {
        //            self.myContacts.remove(at: indexPath.row)
        //            alphabetView.nameList.remove(at: indexPath.row)
        //            tableView.deleteRows(at: [indexPath], with: .fade)
        //        }
    }
}

// MARK: - Delegate

extension AlphabetViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "FriendsDatailsSegue" {
        //            let destVC = segue.destination as! FriendsCollectionViewController
        //            if let nameFriends = tableView.indexPathForSelectedRow {
        //                destVC.navigationItem.title = self.contacts[nameFriends.row].name
        //            }
        //        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AlphabetViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var alphabet = [String]()
        for letter in abc {
            alphabet.append(String(letter))
        }
        return alphabet
    }
}
