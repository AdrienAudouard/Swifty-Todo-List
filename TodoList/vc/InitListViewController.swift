//
//  InitListViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class InitListViewController: UIViewController {

    @IBOutlet weak var listTableView: ListTableView!
    @IBOutlet weak var backgroundTextField: UIView!
    
    @IBOutlet weak var colorCollectionView: ColorCollectionView!
    @IBOutlet weak var taskNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundTextField.layer.masksToBounds = true
        backgroundTextField.layer.cornerRadius = 15
        backgroundTextField.layer.borderWidth = 1
        backgroundTextField.layer.borderColor = UIColor(hex: "95a5a6").cgColor
        
        taskNameTF.delegate = self
        
        listTableView.lists = ListManager.getAll()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        colorCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        let cell = colorCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! ColorCollectionViewCell
        colorCollectionView.selectedColorIndex = 0
        cell.isSelect = true
    }
    
    func createList() {
        guard taskNameTF.text != "" else {
            return
        }
        
        let name = taskNameTF.text
        let color = colorCollectionView.selectedColor
        
        let list = ListManager.create(name: name!, color: color!)
        
        listTableView.lists.append(list)
        
        taskNameTF.text = ""
        
        //listTableView.scrollToRow(at: IndexPath.init(row: listTableView.lists.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        createList()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard listTableView.lists.count > 0 else {
            alert(title: "Error", message: "You must create at least one list", button: "Ok")
            return
        }
        
        performSegue(withIdentifier: "CustomTabBarController", sender: nil)
    }
}

extension InitListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createList()
        return false
    }
}
