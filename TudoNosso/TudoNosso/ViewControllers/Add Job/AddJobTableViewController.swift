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
    @IBOutlet weak var cultureAndArt: Checkbox!
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
    
    var job: Job?
    
    var jobDetailsSegueID = "toCreatedJobDetails"
    
    var categoriesDict : [CategoryEnum:Checkbox] = [:]
    
    enum Alerts {
        case title
        case typeOfJob
        case openings
        case adress
        
        var message: String {
            switch self {
            case .title:            return "O título da vaga é obrigatório!"
            case .typeOfJob:        return "O tipo da vaga é obrigatório!"
            case .openings:         return "Informe quantas vagas há para esta oportunidade!"
            case .adress:           return "Informe um endereço para referência!"
            }
        }
    }
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        setTextFields()
        setTypeButtons()
        
        createCategoriesDictionary()
        
        if job != nil { // user is editing a job
            fillFieldsForEdition()
        }
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
        recurrentCheck.addTarget(self, action: #selector(typeChosen(sender:)), for: .touchUpInside)
        punctualCheck.addTarget(self, action: #selector(typeChosen(sender:)), for: .touchUpInside)
    }
    
    @objc func typeChosen(sender: UIButton!) {
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
    
    func createCategoriesDictionary() {
        categoriesDict = [CategoryEnum.cultureAndArt : self.cultureAndArt,
                          CategoryEnum.health : self.health,
                          CategoryEnum.education : self.education,
                          CategoryEnum.sport : self.sports,
                          CategoryEnum.elderly : self.elders,
                          CategoryEnum.refugees : self.refugees,
                          CategoryEnum.kids : self.childrenCheck,
                          CategoryEnum.lgbtq : self.lgbtq,
                          CategoryEnum.environment : self.environment,
                          CategoryEnum.againstPoverty : self.poverty,
                          CategoryEnum.animalProtection : self.animals,
                          CategoryEnum.professionalTraining : self.training
                            ]
    }
    
    func fillFieldsForEdition() {
        if let job = job {
            titleInput.text = job.title
            descriptionInput.text = job.desc
            
            for category in job.categories {
                if let checkbox = categoriesDict[category] {
                    checkbox.isChecked = true
                }
            }
            
            switch job.vacancyType {
            case "Recorrente":
                typeChosen(sender: recurrentCheck)
            case "Pontual":
                typeChosen(sender: punctualCheck)
            default:    break
            }
            
            numberInput.text = String(job.vacancyNumber)
            
            //TODO: adress
        }
    }
    
    func createJob() {
        //TODO: terminar
        guard let ongEmail = Local.userMail else { return }
        let ongID = Base64Converter.decodeBase64AsString(ongEmail)
        
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
        
        guard let adress = adressInput.text, adressInput.text != "" else {
            showAlert(type: .adress)
            return
        }
        
        
//        job = Job(title: jobTitle, category: <#T##CategoryEnum#>, vacancyType: selectedType, vacancyNumber: openings, organizationID: ongID, localization: <#T##CLLocationCoordinate2D#>, status: true, channelID: <#T##String#>)
        
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
        let jobDM = JobDM()
//        jobDM.save(job: job)
//        performSegue(withIdentifier: jobDetailsSegueID, sender: self)
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
