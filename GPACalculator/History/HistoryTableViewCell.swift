//
//  HistoryTableViewCell.swift
//  GPACalculator
//
//  Created by Uriel Juarez on 4/7/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classGrade: UILabel!
    @IBOutlet weak var classCredit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
