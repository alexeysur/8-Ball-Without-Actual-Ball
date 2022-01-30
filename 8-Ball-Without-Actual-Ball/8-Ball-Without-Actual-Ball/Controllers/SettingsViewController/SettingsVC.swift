//
//  SettingsVC.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableAnswers = TableAnswers.tableObj
    
    @IBOutlet weak var writeAnswerLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var tableViewAnswers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAnswersFromFile()
        setupVC()
    }
    
    private func setupVC() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        tableViewAnswers.delegate = self
        tableViewAnswers.dataSource = self
        setupTableView()
        
    }
    
    @objc func cancelTapped() {
        answerTextField.text = ""
        tabBarController!.selectedIndex = 0
    }
    
    @objc func doneTapped() {
        if answerTextField.text != "" {
            saveAnswerToFile()
            tableViewAnswers.reloadData()
        } else {
            let alertController = UIAlertController(title: "Alert", message: "Need write your variant of answer!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (action) in }
             alertController.addAction(cancel)
             alertController.view.tintColor = UIColor.blue
             self.present(alertController, animated: true, completion: nil)
          }
        
    }
    
    func readAnswersFromFile() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("Answers.plist")
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            guard let bundlePath = Bundle.main.path(forResource: "Answers", ofType: "plist") else { return }
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: path)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
            }
        }
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            //loading values
            tableAnswers.arrayAnswers = dict.object(forKey: "Answers")! as! [String]
        } else {
            print("WARNING: Couldn't create dictionary from Answers.plist!")
        }
        tableViewAnswers.reloadData()
        
    }
    
    func saveAnswerToFile() {
        if answerTextField.text != "" || answerTextField.text != " " {
            guard let txt = answerTextField.text else {
                print("answerTextField isn't correct")
                return
            }
            tableAnswers.arrayAnswers.append(txt)
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            let documentsDirectory = paths.object(at: 0) as! NSString
            let path = documentsDirectory.appendingPathComponent("Answers.plist")
            
            let dict: NSMutableDictionary = ["Answers": tableAnswers.arrayAnswers]
            //saving values
            dict.write(toFile: path, atomically: false)
        }
    }
}


extension SettingsVC {
    func setupTableView() {
        self.tableViewAnswers.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tableAnswers.arrayAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = tableAnswers.arrayAnswers[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableAnswers.arrayAnswers.remove(at: indexPath.row)
            self.tableViewAnswers.deleteRows(at: [indexPath], with: .automatic)
            saveAnswerToFile()
        }
    }
    
}
