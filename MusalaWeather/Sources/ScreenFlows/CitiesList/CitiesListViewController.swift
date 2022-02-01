// Copyright © 2022 Musala. All rights reserved.

import UIKit

class CitiesListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private var alertHandler: AlertHandler!
    var viewModel: CitiesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModels()
        setupTableView()
        fetchCities()
    }

    private func setupModels() {
        viewModel = CitiesListViewModel()
        alertHandler = AlertHandler(presentingViewCtrl: self)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    private func fetchCities() {
        viewModel.fetchCities { [weak self] result in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case let .failure(error):
                self?.alertHandler.showInformation(title: L10n.Global.Labels.error, message: error.localizedDescription)
            }
        }
    }
}

extension CitiesListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.citiesList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.citiesList[indexPath.row]

        let cell: CitiesListTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.model = city.name
        cell.selectionStyle = .none
        return cell
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.citiesList[indexPath.row]
        let viewModel = CityDetailsViewModel(cityId: city.id)
        let detailsViewCtrl = CityDetailsViewController.instantiate(from: "Main")
        detailsViewCtrl.viewModel = viewModel
        navigationController?.pushViewController(detailsViewCtrl, animated: true)
    }
}
