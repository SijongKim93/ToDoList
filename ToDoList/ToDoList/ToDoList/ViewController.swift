//
//  ViewController.swift
//  ToDoList
//
//  Created by 김시종 on 3/19/24.
//

import UIKit

struct Todo {
    let id: Int
    let title: String
    var isCompleted: Bool
}



class ViewController: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addCellButton: UIButton!
    
    
    
    var cellData:[Todo] = [
        Todo(id: 1, title: "text1", isCompleted: false),
        Todo(id: 2, title: "text2", isCompleted: false),
        Todo(id: 3, title: "text3", isCompleted: false),
        Todo(id: 4, title: "text4", isCompleted: false),
    ]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    
    
    // MARK: 버튼 누르면 새로운 할일 추가 할 수 있도록 구현
    
    @IBAction func addCellButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "할 일을 추가해 주세요.", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "입력하세요"
        }
        
        let plusAction = UIAlertAction(title: "추가", style: .default) { [weak self] (_) in
                guard let textField = alert.textFields?.first, 
                      let text = textField.text else { return }
            let newTodo = Todo(id: self?.cellData.count ?? 0, title: text, isCompleted: false)
                self?.cellData.append(newTodo)
                self?.myTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(plusAction)
        alert.addAction(cancelAction)

        
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        // MARK: celllabel  Todo 내 입력된 title 값으로 표시되도록 구현 , 스위치 기본 off , on으로 변경 시 lebel 취소선 구현
        
        var todo = cellData[indexPath.row]
        cell.cellLabel.text = todo.title
        cell.toggleSwitch.isOn = todo.isCompleted
        
        cell.onSwitchToggle = { isOn in
            
            if isOn {
                let attributeString = NSMutableAttributedString(string: cell.cellLabel.text ?? "")
                attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.cellLabel.attributedText = attributeString
            } else {
                let attributeString = NSMutableAttributedString(string: cell.cellLabel.text ?? "")
                attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
                cell.cellLabel.attributedText = attributeString
            }
            
            self.cellData[indexPath.row].isCompleted = isOn
            
        }
        
        return cell
    }
}
