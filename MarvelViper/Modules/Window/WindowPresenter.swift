import Foundation

class WindowPresenter: WindowPresentation {
    
    private let router: WindowWireframe
    
    init(router: WindowWireframe) {
        self.router = router
        process()
    }
}

private extension WindowPresenter {
    func process() {
        self.router.routeToLanding()
    }
}

