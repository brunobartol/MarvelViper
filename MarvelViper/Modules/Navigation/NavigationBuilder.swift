import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    static func build(rootView: UIViewController) -> UINavigationController {
        
        let textStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBackground,
            .font: UIFont.init(name: "AvenirNext-DemiBold", size: 22.0)!
        ]
        
        let largeTextStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBackground,
            .font: UIFont.init(name: "AvenirNext-DemiBold", size: 28.0)!
        ]
        
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.navigationBar.barTintColor = UIColor.label
        navigationController.navigationBar.tintColor = UIColor.systemBackground
        navigationController.navigationBar.titleTextAttributes = textStyleAttributes
        navigationController.navigationBar.largeTitleTextAttributes = largeTextStyleAttributes
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
