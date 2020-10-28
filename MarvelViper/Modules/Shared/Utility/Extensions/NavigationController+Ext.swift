import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

public extension UINavigationController {
    
    static func build(rootView: UIViewController) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootView)
        
        return navigationController
    }
}
