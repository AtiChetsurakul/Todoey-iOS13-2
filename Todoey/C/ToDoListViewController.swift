//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [ItemToDo("Find My key"),ItemToDo("Ho Ho HO"),ItemToDo("Joy to the World"),
                     ItemToDo("Find My key1")] // This is custom Information which userDefaults rejecting
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = (defaults.array(forKey: "TodoListArrays") as? [ItemToDo]) {
            itemArray = items
        }
    }
    
    @IBAction func addNewItemPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add New TODO", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: "ADD ITEM", style: .default) { action in
            //happen after click
            self.itemArray.append(ItemToDo(textfield.text ?? "Untitled"))
            self.defaults.set(self.itemArray, forKey: "TodoListArrays")
            
            //            MARK: RELOAD DATA
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            
            alertTextField.placeholder = "new Item?"
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].todo
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isCheck.toggle()
        let tableCons = tableView.cellForRow(at: indexPath)
        
        tableCons?.accessoryType = itemArray[indexPath.row].isCheck ? .checkmark : .none

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



//        if itemArray[indexPath.row].isCheck {
//            tableCons?.accessoryType = .checkmark
//        } else {
//            tableCons?.accessoryType = .none
//        }

//         print(itemArray[indexPath.row] )

//        if tableCons?.accessoryType == .checkmark {
//            tableCons?.accessoryType = .none
//        } else {
//            tableCons?.accessoryType = .checkmark
//        }

//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
//    override func tableView(_ tableView: UITableView,willSelectRowAt indexPath: IndexPath) -> IndexPath?{
//        print(indexPath)
//        return indexPath
//    }
//,ItemToDo("Find My key2")
//,ItemToDo("Find My key3"),ItemToDo("Find My key4"),ItemToDo("Find My key5"),ItemToDo("Find My key6")
//,ItemToDo("Find My key7"),ItemToDo("Find My key8"),ItemToDo("Find My key9"),ItemToDo("1Find My key1"),ItemToDo("2Find My key2")
//,ItemToDo("3Find My key3"),ItemToDo("4Find My key4"),ItemToDo("1Find My key5"),ItemToDo("1Find My key6")
//,ItemToDo("1Find My key7"),ItemToDo("1Find My key8"),ItemToDo("1Find My key9")
