//
//  ExploreViewController.swift
//  TudoNosso
//
//  Created by Joao Flores on 04/11/19.
//  Copyright © 2019 Joao Flores. All rights reserved.
//

import UIKit
import CoreLocation


class ExploreViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var labelButtonLogin: UILabel!
    @IBOutlet weak var buttonAreaImage: UIImageView!
    //MARK: variable
    var selectedCause: String = ""
    var selectedOrganization: String = ""
    var selectedJob: Int = 0
    var organizationsList : [Organization] = []
    var filteredOrganizationsList : [Organization] = []
    var filteredOngoingJobs : [Job] = []
    let categories = ["Causas", "Organizações", "Todas as Vagas"]
    var searchController = UISearchController(searchResultsController: nil)
    var organization : Organization = Organization(name: "", address: CLLocationCoordinate2D(), email: "")
    var jobs : [Job] = []
    var backgroundQueue: OperationQueue {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        return queue
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //MARK: IBAction
    @IBAction func actionButtonLogin(_ sender: Any) {
        if let kind = Local.userKind{
            if(kind == LoginKinds.ONG.rawValue) {
                //            showCriarVaga
                //            self.performSegue(withIdentifier: "showProfile", sender: self)
            }
        }else{
            self.performSegue(withIdentifier: "showLogin", sender: self)
        }
    }
    
    //MARK: lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if #available(iOS 13, *){
            setupSearchBar()
        }
        setupJobsTableView()
        setupNavegationBar()
        //        loadData()
        
        let tipoLogin = UserDefaults.standard.string(forKey: "USER_KIND") ?? "0"
        switch tipoLogin {
        case LoginKinds.ONG.rawValue:
            labelButtonLogin.text = "Criar vaga"
        case LoginKinds.volunteer.rawValue:
            buttonLogin.alpha = 0
            labelButtonLogin.alpha = 0
            buttonAreaImage.alpha = 0
        default:
            labelButtonLogin.text = "Cadastrar ou fazer login"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        
        
        // remove border from nav bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    //MARK: setups
    func setupNavegationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xFF5900, a: 1)
        navigationController?.navigationBar.backgroundColor = UIColor(rgb: 0xFF5900, a: 1)
        navigationController?.navigationBar.tintColor = UIColor(rgb: 0xFFFFFF, a: 1)
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setupSearchBar() {
        jobsTableView.tableHeaderView = searchController.searchBar
        
        //        let searchBar = UISearchBar.appearance()
        let colText = UITextField.appearance()
        colText.textColor = .gray
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor(rgb: 0xFF5900, a: 1)
        searchController.searchBar.backgroundColor = UIColor(rgb: 0xFF5900, a: 1)
        searchController.searchBar.alpha = 1
        searchController.searchBar.setBackgroundImage(UIImage(named: "background Search"), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
        searchController.searchBar.tintColor = .white //UIColor(rgb: 0xFF5900, a: 1)
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.backgroundColor = UIColor(rgb: 0xFF5900, a: 1)
        definesPresentationContext = true
    }
    
    func setupJobsTableView() {
        jobsTableView.isHidden = false
        jobsTableView.backgroundColor = .clear
        
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
        jobsTableView.register(JobsTableViewCell.nib, forCellReuseIdentifier: JobsTableViewCell.reuseIdentifer)
        jobsTableView.register(JobsTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: JobsTableViewHeader.reuseIdentifer)
    }
    
    func setupTableView(){
        jobsTableView.backgroundColor = .clear
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
    }
    
    //MARK: filters
    private func filterJobs(for searchText: String) {
        filteredOngoingJobs = jobs.filter { player in
            return player.title.lowercased().contains(searchText.lowercased())
        }
        jobsTableView.reloadData()
    }
    
    private func filterOrganizations(for searchText: String) {
        filteredOrganizationsList = organizationsList.filter { player in
            return player.name.lowercased().contains(searchText.lowercased())
        }
        jobsTableView.reloadData()
    }
    
    //MARK: loaders
    func loadData() {
        let jobDM = JobDM()
        jobDM.find(inField: .status, withValueEqual: true, completion: { (result, error) in
            guard let result = result else { return }
            self.jobs = result
            self.jobsTableView.reloadData()
        })
        
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CategoryOportunitiesViewController {
            let vc = segue.destination as? CategoryOportunitiesViewController
            vc?.titleHeader = selectedCause
        }
            
        else if segue.destination is ProfileViewController {
            let vc = segue.destination as? ProfileViewController
            vc?.email = selectedOrganization
        }
            
        else if segue.destination is JobViewController {
            if let vc = segue.destination as? JobViewController,
                let selectedJob = sender as? Job {
                vc.job = selectedJob
            }
        }
    }
}

extension ExploreViewController :UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterJobs(for: searchController.searchBar.text ?? "")
        filterOrganizations(for: searchController.searchBar.text ?? "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredOngoingJobs.count
        }
        
        if section < 2 {
            return 1
        } else {
            return jobs.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedJob = jobs[indexPath.row]
        self.performSegue(withIdentifier: "showDetailSegue", sender: selectedJob)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive && searchController.searchBar.text != "" {
            return categories[2]
        }
        
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return 1
        }
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var typeCell = indexPath.section
        
        if searchController.isActive && searchController.searchBar.text != "" {
            typeCell = 2
        }
        
        switch typeCell {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell") as! CategoryCollectionView
            cell.tag = 0
            cell.delegate = self
            cell.organizationsList = organizationsList
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:  "cell2") as! CategoryCollectionView
            cell.tag = 1
            cell.delegate = self
            cell.loadDataOrganizations()
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.reuseIdentifer, for: indexPath) as? JobsTableViewCell else {
                fatalError("The dequeued cell is not an instance of JobsTableViewCell.")
            }
            
            let jobList: Job
            
            if searchController.isActive && searchController.searchBar.text != "" {
                jobList = filteredOngoingJobs[indexPath.row]
            } else {
                jobList = jobs[indexPath.row]
            }
            
            let ongDM = OrganizationDM()
            
            let imageDownloadOperation = BlockOperation {
                ongDM.find(ById: jobList.organizationID) { (ong, err) in
                    guard let ong = ong else { return }
                    
                    if let avatar = ong.avatar {
                        FileDM().recoverProfileImage(profilePic: avatar) { (image, error) in
                            guard let image = image else {return}
                            OperationQueue.main.addOperation {
                                cell.jobImageView.image = image
                            }
                        }
                    }
                }
            }
            
            self.backgroundQueue.addOperation(imageDownloadOperation)
            
            cell.configure(job: jobList)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ExploreViewController: CategoryCollectionViewDelegate {
    func causeSelected(_ view: CategoryCollectionView, causeTitle: String?, OrganizationEmail: String?,tagCollection: Int) {
        
        if(tagCollection == 0) {
            if let title = causeTitle {
                self.selectedCause = title
            }
            
            self.performSegue(withIdentifier: "showCauses", sender: self)
        }
            
        else {
            if let title = OrganizationEmail {
                self.selectedOrganization = title
            }
            
            self.performSegue(withIdentifier: "showProfile", sender: self)
        }
    }
}



