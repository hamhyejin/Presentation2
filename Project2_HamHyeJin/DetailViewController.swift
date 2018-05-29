
//
//  DetailViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 29..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pa: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var movietitle: UITextField!
    @IBOutlet weak var production: UITextField!
    @IBOutlet weak var participant: UITextField!
    @IBOutlet weak var content: UITextField!
    
    var detailProject: NSManagedObject?
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let projects = detailProject {
            pa.text = projects.value(forKey: "username") as? String
            movietitle.text = projects.value(forKey: "projectname") as? String
            code.text = projects.value(forKey: "codename") as? String
            production.text = projects.value(forKey: "pproduction") as? String
            participant.text = projects.value(forKey: "pentry") as? String
            content.text = projects.value(forKey: "memo") as? String
        }
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Projects", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)

        object.setValue(movietitle.text, forKey: "projectname")
        object.setValue(pa.text, forKey: "username")
        object.setValue(content.text, forKey: "memo")
        object.setValue(code.text, forKey: "codename")
        object.setValue(participant.text, forKey: "pproduction")
        object.setValue(production.text, forKey: "pentry")

        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true) }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
