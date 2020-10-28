import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol CharacterDetailPresentation {
    typealias Input = ()
    typealias Output = (
        characterName: Driver<String>,
        characterDescription: Driver<String?>,
        comicList: Driver<[ListTableSection]>,
        characterImage: Driver<ApiImage?>
    )
    typealias PresenterBuilder = (CharacterDetailPresentation.Input) -> CharacterDetailPresentation

    var input: Input { get }
    var output: Output { get }
}

class CharacterDetailPresenter: CharacterDetailPresentation {
    
    var input: Input
    var output: Output
    
    typealias CharacterDetailUseCases = (
        input: (),
        output: ()
    )
    
    private let dependencies: Dependencies
    private let router: CharacterDetailWireframe
    private let useCases: CharacterDetailUseCases
    private let bag = DisposeBag()
    
    typealias Dependencies = (
        character: Character,
        router: CharacterDetailWireframe,
        useCases: CharacterDetailUseCases
    )
    
    init(
        input: Input,
        dependencies: Dependencies
    ) {
        self.input = input
        self.dependencies = dependencies
        self.router = dependencies.router
        self.useCases = dependencies.useCases
        self.output = CharacterDetailPresenter.output(
            input: self.input,
            dependencies: self.dependencies
        )
        self.process()
    }
}

private extension CharacterDetailPresenter {
    static func output(input: Input, dependencies: Dependencies) -> Output {
        let character = Driver<Character>.just(dependencies.character)
        
        return (
            characterName: character.map({ $0.name! }),
            characterDescription: character.map({ $0.description }),
            comicList: character.map({ ($0.comics?.items ?? []) }).map(ListTableSection.sections(usingItems:)),
            characterImage: character.map({ $0.thumbnail })
        )
    }
    
    func process() {
    }
}
