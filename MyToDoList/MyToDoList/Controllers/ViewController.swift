//
//  ViewController.swift
//  MyToDoList
//
//  Created by 김시종 on 3/25/24.
//

import UIKit

class ViewController: UIViewController {

    var todoArray: [Todo] = []
    var todoDataManager = DataManager()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "ToDoList📔"
        
        todoDataManager.makeTodoData()
        todoArray = todoDataManager.getTodoData()
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            editButton.title = "Edit"
            tableView.setEditing(false, animated: true)
        } else {
            editButton.title = "Done"
            tableView.setEditing(true, animated: true)
        }
    }
    
    
    
    
    // MARK: - 버튼 누를 경우, 알럿 띄우고 텍스트필드 열어 새로운 셀 입력
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일을 추가해 주세요.", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "입력하세요"
        }
        
        let plusAction = UIAlertAction(title: "추가", style: .default) { [weak self] (_) in
            guard let textField = alert.textFields?.first,
                  let text = textField.text else { return }
            let newTodo = Todo(id: self?.todoArray.count ?? 0, title: text, isCompleted: false)
            self?.todoArray.append(newTodo)
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(plusAction)
        alert.addAction(cancelAction)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - 셀 지우기
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
    

// MARK: - DataSource , Delegate 함수 구현 (셀 불러오기 , 취소선 생성)

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        let todo = todoArray[indexPath.row]
        
        cell.cellLabel.text = todo.title
        cell.checkButton.isSelected = todo.isCompleted
        
        if cell.checkButton.isSelected {
            let cancelLine = todo.title.strikeThrough()
            cell.cellLabel.attributedText = cancelLine
        } else {
            cell.cellLabel.attributedText = NSAttributedString(string: todo.title)
        }
        
        return cell
    }
    
    
}



extension ViewController: TodoCellDelegate {
    func didTapButton(_ cell: TodoCell, isSelected: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        todoArray[indexPath.row].isCompleted = isSelected
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}





extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension String {
  func removeStrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0 , range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}



