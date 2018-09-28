//
//  YakTableViewController.swift
//  YikYak
//
//  Created by Ivan Ramirez on 9/27/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class YakTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        YakController.shared.herdAllYaks { (yaks) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return YakController.shared.yaks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yakCell", for: indexPath)
        //get an instance of a yak
        let yak = YakController.shared.yaks[indexPath.row]
        cell.textLabel?.text = yak.text
        cell.detailTextLabel?.text = yak.author
        
        return cell
    }
    
    
    // MARK: Alert
    
    func presentYaker(title: String, message: String?) {
        //init a new alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Get Yakky With It 🤤"
        }
        alertController.addTextField { (authorTextField) in
            authorTextField.placeholder = "We don't recommend putting in your real name"
            //theres also an option to give a deafult author name
        }
        let yakAction = UIAlertAction(title: "Yack", style: .default) { (_) in
            //you need the text
            guard let bodyText = alertController.textFields?.first?.text,
                let author = alertController.textFields?[1].text else {return}
            //optional completion handler so we can put nil
            YakController.shared.birthYoungYak(text: bodyText, author: author, completion: { (_) in
                //in a clousre got to put self
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        let dismissAction = UIAlertAction(title: "OKay", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        alertController.addAction(yakAction)
        self.present(alertController, animated: true)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toYakPen" {
            let destinationVC = segue.destination as? YakPen
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let yak = YakController.shared.yaks[indexPath.row]
            destinationVC?.yak = yak
        }
    }
    
    @IBAction func tapYak(_ sender: Any) {
        self.presentYaker(title: "Yik Me", message: nil)
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        YakController.shared.herdAllYaks { (yaks) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
