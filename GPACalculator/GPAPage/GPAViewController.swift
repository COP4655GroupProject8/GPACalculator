//
//  GPAViewController.swift
//  GPACalculator
//
//  Created by Uriel Juarez on 4/6/24.
//

import UIKit

class GPAViewController: UIViewController {
    var currentStudent: Student?
    @IBOutlet weak var GPALabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentStudent?.studentID)
        if let currentStudent = currentStudent {
                    // Calculate GPA and display it
                    if let gpa = currentStudent.calculateCurrentGPA() {
                        GPALabel.text = String(format: "%.2f", gpa)
                    } else {
                        GPALabel.text = "N/A" // Handle the case where GPA calculation fails
                    }
                } else {
                    GPALabel.text = "N/A" // Handle the case where currentStudent is nil
                }
        // Do any additional setup after loading the view.
    }


}

