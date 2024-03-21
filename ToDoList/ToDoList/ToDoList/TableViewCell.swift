//
//  TableViewCell.swift
//  ToDoList
//
//  Created by 김시종 on 3/19/24.
//

import UIKit

class TableViewCell: UITableViewCell {


    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    var onSwitchToggle: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchToggled(_ sender: UISwitch) {
        onSwitchToggle?(sender.isOn)
        
    }
    
}
