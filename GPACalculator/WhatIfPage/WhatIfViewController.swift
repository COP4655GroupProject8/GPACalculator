//
//  WhatIfViewController.swift
//  GPACalculator
//
//  Created by Uriel Juarez on 4/6/24.
//

import UIKit

import UIKit

class WhatIfViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource {
    @IBOutlet weak var TermUIPicker: UIPickerView!
    @IBOutlet weak var YearUIPicker: UIPickerView!
    @IBOutlet weak var GPALabel: UITextField!
    @IBOutlet weak var ClassesTable: UITableView!
    var currentStudent: Student?
    var allClasses: [Class]? {
        didSet {
            ClassesTable.reloadData() // Reload table view when classes are updated
        }
    }
    let terms = ["Summer", "Spring", "Fall"]
    let years = Array(2000...2024).map { String($0) }
    var temporaryGrades: [String] = [] // Temporary list to hold current grades

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up delegates and data sources
        TermUIPicker.delegate = self
        TermUIPicker.dataSource = self
        YearUIPicker.delegate = self
        YearUIPicker.dataSource = self
        ClassesTable.dataSource = self
        
        // Select default values for pickers
        let defaultTermIndex = 2 // Default to "Fall"
        let defaultYearIndex = years.firstIndex(of: "2024") ?? 0 // Default to "2024"
        TermUIPicker.selectRow(defaultTermIndex, inComponent: 0, animated: false)
        YearUIPicker.selectRow(defaultYearIndex, inComponent: 0, animated: false)
        
        // Fetch classes and calculate/display GPA
        getClasses()
        calculateAndDisplayGPA() // Call the method here
    }


    // MARK: - UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == TermUIPicker {
            return terms.count
        } else if pickerView == YearUIPicker {
            return years.count
        }
        return 0
    }

    // MARK: - UIPickerViewDelegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == TermUIPicker {
            return terms[row]
        } else if pickerView == YearUIPicker {
            return years[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getClasses()
        calculateAndDisplayGPA()
    }
    
    
    func getClasses() {
        let selectedTermIndex = TermUIPicker.selectedRow(inComponent: 0)
        let selectedTerm = terms[selectedTermIndex]

        let selectedYearIndex = YearUIPicker.selectedRow(inComponent: 0)
        let selectedYear = years[selectedYearIndex]

        if let student = currentStudent {
            allClasses = student.getClasses(for: selectedTerm, year: Int(selectedYear) ?? 2024)
        } else {
            // Handle the case where currentStudent is nil
            allClasses = nil
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClasses?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ClassTableViewCell
        
        // Retrieve class object from allClasses array if available
        if let classObject = allClasses?[indexPath.row] {
            cell.className.text = classObject.name
            cell.classCredit.text = String(classObject.creditHours)
            cell.classGrade.text = classObject.grade
            
            // Update GPA whenever the grade is changed
            cell.gradeChangedCallback = { [weak self] newGrade in
                classObject.grade = newGrade
                self?.updateGPAWithCurrentClasses()
            }
        }
        
        return cell
    }
    func updateGPAWithCurrentClasses() {
           var totalCreditHours = 0
           var totalQualityPoints = 0
           
           // Iterate over all visible cells in the table view
           for cell in ClassesTable.visibleCells as! [ClassTableViewCell] {
               // Access the credit hour and grade from each cell
               if let credit = Int(cell.classCredit.text ?? "0"), let grade = cell.classGrade.text {
                   // Calculate quality points for each class
                   let qualityPoints = calculateQualityPoints(credit: credit, grade: grade)
                   // Update total credit hours and quality points
                   totalCreditHours += credit
                   totalQualityPoints += qualityPoints
               }
           }
           
           // Calculate GPA based on total quality points and credit hours
           let gpa = calculateGPA(totalQualityPoints: totalQualityPoints, totalCreditHours: totalCreditHours)
           
           // Update GPA label with the new GPA value
           GPALabel.text = String(format: "%.2f", gpa)
       }
       
       // Calculate quality points for a given credit hour and grade
       func calculateQualityPoints(credit: Int, grade: String) -> Int {
           // Implement your logic to convert grade to quality points
           // For example:
           switch grade {
           case "A":
               return credit * 4
           case "B":
               return credit * 3
           case "C":
               return credit * 2
           case "D":
               return credit * 1
           case "F":
               return 0
           default:
               return 0 // Handle invalid grades here
           }
       }
       
       // Calculate GPA based on total quality points and credit hours
       func calculateGPA(totalQualityPoints: Int, totalCreditHours: Int) -> Double {
           if totalCreditHours == 0 {
               return 0.0
           }
           return Double(totalQualityPoints) / Double(totalCreditHours)
       }
    func calculateAndDisplayGPA() {
        // Optional chaining used here to safely unwrap allClasses
        guard let allClasses = allClasses, !allClasses.isEmpty else {
            // Reset GPA to 0 if there are no classes selected or displayed
            GPALabel.text = "0.00"
            return
        }
        
        var totalCreditHours = 0
        var totalQualityPoints = 0
        
        for classObject in allClasses {
            let credit = classObject.creditHours
            let grade = classObject.grade
            
            // Perform GPA calculation
            let qualityPoints = calculateQualityPoints(credit: credit, grade: grade)
            totalCreditHours += credit
            totalQualityPoints += qualityPoints
        }

        // Calculate GPA based on total quality points and credit hours
        let gpa = calculateGPA(totalQualityPoints: totalQualityPoints, totalCreditHours: totalCreditHours)
        
        // Update GPA label with the new GPA value
        GPALabel.text = String(format: "%.2f", gpa)
    }

    
    // Handle grade change in a cell
    func updateGradeForClass(at indexPath: IndexPath, newGrade: String) {
        // Update temporary grades list
        temporaryGrades[indexPath.row] = newGrade
        // Recalculate GPA with updated grades
        calculateAndDisplayGPA()
    }
}
