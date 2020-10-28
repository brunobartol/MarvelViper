import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol CharactersPresentation {
    
    typealias Input = (
        searchName: Driver<String?>,
        characterSelected: Driver<CharacterCellViewModel>
    )
    typealias Output = (
        sections: Driver<[CharacterTableSection]>, ()
    )
    typealias PresenterBuilder = (CharactersPresentation.Input) -> CharactersPresentation
    
    var input: Input { get }
    var output: Output { get }
    
}

class CharactersPresenter: CharactersPresentation {
    
    var input: Input
    var output: CharactersPresentation.Output
    
    private let bag = DisposeBag()
    
    typealias UseCases = (
        input: (
            fetchCharacters: (_ name: String) -> Completable, ()
        ),
        output: (
            characters: Observable<[Character]>, ()
        )
    )
    
    private let router: CharactersWireframe
    private let useCases: UseCases
    private let dependencies: Dependencies
    
    typealias Dependencies = (router: CharactersWireframe, useCases: UseCases)
    
    
    
    init(
        input: CharactersPresentation.Input,
        dependencies: Dependencies
    ) {
        self.input = input
        self.dependencies = dependencies
        self.router = dependencies.router
        self.useCases = dependencies.useCases
        self.output = CharactersPresenter.output(
            input: self.input,
            useCases: self.useCases
        )
        self.process()
    }
}

private extension CharactersPresenter {
    
    static func output(input: CharactersPresentation.Input, useCases: UseCases) -> CharactersPresentation.Output {
        
        let characters = useCases.output.characters
            .map(CharacterCellViewModel.build(models:))
            .map(CharacterTableSection.sections(usingItems:))
            .asDriver(onErrorJustReturn: [])
        
        return (
            sections: characters, ()
        )
    }
    
    func process() -> Void {
        
        self.input.searchName
            .asObservable()
            .do (onNext: { [useCases] (name) in
                
                guard let name = name else { return }
                useCases.input.fetchCharacters(name).subscribe().disposed(by: self.bag)
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.input.characterSelected
            .asObservable()
            .withLatestFrom(self.useCases.output.characters) { viewModel, characters in
                characters.filter({ $0.id == viewModel.id })
            }
            .map({ $0.first })
            .map({ [router] character in
                
                guard let character = character else { return }
                
                router.routeToCharacterDetail(for: character)
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        self.output.sections
            .drive()
            .disposed(by: bag)
    }
}

//MARK: - CharactersTable sections
struct CharacterTableSection {
    var header: Int
    var items: [Item]
}

extension CharacterTableSection: AnimatableSectionModelType {
    
    typealias Item = CharacterCellViewModel
    typealias Identity = Int
    
    var identity: Int {
        header
    }
    
    init(original: CharacterTableSection, items: [CharacterCellViewModel]) {
        self = original
        self.items = items
    }
}

extension CharacterTableSection {
    
    init(items: [Item]) {
        self.init(header: 0, items: items)
    }
    
    static func sections(usingItems items: [Item]) -> [CharacterTableSection] {
        return [CharacterTableSection(items: items)]
    }
}

//MARK: - ViewModel for table view cell
struct CharacterCellViewModel {
    private let model: Character
    
    let id: Int?
    let titleLabel: BehaviorRelay<String> = BehaviorRelay(value: "")
    let descriptionLabel: BehaviorRelay<String> = BehaviorRelay(value: "")
    let image: ApiImage?
    
}

extension CharacterCellViewModel {
    
    init(using model: Character) {
        self.model = model
        self.id = self.model.id
        self.titleLabel.accept(model.name!)
        self.descriptionLabel.accept(model.description!)
        self.image = self.model.thumbnail
    }
    
    static func build(models: [Character]) -> [CharacterCellViewModel] {
        return models.compactMap({ CharacterCellViewModel(using: $0) })
    }
}

extension CharacterCellViewModel: IdentifiableType, Equatable {
    typealias Identity = Int
    
    var identity: Int {
        return id!
    }
    
    static func == (lhs: CharacterCellViewModel, rhs: CharacterCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
