
//
//  RootTableViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 28..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class RootTableViewController: UITableViewController, UITextFieldDelegate {
    
    var pprojects: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pprojects.count
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Projects")
        
        let sortDescriptor = NSSortDescriptor (key: "codename", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            pprojects = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Project Cell", for: indexPath)
        
        // Configure the cell...
        let project = pprojects[indexPath.row]
        var display: String = ""
        if let pnameLabel = project.value(forKey: "projectname") as? String { //프로젝트명
            display = pnameLabel
        }
        if let unameLabel = project.value(forKey: "username") as? String { //담당자
            display = display + "   " + unameLabel
        }
        if let cnameLabel = project.value(forKey: "codename") as? String { //담당자
            display = display + "   " + cnameLabel
        }
        /*
         if let productionLabel = project.value(forKey: "pproduction") as? String { //제작사
         display = display + " " + productionLabel
         }
         if let entryLabel = project.value(forKey: "pentry") as? String { //참여자
         display = display + " " + entryLabel
         }
         */
        cell.textLabel?.text = display
        cell.detailTextLabel?.text = project.value(forKey: "memo") as? String //간략한 내용
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = getContext()
            context.delete(pprojects[indexPath.row])
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            // 배열에서 해당 자료 삭제
            pprojects.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSeeView" {
            if let destination = segue.destination as? DetailSeeViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailSeeProject = pprojects[selectedIndex]
                }
            }
        }
    }
}

