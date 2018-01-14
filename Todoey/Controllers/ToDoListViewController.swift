//
//  ViewController.swift
//  Todoey
//
//  Created by mstysin on 1/2/18.
//  Copyright © 2018 Stysin Technoogies. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    // defaults allow to store simple data
    //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("here you go, \(dataFilePath)")
                
        //checking if there is saved user array and extracting it
        //if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        //    itemArray = items
        //}
        
        loadItems()
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("you selected row \(itemArray[indexPath.row])")
        
        //changing false to ture and otherwise for checkmark attribute
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        //commented reload below cause it's already applied in saveItems above
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on UIalert
            let createdItem = Item()
            createdItem.title = textField.text!
            self.itemArray.append(createdItem)
            
            //saving array with appended items to local storage on the phone so upon reload user sees he's added items
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        
        //reloading the tableview to show added item
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Eror decoding item array, \(error)")
            }
        }
    }
    
}

