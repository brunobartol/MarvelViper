import RxSwift

protocol CharacterUseCase {
    func characterList(by name: String) -> Single<[Character]>
}

class CharacterInteractor {
    let service: CharacterServiceType
    
    init(service: CharacterServiceType) {
        self.service = service
    }
}

extension CharacterInteractor: CharacterUseCase {
    func characterList(by name: String) -> Single<[Character]> {
        return self.service
            .charactersByName(name: name)
            .map { (statusCode, data) in
                data
            }
    }
}
