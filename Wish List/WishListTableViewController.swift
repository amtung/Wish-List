//
//  WishListTableViewController.swift
//
//
//  Created by Annie Tung on 2/12/17.
//
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WishListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var items: [WishListItem] = []
    var user: User!
    var databaseReference: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseReference = FIRDatabase.database().reference()
        user = User(uid: (FIRAuth.auth()?.currentUser?.uid)!, email: (FIRAuth.auth()?.currentUser?.email)!)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishListItem))
        
        databaseReference.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            dump(snapshot)
            self.tableView.reloadData()
        })
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    // MARK: - Methods
    
    func addWishListItem() {
        let alert = UIAlertController(title: "Wish List Item", message: "Add your item here", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first,
                let text = textField.text, !text.isEmpty else {
                    print("Empty textfield")
                    return
            }
            let reference = FIRDatabase.database().reference(withPath: "WishList")
            let itemRef = reference.child(text.lowercased())
            
            let newItemDetails: [String:AnyObject] = [
                "item" : text as AnyObject,
                "addedByUser" : self.user.email as AnyObject,
                "completed" : false as AnyObject
            ]
            itemRef.setValue(newItemDetails)
            print("Successfully added!")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        /*let itemAtRow = items[indexPath.row]
         
         cell.textLabel?.text = itemAtRow.item
         cell.detailTextLabel?.text = itemAtRow.addedByUser*/
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
