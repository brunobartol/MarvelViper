import UIKit

public final class LandingBuilder {
    static func build(onContinue: @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Landing", bundle: nil)
        let view = LandingViewController.instantiate(from: storyboard)
        
        let router = LandingRouter(viewController: view, onTapCompletion: onContinue, submodules: ())
                
        view.presenterBuilder = {
            LandingPresenter(
                input: $0,
                router: router
            )
        }
        
        return view
    }
}

