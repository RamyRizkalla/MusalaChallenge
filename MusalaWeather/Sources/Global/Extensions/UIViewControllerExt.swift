// Copyright © 2022 Musala. All rights reserved.

import UIKit

extension UIViewController {
    static func instantiate(from storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(identifier: "\(Self.self)") as! Self
    }
}
