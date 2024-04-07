//
//  HistoryViewController.swift
//  GPACalculator
//
//  Created by Freeman  Francois on 4/4/24.
//

import UIKit

class HistoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var termPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var historyTableView: UITableView!
    
    var currentStudent: Student?
    let semesters = ["Spring", "Summer", "Fall"]
    let years = Array(2000...2024)
    var selectedSemester: String?
    var selectedYear: Int?
    
    // Dummy data
    let dummyData: [(course: String, grade: String, credit: String)] = [
        ("Mathematics", "A", "3"),
        ("Physics", "B", "4"),
        ("English", "C", "3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termPicker.delegate = self
        termPicker.dataSource = self
        yearPicker.delegate = self
        yearPicker.dataSource = self
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        // Set default values for semester and year
        let defaultSemesterIndex = semesters.firstIndex(of: "Spring") ?? 0
        let defaultYearIndex = years.firstIndex(of: 2024) ?? 0
        termPicker.selectRow(defaultSemesterIndex, inComponent: 0, animated: false)
        yearPicker.selectRow(defaultYearIndex, inComponent: 0, animated: false)
        
        // Set selected semester and year
        selectedSemester = semesters[defaultSemesterIndex]
        selectedYear = years[defaultYearIndex]
        
        // Load classes for the default semester and year
        loadClasses()
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == termPicker {
            return semesters.count
        } else {
            return years.count
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == termPicker {
            return semesters[row]
        } else {
            return "\(years[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == termPicker {
            selectedSemester = semesters[row]
        } else {
            selectedYear = years[row]
        }
        
        // Refresh table view with updated data
        historyTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let student = currentStudent,
           let semester = selectedSemester,
           let year = selectedYear,
           let classes = student.getClasses(for: semester, year: year) {
            return classes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
        
        if let student = currentStudent,
           let semester = selectedSemester,
           let year = selectedYear,
           let classes = student.getClasses(for: semester, year: year) {
            let classObj = classes[indexPath.row]
            cell.className.text = classObj.name
            cell.classGrade.text = classObj.grade
            cell.classCredit.text = "\(classObj.creditHours)"
        }
        
        return cell
    }
    
    // MARK: - IBActions
    
    @IBAction func addClassView(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddClassViewController") as? AddClassViewController else {
            return
        }
        
        vc.currentStudent = currentStudent
        vc.semester = selectedSemester ?? ""
        vc.year = selectedYear ?? 0
        
        navigationController?.pushViewController(vc, animated: true)
    }
    func loadClasses() {
        guard let student = currentStudent,
              let semester = selectedSemester,
              let year = selectedYear else {
            return
        }
        
        if let classes = student.getClasses(for: semester, year: year) {
            // Update table view with the fetched classes
            historyTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload data whenever the view is about to appear
        loadClasses()
    }
    
}
