//
//  SettingsVC.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableAnswers = TableAnswers.tableObj
    let data = DataInputOutput()

    @IBOutlet weak var writeAnswerLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var tableViewAnswers: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        data.readAnswersFromFile()
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
            saveDataToFile()
            tableViewAnswers.reloadData()
        } else {
            let alertController = UIAlertController(title: "Alert", message: "Need write your variant of answer!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (_) in }
             alertController.addAction(cancel)
             alertController.view.tintColor = UIColor.blue
             self.present(alertController, animated: true, completion: nil)
          }

    }

    func saveDataToFile() {
        if answerTextField.text != "" || answerTextField.text != " " {
            guard let txt = answerTextField.text else {
                print("answerTextField isn't correct")
                return
            }
            tableAnswers.arrayAnswers.append(txt)
            data.saveAnswerToFile(arrayAnswers: tableAnswers.arrayAnswers)
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
            saveDataToFile()
        }
    }
}
