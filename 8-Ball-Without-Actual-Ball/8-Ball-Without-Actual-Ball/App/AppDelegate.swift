//
//  AppDelegate.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let tableAnswers = TableAnswers.tableObj

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        readAnswersFromFile()
        return true
    }

    func readAnswersFromFile() {

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        guard let documentsDirectory = paths.object(at: 0) as? NSString else {
            return
        }
        
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
            // loading values
            tableAnswers.arrayAnswers = dict.object(forKey: "Answers")! as! [String]
            print("arrayAnswers = \(tableAnswers.arrayAnswers)")
        } else {
            print("WARNING: Couldn't create dictionary from Answers.plist!")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
