//
//  TodoCell.swift
//  MyToDoList
//
//  Created by 김시종 on 3/25/24.
//

import UIKit

protocol TodoCellDelegate: AnyObject {
    func didTapButton(_ cell: TodoCell, isSelected: Bool)
}


class TodoCell: UITableViewCell {
    
    weak var delegate: TodoCellDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .valueChanged)
        // Configure the view for the selected state
    }
    
    
    @objc func checkButtonTapped(sender: UIButton) {
        delegate?.didTapButton(self, isSelected: sender.isSelected)
        
    }
    

}



