//
//  MainViewController.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//

import UIKit

// MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func reloadTableView()
}

// MARK: - MainViewController
class MainViewController: UIViewController {
    var presenter: PresenterProtocol!
    var search = UISearchController()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        setUpTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstreints()
    }
}
//MARK: -TableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let track = presenter.tracks?[indexPath.row],
              let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
        let image = cell.myImageView.image
        presenter.ingectionTrack(track: track, image: image)
    }
}

//MARK: - TableViewDataSourse
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MainTableViewCell
        presenter.cellData(indexPath: indexPath, cell: cell)
        return cell
    }
}
//MARK: -PresenterViewProtocol
extension MainViewController: MainViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}

//MARK: SearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchText
        let text = search.replacingOccurrences(of: " ", with: "+")
        presenter?.getTrack(serch: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.isActive = false
    }
}

//MARK: -Private func
private extension MainViewController {
    func createSearchBar() {
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = search
    }
    
    func setUpTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstreints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
