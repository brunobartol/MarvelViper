import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CharacterViewController: UIViewController {
    
    private static let characterCellID = "characterCellID"
    private var presenter: CharacterPresentation?
    private let bag = DisposeBag()
    
    var presenterBuilder: CharacterPresentation.PresenterBuilder!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: CharacterViewController.characterCellID)
        
        presenter = presenterBuilder((
            searchName: searchBar.rx.value,
            showDetails: tableView.rx.modelSelected(Character.self).asDriver()
        ))
        setupBinding()
    }
}

private extension CharacterViewController {
    func setupBinding() -> Void {
        presenter?.output.characters
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CharacterViewController.characterCellID, cellType: CharacterCell.self)) { index, character, cell in
                cell.title.text = character.name!
            }
            .disposed(by: bag)
    }
}

//MARK: - Search Bar

extension Reactive where Base: UISearchBar {
    var value: Driver<String?> {
        let inputText = self.base.searchTextField.rx.text
        
        return inputText
            .orEmpty
            .asDriver()
            .debounce(.milliseconds(500))
            .map ({ $0 })
    }
}
