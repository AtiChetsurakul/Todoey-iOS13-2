//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
class ToDoListViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var searchBar: UISearchBar!
    var itemArray:[ItemToDo] = [] // This is custom Information which userDefaults rejecting
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItem()
//        searchBar.delegate = self
    }
    
    @IBAction func addNewItemPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add New TODO", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: "ADD ITEM", style: .default) { action in
            let newItem = ItemToDo(context: self.context)
            newItem.todo = textfield.text!
            self.itemArray.append(newItem)
            self.saveItem()
            

            
        }
        alert.addTextField { alertTextField in
            
            alertTextField.placeholder = "new Item?"
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: for SearchBar
extension ToDoListViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<ItemToDo> = ItemToDo.fetchRequest()
        print(request)
        request.predicate = NSPredicate(format: "todo CONTAINS[cd] %@", searchBar.text!)
        
        
//        let sortDescriptor = NSSortDescriptor(key: "todo", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
        request.sortDescriptors = [NSSortDescriptor(key: "todo", ascending: true)]
        loadItem(with: request)
        saveItem()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            saveItem()
            // Toremove keyboard by unfocus searchbar
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }
           
        }
    }
    

}


//MARK: FOR table controller
extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].todo
        cell .accessoryType = item.isCheck ? .checkmark : .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     /* U (update database Method)
        itemArray[indexPath.row].setValue("Completed", forKey: "todo")
     */
        //        NEED TO BE exact Order to del (Database -> localArray -> Commit to context.save)
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
       itemArray[indexPath.row].isCheck.toggle()

        saveItem()
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveItem() {
  
        do {
            try context.save()
        }catch {
           print("error saving context\(error)")
        }
        self.tableView.reloadData()
    }
    
//    func loadItem() {
//        let request: NSFetchRequest<ItemToDo> = ItemToDo.fetchRequest()
//        do
//        {
//          itemArray = try context.fetch(request)
//        }
//        catch {
//            print("fetct error\(error)")
//        }
//    }
    
    func loadItem(with request:NSFetchRequest<ItemToDo> = ItemToDo.fetchRequest()) {
       
        do
        {
          itemArray = try context.fetch(request)
        }
        catch {
            print("fetct error\(error)")
        }
    }


}

//func saveItem() {
//    let encoder = PropertyListEncoder()
//    do {
//        let data = try encoder.encode(itemArray)
//        try data.write(to: dataFilePath!)
//    }catch {
//        print(error)
//    }
//    self.tableView.reloadData()
//}


//    func loadItem() {
//        let decoder = PropertyListDecoder()
//        do
//        {
//            let data = try Data(contentsOf: dataFilePath!)
//            itemArray = try decoder.decode([ItemToDo].self, from: data)
//        }
//        catch {
//          print(error)
//        }
//    }
    



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

//let defaults = UserDefaults.standard
//let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


//        loadItem()
   /*       Locate where fileAre
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
//        print(dataFilePath ?? "")
     */

//happen after click
//            self.itemArray.append(ItemToDo(textfield.text ?? "Untitled"))
//            self.saveItem()

//         THIS set item array to userdefault which cant do
//            self.defaults.set(self.itemArray, forKey: "TodoListArrays")
//TODO

//if let items = (defaults.array(forKey: "TodoListArrays") as? [ItemToDo]) {
//    itemArray = items
//}
//func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    let request:NSFetchRequest<ItemToDo> = ItemToDo.fetchRequest()
//    print(request)
//    let predicated = NSPredicate(format: "todo CONTAINS[cd] %@", searchBar.text!)
//    request.predicate = predicated
//
//    let sortDescriptor = NSSortDescriptor(key: "todo", ascending: true)
//    request.sortDescriptors = [sortDescriptor]
//    do
//    {
//      itemArray = try context.fetch(request)
//    }
//    catch {
//        print("fetct error\(error)")
//    }
//    saveItem()
//}
