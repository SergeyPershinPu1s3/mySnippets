//
//  AppDelegate.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 07.04.2021.
//

import UIKit


func validatePattern(field: [String], start: Int, step: Int, value: String) -> Bool {
    var countOfChecks = 3
    for (index, char) in field.enumerated() {
        guard index >= start else { continue }
        if (index - start) % step == 0 {
            countOfChecks -= 1
            if countOfChecks < 0 {
                break
            }
            if char != value {
                return false
            }
        }
    }
    return true
}

func whoWon(_ board: [[String]]) -> String {
    guard board.count == 3, (board.filter { $0.count != 3 }).isEmpty else { return "Tie" }
    let boardFlatmap = (board.flatMap { $0 })
    let boardSet = Set(boardFlatmap)
    guard boardFlatmap.count == 9, boardSet.count == 2 else { return "Tie" }
    guard boardSet.contains("X"), boardSet.contains("O") else { return "Tie" }
    
    let horizontalChecks = [(0, 1), (3, 1), (6, 1)]
    let verticalChecks = [(0, 3), (1, 3), (2, 3)]
    let diagonalChecks = [(0, 4), (2, 2)]
    
    let totalChecks = horizontalChecks + verticalChecks + diagonalChecks
    var xSolutionExists = false
    var oSolutionExists = false
    for check in totalChecks {
        if validatePattern(field: boardFlatmap, start: check.0, step: check.1, value: "X") {
            xSolutionExists = true
        }
        if validatePattern(field: boardFlatmap, start: check.0, step: check.1, value: "O") {
            oSolutionExists = true
        }
    }
    if xSolutionExists && !oSolutionExists {
        return "X"
    } else if !xSolutionExists && oSolutionExists {
        return "O"
    }
    
    return "Tie"
}





@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13, *) {

        } else {
            let window = UIWindow()
            let vc = ViewController()
            window.rootViewController = vc
            window.makeKeyAndVisible()
            self.window = window
        }
        
        
        whoWon([
                    ["O", "O", "X"],
                    ["X", "X", "X"],
                    ["O", "O", "O"],
                ])
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

