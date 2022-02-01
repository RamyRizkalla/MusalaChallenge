// Copyright © 2022 Musala. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.register()
        populateCitiesOnFirstLaunch()
        return true
    }

    private func populateCitiesOnFirstLaunch() {
        guard UserDefaults.standard.isFirstLaunch else { return }

        let sofia = CityDomainModel(id: "839722", name: "Sofia")
        let ny = CityDomainModel(id: "2459115", name: "NY")
        let tokyo = CityDomainModel(id: "1118370", name: "Tokyo")
        CityLocalRepository().save(cites: [sofia, ny, tokyo])
        UserDefaults.standard.isFirstLaunch = false
    }
}

extension UserDefaults {
    func register() {
        register(defaults: ["isFirstLaunch" : true])
    }

    var isFirstLaunch: Bool {
        set {
            set(newValue, forKey: "isFirstLaunch")
        }
        get {
            return bool(forKey: "isFirstLaunch")
        }
    }
}
