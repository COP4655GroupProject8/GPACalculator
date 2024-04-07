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

    override func viewDidLoad() {
        super.viewDidLoad()
        ClassesTable.dataSource = self
        print(currentStudent?.studentID)
        // Set delegate and data source for TermUIPicker and YearUIPicker
        TermUIPicker.delegate = self
        TermUIPicker.dataSource = self
        YearUIPicker.delegate = self
        YearUIPicker.dataSource = self

        // Set default selection for TermUIPicker and YearUIPicker
        TermUIPicker.selectRow(2, inComponent: 0, animated: false) // Default to "Fall"
        YearUIPicker.selectRow(24, inComponent: 0, animated: false) // Default to "2024"
        calculateAndDisplayGPA()
        getClasses()
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
        calculateAndDisplayGPA()
        getClasses()
    }
    
    func calculateAndDisplayGPA() {
        let selectedTermIndex = TermUIPicker.selectedRow(inComponent: 0)
        let selectedTerm = terms[selectedTermIndex]

        let selectedYearIndex = YearUIPicker.selectedRow(inComponent: 0)
        let selectedYear = years[selectedYearIndex]

        if let student = currentStudent {
            let hypotheticalGPA = student.calculateSemesterGPA(semester: selectedTerm, year: Int(selectedYear) ?? 2024)
            GPALabel.text = String(format: "%.2f", hypotheticalGPA ?? "N/A")
        } else {
            GPALabel.text = "N/A"
        }
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
        }
        
        return cell
    }

        
}
