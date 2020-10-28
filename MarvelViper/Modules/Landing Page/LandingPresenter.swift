import UIKit
import RxSwift
import RxCocoa

protocol LandingPresentation {
    typealias Input = (
        buttonTap: Driver<Void>, ()
    )
    typealias Output = ()
    typealias PresenterBuilder = (LandingPresentation.Input) -> LandingPresentation
    
    var input: Input { get }
    var output: Output { get }
}

public final class LandingPresenter: LandingPresentation {
    var input: Input
    var output: Output
    
    private let router: LandingWireframe
    private let bag = DisposeBag()
    
    init(
        input: Input,
        router: LandingWireframe
    ) {
        self.input = input
        self.router = router
        self.output = LandingPresenter.output(input: self.input)
        self.process()
    }
}

private extension LandingPresenter {
    static func output(input: Input) -> Output {
        
        return ()
    }
    
    func process() {
        self.input.buttonTap
            .asObservable()
            .map({ [router] in
                router.routeToWindow()
            })
            .subscribe()
            .disposed(by: bag)
    }
}
