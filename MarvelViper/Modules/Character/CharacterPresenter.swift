import UIKit
import RxSwift
import RxCocoa

protocol CharacterPresentation {
    typealias Output = (
        characters: Driver<[Character]>,
        showDetails: Driver<Character>
    )
    typealias Input = (
        searchName: Driver<String?>,
        showDetails: Driver<Character>
    )
    
    var output: Output { get }
    
    typealias PresenterBuilder = (CharacterPresentation.Input) -> CharacterPresentation
}

class CharacterPresenter: CharacterPresentation {

    private let bag = DisposeBag()
    private let characters = PublishRelay<[Character]>()
    
    var output: CharacterPresentation.Output
    let router: CharacterWireframe

    typealias UseCases = (
        characterList: (_ name: String) -> Single<[Character]>, ()
    )
    let useCases: UseCases
        
    init(
        input: CharacterPresentation.Input,
        router: CharacterWireframe,
        useCases: UseCases
    ) {
        self.router = router
        self.useCases = useCases
        self.output = CharacterPresenter.output(
            input: input,
            characters: characters
        )
        self.setupBinding(input: input)
    }
}

private extension CharacterPresenter {
    
    static func output(input: CharacterPresentation.Input, characters: PublishRelay<[Character]>) -> CharacterPresentation.Output {
        return (
            characters: characters.asDriver(onErrorDriveWith: .never()),
            showDetails: input.showDetails.asDriver()
        )
    }
    
    func setupBinding(input: CharacterPresenter.Input) -> Void {
        input.searchName
            .asObservable()
            .flatMap ({ [weak self] name -> Driver<[Character]> in
                guard let self = self else { return .never() }
                
                return self.useCases.characterList(name!)
                    .asDriver { (error) in
                        guard case .genericError = error as? ApiError else { return .never() }
                        return .never()
                    }
            })
            .do(onNext: { [weak self] (characters) in
                self?.characters.accept(characters)
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        input.showDetails
            .asObservable()
            .do(onNext: { [weak self] (character) in
                self?.router.toCharacter(character: character)
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
    }
}
