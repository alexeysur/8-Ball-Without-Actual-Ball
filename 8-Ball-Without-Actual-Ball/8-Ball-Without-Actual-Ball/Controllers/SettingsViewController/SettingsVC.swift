//
//  SettingsVC.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let filename: String = "Answers"
    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    var fileURL: URL!

    @IBOutlet weak var writeAnswerLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var tableViewAnswers: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        
        let fileURL = DocumentDirURL.appendingPathComponent("Answers").appendingPathExtension("txt")
        print("FilePath: \(fileURL.path)")
       // readAnswersFromFile(fileURL: fileURL)
        
    }
    
    @objc func cancelTapped() {
        answerTextField.text = ""
        tabBarController!.selectedIndex = 0
    }

    @objc func doneTapped() {
        
    }
    
    func readAnswersFromFile(fileURL: URL) {
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    func saveAnswerToFile(fileURL: URL) {
      
        
        
        
        if answerTextField.text != "" {
                let writingString = answerTextField.text
            do {
                try writingString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf16)
                
            } catch let error as NSError {
                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
            }
        }
    }
}


extension SettingsVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as UITableViewCell
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}
