import Foundation
import RxSwift

protocol CharacterServiceType {
    func charactersByName(name: String) -> Single<(statusCode: Int, data: [Character])>
}

public final class CharacterService {
    public static let shared = CharacterService()
    private let decoder = JSONDecoder()
    
    private init() {}
}

extension CharacterService: CharacterServiceType {
    func charactersByName(name: String) -> Single<(statusCode: Int, data: [Character])> {
        return Single<(statusCode: Int, data: [Character])>.create { (single) -> Disposable in
            do {
                try MarvelAPI
                    .charactersbyName(name: name)
                    .request()
                    .responseJSON { response in
                        guard
                            let data = response.data,
                            let statusCode = response.response?.statusCode
                        else {
                            return
                        }
                        
                        do {
                            let characterResponse = try self.decoder.decode(CharacterDataWrapper.self, from: data)
                            guard let characters = characterResponse.data?.results else { return }
                            single(.success((statusCode: statusCode, data: characters)))
                        } catch {
                            //TODO: Error handling
                            single(.error(ApiError.genericError))
                        }
                    }
            } catch {
                //TODO: Error handling
                single(.error(ApiError.genericError))
            }
            
            return Disposables.create { }
        }
    }
}

