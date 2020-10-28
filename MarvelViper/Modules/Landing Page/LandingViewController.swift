import UIKit
import RxSwift

class LandingViewController: UIViewController {
    
    private var presenter: LandingPresentation?
    private let bag = DisposeBag()
    
    var presenterBuilder: LandingPresentation.PresenterBuilder!

    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter = presenterBuilder((
            buttonTap: continueButton.rx.tap.asDriver(), ()
        ))
        
        setupUI()
        setupBinding()
        
    }
}

private extension LandingViewController {
    
    func setupUI() {
        self.continueButton.layer.borderWidth = 2
        self.continueButton.layer.cornerRadius = 10
    }
    
    func setupBinding() {
            
    }
}
