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



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let todo = cellData[indexPath.row]
        cell.cellLabel.text = todo.title
        
        return cell
    }
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addCellButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    
    
    
    var cellData:[Todo] = [
        Todo(id: 1, title: "공부하기", isCompleted: false),
        Todo(id: 2, title: "열공하기", isCompleted: false)
        
    ]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func makeUI() {
        
    }
    
    
    
    // MARK: 버튼 누르면 새로운 할일 추가 할 수 있도록 구현
    
    @IBAction func addCellButtonTapped(_ sender: UIButton) {
        print("버튼이 눌렸습니다.")
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


