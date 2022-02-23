//
//  HomeVC.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class HomeVC: UIViewController {

    let tableAnswers = TableAnswers.tableObj
    let networkManager = NetworkManager()
    let urlToSite: URL = URL(string: "https://8ball.delegator.com/magic/JSON/_")!

    @IBOutlet weak var textAnswerLabel: UILabel!
    @IBOutlet weak var imageBallGif: UIImageView!
    @IBOutlet weak var shakeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    private func setupVC() {
        setImagePdf()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapResponse))
        imageBallGif.addGestureRecognizer(tapGestureRecognizer)
        imageBallGif.isUserInteractionEnabled = true
    }

    private func setImagePdf() {
        imageBallGif.contentMode = .scaleAspectFit
        imageBallGif.image = UIImage(named: "8ball-shake-pdf")
    }

    private func setImageGif() {
        imageBallGif.contentMode = .scaleAspectFit
        imageBallGif.image = UIImage.gif(name: "8ball-shake-gif")
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        setImageGif()
//        networkManager.getAnswer(of: Answer.self, from: urlToSite) { (result) in
//            switch result {
//            case .failure(let error):
//                if error is DataError {
//                    print("DataError = \(error)")
//                    DispatchQueue.main.async {
//                        let randomIndex = Int.random(in: 0..<self.tableAnswers.arrayAnswers.count-1)
//                        print("randomIndex = \(randomIndex)")
//                        print("answer = \(self.tableAnswers.arrayAnswers[randomIndex])")
//                        self.textAnswerLabel.text = self.tableAnswers.arrayAnswers[randomIndex]
//                        self.setImagePdf()
//                    }
//                } else {
//                    print(error.localizedDescription)
//                }
//            case .success(let jsonResult):
//                DispatchQueue.main.async {
//                    print("jsonResult = \(jsonResult)")
//                    self.textAnswerLabel.text = jsonResult.magic.answer
//                    self.setImagePdf()
//                }
//            }
//        }
//
  
        //Network request with use Alamofire 
        networkManager.getAnswerUseAlamofire(of: Answer.self, from: urlToSite) { (result) in
            switch result {
            case .failure(let error):
                if error is DataError {
                    print("DataError = \(error)")
                    DispatchQueue.main.async {
                        let randomIndex = Int.random(in: 0..<self.tableAnswers.arrayAnswers.count-1)
                        print("randomIndex = \(randomIndex)")
                        print("answer = \(self.tableAnswers.arrayAnswers[randomIndex])")
                        self.textAnswerLabel.text = self.tableAnswers.arrayAnswers[randomIndex]
                        self.setImagePdf()
                    }
                } else {
                    print(error.localizedDescription)
                }
            case .success(let jsonResult):
                DispatchQueue.main.async {
                    print("jsonResult = \(jsonResult)")
                    self.textAnswerLabel.text = jsonResult.magic.answer
                    self.setImagePdf()
                }
            }
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Device was shaken!")

        }
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        setImagePdf()
        print("Shake cancelled!")
    }

    @objc func tapResponse() {
        setImagePdf()
        print("motionCancelled")
    }
}
