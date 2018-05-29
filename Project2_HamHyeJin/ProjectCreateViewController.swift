//
//  ProjectCreateViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 28..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class ProjectCreateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pName: UITextField!
    @IBOutlet weak var production: UITextField!
    @IBOutlet weak var uName: UITextField!
    @IBOutlet weak var entry: UITextField!
    @IBOutlet weak var pmemo: UITextField!
    @IBOutlet weak var cName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Projects", in: context)
        // Viewprojects record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(pName.text, forKey: "projectname")
        object.setValue(uName.text, forKey: "username")
        object.setValue(pmemo.text, forKey: "memo")
        object.setValue(cName.text, forKey: "codename")
        
        object.setValue(production.text, forKey: "pproduction")
        object.setValue(entry.text, forKey: "pentry")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
