//
//  ClassTableViewCell.swift
//  GPACalculator
//
//  Created by Uriel Juarez on 4/6/24.
//

import UIKit

class ClassTableViewCell: UITableViewCell {
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classCredit: UILabel!
    @IBOutlet weak var classGrade: UITextField!
    // Define a callback closure property to be called when the grade is changed
    var gradeChangedCallback: ((String) -> Void)?
    
    // Add an action to call the callback when the grade changes
    @IBAction func gradeChanged(_ sender: UITextField) {
        if let newGrade = sender.text {
            gradeChangedCallback?(newGrade)
        }
    }

    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
