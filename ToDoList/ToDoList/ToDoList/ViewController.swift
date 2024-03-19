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
    
    
    
    let cellData:[Todo] = [
        Todo(id: 1, title: "공부하기", isCompleted: false)
        
    ]
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func makeUI() {
        
    }
    
    
    
    
    @IBAction func addCellButtonTapped(_ sender: UIButton) {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.addTarget(self, action: #selector(addCellButtonTapped(_:)), for: .touchUpInside)
        
        
                
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    @objc func addCellButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "할 일을 추가해주세요", message: "추가하시겠습니까?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "입력하세요"
        }
        
        
        
    }
    
    
    
}
