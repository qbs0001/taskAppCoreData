//
//  ViewController.swift
//  TodoAppCoreData
//
//  Created by 0001 QBS on 2020/07/09.
//  Copyright © 2020 qbs0001. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //テーブル表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        //スイッチオンのデータは、頭に星をつける
        if task.isImportant{
            cell.textLabel?.text = "⭐️" + task.name! + " : \(formatter.string(from: task.date!))"
        } else {
            cell.textLabel?.text = task.name! +  " : \(formatter.string(from: task.date!))"
        }
        
        return cell
    }

    //coredataからデータを取得
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch {
            print("読み込みエラー")
        }
    }
    
    //viewが表示される直前に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    //データ削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("読み込みエラー")
            }
        }
        tableView.reloadData()
    }

}

