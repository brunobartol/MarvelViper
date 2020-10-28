import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import func AVFoundation.AVMakeRect

class CharacterDetailViewController: UIViewController {
    
    private var presenter: CharacterDetailPresentation?
    private let bag = DisposeBag()
    
    var presenterBuilder: CharacterDetailPresentation.PresenterBuilder!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var comicsTableView: UITableView!    
    @IBOutlet weak var seriesTableView: UITableView!
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<ListTableSection>(configureCell: { (_, tableView, indexPath, item) in
        
        guard let cell = self.comicsTableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.configure(using: item)
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = presenterBuilder(())
        
        setupUI()
        setupBinding()
    }
}

private extension CharacterDetailViewController {
    func setupUI() {
        
        imageView.contentMode = .scaleAspectFill
        
        comicsTableView.register(
            UINib(nibName: "ListTableViewCell", bundle: Bundle(for: ListTableViewCell.self)),
            forCellReuseIdentifier: String(describing: ListTableViewCell.self)
        )
        comicsTableView.separatorStyle = .none
        
        seriesTableView.register(
            UINib(nibName: "CharacterCell", bundle: Bundle(for: CharacterCell.self)),
            forCellReuseIdentifier: String(describing: CharacterCell.self)
        )
        
        seriesTableView.separatorStyle = .none
    }
    
    func setupBinding() {
        self.presenter?.output.characterName
            .drive(titleLabel.rx.text)
            .disposed(by: bag)
        
        self.presenter?.output.characterDescription
            .drive(descriptionTextView.rx.text)
            .disposed(by: bag)
        
        self.presenter?.output.comicList
            .drive(self.comicsTableView.rx.items(dataSource: datasource))
            .disposed(by: bag)
        
        self.presenter?.output.characterImage
            .asObservable()
            .flatMap({ thumbnail -> Observable<UIImage> in
                AsyncImage(imageLoader: ImageLoader(thumbnail: thumbnail, size: .large)) { loader -> Observable<UIImage> in
                    loader.fetchImage().subscribe().disposed(by: self.bag)
                    return loader.image
                    }.image
            })
            .asDriver(onErrorJustReturn: UIImage(named: "emptyImage")!)
            .drive(self.imageView.rx.image)
            .disposed(by: bag)
    }
}
