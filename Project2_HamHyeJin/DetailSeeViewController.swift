//
//  DetailSeeViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 29..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class DetailSeeViewController: UIViewController {
    @IBOutlet weak var palabel: UILabel!
    @IBOutlet weak var codelabel: UILabel!
    @IBOutlet weak var movietitlelabel: UILabel!
    @IBOutlet weak var productionlabel: UILabel!
    @IBOutlet weak var producerlabel: UILabel!
    @IBOutlet weak var contentlabel: UILabel!
    
    var projectview: [NSManagedObject] = []
    var detailSeeProject: NSManagedObject?
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    /*
     func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
     return true } */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let projectss = detailSeeProject {
            palabel.text = projectss.value(forKey: "username") as? String
            movietitlelabel.text = projectss.value(forKey: "projectname") as? String
            codelabel.text = projectss.value(forKey: "codename") as? String
            productionlabel.text = projectss.value(forKey: "pproduction") as? String
            producerlabel.text = projectss.value(forKey: "pentry") as? String
            contentlabel.text = projectss.value(forKey: "memo") as? String
        }
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Projects", in: context)
        // Viewprojects record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(movietitlelabel.text, forKey: "projectname")
        object.setValue(palabel.text, forKey: "username")
        object.setValue(contentlabel.text, forKey: "memo")
        object.setValue(codelabel.text, forKey: "codename")
        object.setValue(productionlabel.text, forKey: "pproduction")
        object.setValue(producerlabel.text, forKey: "pentry")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailView" {
                if let destination = segue.destination as? DetailViewController {
                    if let selectedLabel = self.detailSeeProject?.accessibilityLabel {
                        destination.detailProject = detailSeeProject
                    }
                }
            }
        }
    }
