//
//  AddJobTableViewController.swift
//  TudoNosso
//
//  Created by Priscila Zucato on 27/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit

class AddJobTableViewController: UITableViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var adressInput: UITextField!
    
    @IBOutlet weak var cultureAndEducation: Checkbox!
    @IBOutlet weak var health: Checkbox!
    @IBOutlet weak var education: Checkbox!
    @IBOutlet weak var sports: Checkbox!
    @IBOutlet weak var elders: Checkbox!
    @IBOutlet weak var refugees: Checkbox!
    @IBOutlet weak var childrenCheck: Checkbox!
    @IBOutlet weak var lgbtq: Checkbox!
    @IBOutlet weak var environment: Checkbox!
    @IBOutlet weak var poverty: Checkbox!
    @IBOutlet weak var animals: Checkbox!
    @IBOutlet weak var training: Checkbox!
    
    @IBOutlet weak var recurrentCheck: Checkbox!
    @IBOutlet weak var punctualCheck: Checkbox!
    
    //MARK: - PROPERTIES
    var jobTitle: String?
    var jobDescription: String?
    var selectedCategories: [CategoryEnum] = []
    var selectedType: Job.Type?
    
    var createdJob: Job?
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
    }
    
    //MARK: - METHODS
    func setNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Cancelar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setTextFields() {
        titleInput.delegate = self
        descriptionInput.delegate = self
        numberInput.delegate = self
        adressInput.delegate = self
    }
    
    func createJob() {
        //TODO
    }
    
    //MARK: - ACTIONS
    @IBAction func publishJobPressed(_ sender: Any) {
        createJob()
        //TODO: enviar para banco de dados
    }
}

//MARK: UITextFieldDelegate
extension AddJobTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case titleInput:
            jobTitle = titleInput.text
        case descriptionInput:
            jobDescription = descriptionInput.text
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
