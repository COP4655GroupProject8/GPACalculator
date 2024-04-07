//
//  HomePage.swift
//  GPACalculator
//
//  Created by Uriel Juarez on 4/6/24.
//

import UIKit

class HomePageViewController: UIViewController {
    var currentStudent: Student?
    @IBOutlet weak var UsernameLabel: UITextField!

    
    @IBAction func LogOutButtonClick(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    @IBAction func GPACalculatorButton(_ sender: Any) {
        print("Button")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GPAViewController") as! GPAViewController
           vc.currentStudent = currentStudent
           self.navigationController?.pushViewController(vc, animated: true) // Push the GPAViewController onto the navigation stack
       }
    @IBAction func HistoryButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
           vc.currentStudent = currentStudent
           self.navigationController?.pushViewController(vc, animated: true) // Push the GPAViewController onto the navigation stack
    }
    @IBAction func WhatIfButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WhatIfViewController") as! WhatIfViewController
           vc.currentStudent = currentStudent
           self.navigationController?.pushViewController(vc, animated: true) // Push the GPAViewController onto the navigation stack
    }
    
    @IBAction func GoalsButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsernameLabel.text = "test user"
        // Do any additional setup after loading the view.
    
        
        // Initialize a fake student
        currentStudent = Student(studentID: "123456789")
        currentStudent?.addClass(semester: "Spring", year: 2024, className: "Math", creditHours: 3, grade: "A")
        currentStudent?.addClass(semester: "Spring", year: 2024, className: "Science", creditHours: 4, grade: "B")
        print(currentStudent?.studentID)
        // Do any additional setup after loading the view.
        
    }
    
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

