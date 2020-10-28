public final class UseCasesFactory {
    private static let characterService = CharacterService.shared
    
    public static let charactersInteractor = CharactersInteractor(service: characterService)
}
