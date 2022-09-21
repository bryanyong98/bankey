//
//  AccountSummaryVC.swift
//  Bankey
//
//  Created by Bryan Yong on 11/09/2022.
//

import UIKit

class AccountSummaryVC: UIViewController {
            
    // Request Models
    var profile : Profile?
    var accounts : [Account] = []
    
    // View Models
    var accountCellViewModel : [AccountSummaryCell.ViewModel] = []
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: String(), date: Date())
    
    let stackView = UIStackView()
    let label = UILabel()
    
    // Components
    let headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()
    var isLoaded = false
    
    // Networking
    var profileManager : ProfileManageable = ProfileManager()
    
    // Error alert
    lazy var errorAlert : UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    lazy var btnLogout : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = btnLogout
    }
    
    private func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons(){
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
    }
}

extension AccountSummaryVC {
    
    private func setup(){
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        fetchDataAndLoadViews()
        setupRefreshControl()
        setupSkeletons()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = appColor
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseId)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchDataAndLoadViews() {
        
        let group = DispatchGroup()
        
        fetchProfile(group: group, userId: "1")
        fetchAccounts(group: group, userId: "1")

        group.notify(queue: .main){
            self.tableView.refreshControl?.endRefreshing()
            guard let profile = self.profile else { return }
            
            self.isLoaded = true
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)
            self.tableView.reloadData()
        }
    }
    
    private func fetchProfile(group: DispatchGroup, userId: String){
        group.enter()
        profileManager.fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
        }
        group.leave()
    }
    
    private func fetchAccounts(group: DispatchGroup, userId: String){
        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        group.leave()
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]){
        accountCellViewModel = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true, completion: nil)
    }
    
    private func displayError(_ error: NetworkError){

        let titleAndMessage = getTitleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }
    
    private func getTitleAndMessage(for error: NetworkError) -> (String, String){
        let title: String
        let message: String
        
        switch error {
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
            
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        }
        
        return (title, message)
    }
    
    private func setupTableHeaderView(){
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
}

extension AccountSummaryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard !accountCellViewModel.isEmpty else {return UITableViewCell()}
        let account = accountCellViewModel[indexPath.row]
        
        if isLoaded {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseId, for: indexPath) as? AccountSummaryCell else {return UITableViewCell()}
            cell.configure(with: account)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as? SkeletonCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Actions
extension AccountSummaryVC {
    @objc private func logoutTapped(){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent(){
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchDataAndLoadViews()
    }
    
    private func reset(){
        profile = nil
        accounts = []
        isLoaded = false
    }
}

extension AccountSummaryVC {
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String){
        return getTitleAndMessage(for: error)
    }
    
    func forceFetchProfile(){
        fetchProfile(group: DispatchGroup(), userId: "1")
    }
}

