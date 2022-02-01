// Copyright © 2022 Musala. All rights reserved.

import UIKit

class CityDetailsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    private var alertHandler: AlertHandler!
    var viewModel: CityDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModels()
        setupTableView()
        fetchWeatherDetails()
    }

    private func setupModels() {
        alertHandler = AlertHandler(presentingViewCtrl: self)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    private func fetchWeatherDetails() {
        activityIndicator.startAnimating()
        viewModel.fetchWeatherDetails { [weak self] result in
            DispatchQueue.main.async {
                self?.handleResponse(result)
            }
        }
    }

    private func handleResponse(_ result: Result<Bool, Error>) {
        activityIndicator.stopAnimating()
        switch result {
        case .success:
            tableView.reloadData()
        case let .failure(error):
            alertHandler.showInformation(title: L10n.Global.Labels.error, message: error.localizedDescription)
        }
    }
}

extension CityDetailsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfDays
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherData = viewModel.cellData[indexPath.row]

        let cell: CityDetailsTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.selectionStyle = .none
        cell.model = CityDetailsTableViewCellData(
            date: weatherData.applicableDate,
            minTemp: weatherData.minTemp,
            maxTemp: weatherData.maxTemp
        )

        viewModel.fetchIcon(for: weatherData.weatherStateAbbr) { data in
            cell.setImage(data)
        }

        return cell
    }
}

extension CityDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weatherData = viewModel.weatherData else { return }
        let data = viewModel.cellData[indexPath.row]
        let viewModel = WeatherViewModel(weatherDetails: data, cityWeather: weatherData)
        let weatherViewCtrl = WeatherViewController.instantiate(from: "Main")
        weatherViewCtrl.viewModel = viewModel
        navigationController?.pushViewController(weatherViewCtrl, animated: true)
    }
}
