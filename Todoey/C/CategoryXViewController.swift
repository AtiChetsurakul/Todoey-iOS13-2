
//CategoryXViewController.swift//Todoey//  Created by ati chetsurakul on 5/12/21.//2021 App Brewery. All rights reserved.


import UIKit
import CoreData
class CategoryXViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext

    var cateArray:[CategoryX] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCate()
    }
    
}





//MARK: Button Controller
extension CategoryXViewController {

    @IBAction func addCatePress(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add New TODO", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: "ADD ITEM", style: .default) { _ in
            let newItem = CategoryX(context: self.context)
            newItem.name = textfield.text!
            self.cateArray.append(newItem)
            self.saveCate()
        
        }
        alert.addTextField { alertTextField in
            
            alertTextField.placeholder = "new Item?"
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}




        
        //MARK: table and cell controller TableView DelegateMethod
extension CategoryXViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryXCell", for: indexPath)

        let cate = cateArray[indexPath.row]
        cell.textLabel?.text = cate.name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationTODOVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationTODOVC.selectedCate = cateArray[indexPath.row]
        }
        
    }
}




//MARK: context and Persistancy Controller
extension CategoryXViewController {
    func saveCate() {
        do {
            try context.save()
        }catch {
           print("error saving context\(error)")
        }
        self.tableView.reloadData()
    }

    func loadCate() {
        let request:NSFetchRequest<CategoryX> = CategoryX.fetchRequest()
        do
        {
            cateArray = try context.fetch(request)
        } catch {
          print("load error\(error)")
        }
    }
}
