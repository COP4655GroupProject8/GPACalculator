//
//  AddClassViewController.swift
//  GPACalculator
//
//  Created by Freeman  Francois on 4/4/24.
//

import UIKit

class AddClassViewController: UIViewController {
    
    @IBOutlet weak var classNameField: UITextField!
    @IBOutlet weak var classGradeField: UITextField!
    @IBOutlet weak var addClassButton: UIButton!
    @IBOutlet weak var classCreditField: UITextField!
    var currentStudent: Student?
    var semester: String = ""
    var year: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func createClassClicked(_ sender: Any) {
        guard let className = classNameField.text, !className.isEmpty,
              let classCreditText = classCreditField.text, !classCreditText.isEmpty,
              let classCredit = Double(classCreditText),
              let currentStudent = currentStudent,
              let classGrade = classGradeField.text else {
            // Handle the case when any of the required fields are missing
            print("Error: Required fields are missing")
            return
        }
        
        // Assuming Student class has a method to add a course
        currentStudent.addClass(semester: semester, year: year, className: className, creditHours: Int(classCredit), grade: classGrade)
        
        // Dismiss the AddClassViewController by popping it from the navigation stack
        navigationController?.popViewController(animated: true)
    }

}
