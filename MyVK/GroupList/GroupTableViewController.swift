//
//  GroupTableViewController.swift
//  MyVK
//
//  Created by Виктор Новосёлов on 09/01/2019.
//  Copyright © 2019 Виктор Новосёлов. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var groupList: [Group] = Group.fetchGroup()
    var imageGroup = UIImage(named: "group")
    let searchController = UISearchController(searchResultsController: nil)
    var filteredGroup = [Group]()
    
    // MARK: - Методы
    
    // Получение массива отфильтрованных контактов при поиске
    func filterContentForSearchText(_ searchText: String) {
        filteredGroup = groupList.filter({ (group: Group) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchByEmpty() -> Bool {
        // возвращает true если нет текста или nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchByEmpty()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // true - скрывает table view и показывает view с результатами
        searchController.searchBar.placeholder = "Search Group"
        navigationItem.searchController = searchController // добавляет строку поиска в navigation controller
        navigationItem.hidesSearchBarWhenScrolling = false // скрывает или отображает строку поиска при прокрутке
        definesPresentationContext = true // скрывает строку поиска при переходе на другой экран
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredGroup.count
        } else {
            return groupList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupTableViewCell
        let group: Group
        if isFiltering() {
            group = filteredGroup[indexPath.row]
        } else {
            group = groupList[indexPath.row]
        }
        cell.group = group
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindToGroupList(_ unwindSegue: UIStoryboardSegue) {
        tableView.reloadData()
    }
}

extension GroupTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    
}
