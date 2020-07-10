//
//  AddTaskViewController.swift
//  TodoAppCoreData
//
//  Created by 0001 QBS on 2020/07/09.
//  Copyright © 2020 qbs0001. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var isImportant: UISwitch!
    
    @IBAction func btnTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let task = Task(context: context)
        task.name = textField.text!
        task.isImportant = isImportant.isOn

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
