//
//  HistoryViewController.swift
//  GPACalculator
//
//  Created by Freeman  Francois on 4/4/24.
//

import UIKit

class HistoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var termPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    var currentStudent: Student?
    
    let semesters = ["Spring", "Summer", "Fall"]
    let years = Array(2000...2024)
    
    var selectedSemester: String?
    var selectedYear: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termPicker.delegate = self
        termPicker.dataSource = self
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
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
}
