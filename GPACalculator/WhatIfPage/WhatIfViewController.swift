//
//  WhatIfViewController.swift
//  GPACalculator
//
//  Created by Uriel Juarez on 4/6/24.
//

import UIKit

class WhatIfViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var TermUIPicker: UIPickerView!
    @IBOutlet weak var YearUIPicker: UIPickerView!
    @IBOutlet weak var GPALabel: UITextField!

    let terms = ["Summer", "Spring", "Fall"]
    let years = Array(2000...2024).map { String($0) }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegate and data source for TermUIPicker and YearUIPicker
        TermUIPicker.delegate = self
        TermUIPicker.dataSource = self
        YearUIPicker.delegate = self
        YearUIPicker.dataSource = self

        // Set default selection for TermUIPicker and YearUIPicker
        TermUIPicker.selectRow(2, inComponent: 0, animated: false) // Default to "Fall"
        YearUIPicker.selectRow(24, inComponent: 0, animated: false) // Default to "2024"
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
        if pickerView == TermUIPicker {
            let selectedTerm = terms[row]
            // Handle selected term
            print("Selected term: \(selectedTerm)")
        } else if pickerView == YearUIPicker {
            let selectedYear = years[row]
            // Handle selected year
            print("Selected year: \(selectedYear)")
        }
    }
}
