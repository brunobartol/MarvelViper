import RxSwift
import RxRelay

protocol CharactersUseCases {
    func characterList(by name: String) -> Completable
}

public final class CharactersInteractor {
    
    private let service: CharacterServiceType
    private let charactersRelay: PublishRelay<[Character]> = PublishRelay<[Character]>()
    lazy var characters: Observable<[Character]> = self.charactersRelay.asObservable()
    private let bag = DisposeBag()
    
    
    init(service: CharacterServiceType) {
        self.service = service
    }
}

extension CharactersInteractor: CharactersUseCases {
    func characterList(by name: String) -> Completable {
        return self.service
            .charactersByName(name: name)
            .map({ [charactersRelay] (statusCode, data) in
                charactersRelay.accept(data)
            })
            .asCompletable()
    }
}
