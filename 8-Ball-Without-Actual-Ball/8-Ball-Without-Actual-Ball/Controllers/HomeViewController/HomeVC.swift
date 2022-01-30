//
//  HomeVC.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class HomeVC: UIViewController {
    let  urlToSite = "https://8ball.delegator.com/magic/JSON/_"
    let  tableAnswers = TableAnswers.tableObj
    
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
        print("Device begin shake!")
        setImageGif()
        let answer = getAnswer()
        print("Anwer = \(answer)")
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
    
    
    func getAnswer() -> String? {
            var  answer: String?
            guard let url = URL(string: urlToSite) else { return nil }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                guard response.statusCode == 200 else {
                    let randomIndex = Int.random(in: 0..<self.tableAnswers.arrayAnswers.count-1)
                    self.textAnswerLabel.text = self.tableAnswers.arrayAnswers[randomIndex]
                    return
                    
                }
                do {
                    let model = try JSONDecoder().decode(Answer.self, from: data)
                    
                    DispatchQueue.main.async {
                        answer = model.answer
                        self.setImagePdf()
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        let randomIndex = Int.random(in: 0..<self.tableAnswers.arrayAnswers.count-1)
                        print("randomIndex = \(randomIndex)")
                        print("answer = \(self.tableAnswers.arrayAnswers[randomIndex])")
                        self.textAnswerLabel.text = self.tableAnswers.arrayAnswers[randomIndex]
                        self.setImagePdf()
                    }
                    print("Error = \(error.localizedDescription)")
                }
                
            }.resume()
            
            return answer
        }
}
