import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CharactersViewController: UIViewController {
    
    private var presenter: CharactersPresentation?
    private let bag = DisposeBag()
    
    var presenterBuilder: CharactersPresentation.PresenterBuilder!
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var emptyView: EmptyView = {
        let emptyImage = UIImage(named: "emptyImage")!
        let emptyView = EmptyView(frame: .zero)
        emptyView.configure(image: emptyImage)
        return emptyView
    }()
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<CharacterTableSection>(configureCell: { (_, tableView, indexPath, item) in
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterCell.self), for: indexPath) as? CharacterCell else { return UITableViewCell() }
        cell.configure(using: item)
        return cell
    })
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = UIBarStyle.black
        controller.searchBar.backgroundColor = .clear
        
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        presenter = presenterBuilder((
            searchName: searchController.searchBar.rx.value.asDriver(),
            characterSelected: tableView.rx.modelSelected(CharacterCellViewModel.self).asDriver()
        ))
            
        setupUI()
        setupBinding()
    }
}

private extension CharactersViewController {
    
    func setupUI() {
        
        definesPresentationContext = true
                
        tableView.register(
            UINib(nibName: "CharacterCell", bundle: Bundle(for: CharacterCell.self)),
            forCellReuseIdentifier: String(describing: CharacterCell.self)
        )
        
        tableView.separatorStyle = .none

        tableView.tableHeaderView = searchController.searchBar
    }
    
    func setupBinding() -> Void {
        
        self.presenter?.output.sections
            .drive(self.tableView.rx.items(dataSource: datasource))
            .disposed(by: bag)
        
        self.presenter?.output.sections
        .map({ $0.first! })
        .map({ $0.items.count > 0 })
        .map({ [tableView, emptyView] in
            tableView?.backgroundView = $0 ? nil : emptyView
        })
        .drive()
        .disposed(by: bag)
    }
}
