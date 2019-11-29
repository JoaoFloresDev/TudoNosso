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
    //MARK: Text inputs
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var adressInput: UITextField!
    //MARK: Categories
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
    //MARK: Type of job
    @IBOutlet weak var recurrentCheck: Checkbox!
    @IBOutlet weak var punctualCheck: Checkbox!
    
    //MARK: - PROPERTIES
    var jobDescription: String?
    var selectedCategories: [CategoryEnum] = []
    var selectedType: String?
    
    var createdJob: Job?
    
    var jobDetailsSegueID = "toCreatedJobDetails"
    
    enum Alerts {
        case title
        case typeOfJob
        case openings
        
        var message: String {
            switch self {
            case .title:            return "O título da vaga é obrigatório!"
            case .typeOfJob:        return "O tipo da vaga é obrigatório!"
            case .openings:        return "Informe quantas vagas há para esta oportunidade!"
            }
        }
    }
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        setTextFields()
        setTypeButtons()
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
    
    func setTypeButtons() {
        recurrentCheck.addTarget(self, action: #selector(typeChoosen(sender:)), for: .touchUpInside)
        punctualCheck.addTarget(self, action: #selector(typeChoosen(sender:)), for: .touchUpInside)
    }
    
    @objc func typeChoosen(sender: UIButton!) {
        switch sender {
        case recurrentCheck:
            recurrentCheck.isChecked = true
            punctualCheck.isChecked = false
            selectedType = "Recorrente"
        case punctualCheck:
            recurrentCheck.isChecked = false
            punctualCheck.isChecked = true
            selectedType = "Pontual"
        default:        break
        }
    }
    
    func createJob() {
        //TODO: terminar
        guard let jobTitle = titleInput.text, titleInput.text != "" else {
            showAlert(type: .title)
            return
        }
        
        guard let type = selectedType else {
            showAlert(type: .typeOfJob)
            return
        }
        
        guard let openings = Int(numberInput.text ?? "") else {
            showAlert(type: .openings)
            return
        }
        
        guard let ongEmail = Local.userMail else { return }
        let ongID = Base64Converter.decodeBase64AsString(ongEmail)
        
//        let job = Job(title: jobTitle, category: <#T##CategoryEnum#>, vacancyType: selectedType, vacancyNumber: openings, organizationID: ongID, localization: <#T##CLLocationCoordinate2D#>, status: true, channelID: <#T##String#>)
        
        if let description = descriptionInput.text, descriptionInput.text != "" {
//            job.desc = description
        }
    }
    
    func showAlert(type: Alerts){
        let alert = UIAlertController(title: "Campo obrigatório", message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendi", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: - ACTIONS
    @IBAction func publishJobPressed(_ sender: Any) {
        createJob()
        //TODO: enviar para banco de dados
    }
    
    //MARK: - SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case jobDetailsSegueID:
//            //TODO: enviar Job criado para tela de detalhes
//        default:        break
//        }
    }
}

//MARK: UITextFieldDelegate
extension AddJobTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
