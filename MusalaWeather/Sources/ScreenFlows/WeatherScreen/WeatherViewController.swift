// Copyright © 2022 Musala. All rights reserved.

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    var viewModel: WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        configureTableViewBackground()
    }

    private func configureTableViewBackground() {
        let backgroundImage: UIImage = viewModel.cityWeather.isDay ? Assets.Images.dayBackground : Assets.Images.nightBackground
        let imageView = UIImageView(image: backgroundImage.dimmed(alpha: 0.25))
        imageView.layer.opacity = 1
        imageView.contentMode = .scaleToFill
        tableView.backgroundView = UIImageView(image: backgroundImage)
    }

    private func showErrorAlert(_ errorMessage: String) {
        AlertHandler(presentingViewCtrl: self).showInformation(title: L10n.Global.Labels.error, message: errorMessage)
    }
}

// MARK: TableView DataSource Delegate

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherDetailType.allCases.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch WeatherDetailType(rawValue: indexPath.row)! {
        case .overview:
            return configureWeatherOverviewCell(at: indexPath)
        case .humidityAndVisibility, .windAndAirPressure:
            return configureWeatherDetailsCell(at: indexPath)
        }
    }

    private func configureWeatherOverviewCell(at indexPath: IndexPath) -> WeatherOverviewTableViewCell {
        let overviewCell: WeatherOverviewTableViewCell = tableView.dequeueCell(for: indexPath)
        if let data = viewModel.cellData(weatherDataType: WeatherDetailType(rawValue: indexPath.row)!) as? WeatherOverviewCellData {
            overviewCell.model = data
        }
        return overviewCell
    }
    
    private func configureWeatherDetailsCell(at indexPath: IndexPath) -> WeatherDetailsTableViewCell {
        let detailsCell: WeatherDetailsTableViewCell = tableView.dequeueCell(for: indexPath)
        if let data = viewModel.cellData(weatherDataType: WeatherDetailType(rawValue: indexPath.row)!) as? WeatherDetailsCellData {
            detailsCell.setData(data)
        }
        return detailsCell
    }
}

// MARK: TableView Delegate

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch WeatherDetailType(rawValue: indexPath.row)! {
        case .overview:
            return 250
        case .windAndAirPressure, .humidityAndVisibility:
            return 75
        }
    }
}
