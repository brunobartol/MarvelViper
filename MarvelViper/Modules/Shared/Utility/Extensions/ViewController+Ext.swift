import UIKit

//MARK: - Init from storyboard
public extension UIViewController {
    class func instantiate<T: UIViewController>(from storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(identifier: identifier) as! T
    }
    
    class func instantiate(from storyboard: UIStoryboard) -> Self {
        return instantiate(from: storyboard, identifier: String(describing: self))
    }
    
    class func instantiate() -> Self {
        let className = String(describing: self)
        return instantiate(from: UIStoryboard(name: className, bundle: Bundle(for: self)), identifier: className)
    }
}
