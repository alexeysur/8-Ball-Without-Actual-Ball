//
//  HomeVC.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var textAnswerLabel: UILabel!
    @IBOutlet weak var imageBallGif: UIImageView!
    @IBOutlet weak var shakeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
      
    }
    private func setupVC() {
        imageBallGif.image = UIImage(named: "8ball-shake-pdf")
        //setImageGif()
    }
    
    private func setImageGif() {
        imageBallGif.translatesAutoresizingMaskIntoConstraints = false
        imageBallGif.contentMode = .scaleAspectFit
        imageBallGif.image = UIImage.gif(name: "8ball-shake-gif")
       
      
    }
}
