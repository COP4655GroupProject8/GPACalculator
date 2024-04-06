//
//  AppDelegate.swift
//  GPACalculator
//
//  Created by Freeman  Francois on 3/30/24.
//

import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var fakeStudent: Student?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ParseSwift.initialize(applicationId: "9offAlrlWddViV1RFN0IC0efSGHhORICDpdvFNDC",
                              clientKey: "RaORxDKUPuDu6HHB05osbM2vOhmU7vGcQGN0Qgq9",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)
//        // Initialize a fake student
//        fakeStudent = Student(studentID: "123456789")
//        fakeStudent?.addClass(semester: "Spring", year: 2024, className: "Math", creditHours: 3, grade: "A")
//        fakeStudent?.addClass(semester: "Spring", year: 2024, className: "Science", creditHours: 4, grade: "B")
//        print(fakeStudent)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

