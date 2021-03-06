import Foundation
import RxDataSources

struct Character: Equatable, Identifiable {
    
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: ApiImage?
    let comics: ComicList?
    let series: SeriesList?
    let stories: StoryList?
    let events: EventList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
        case comics
        case series
        case stories
        case events
    }
}

extension Character: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.thumbnail = try container.decodeIfPresent(ApiImage.self, forKey: .thumbnail)
        self.comics = try container.decodeIfPresent(ComicList.self, forKey: .comics)
        self.series = try container.decodeIfPresent(SeriesList.self, forKey: .series)
        self.stories = try container.decodeIfPresent(StoryList.self, forKey: .stories)
        self.events = try container.decodeIfPresent(EventList.self, forKey: .events)
    }
}

extension Character: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(comics, forKey: .comics)
        try container.encodeIfPresent(series, forKey: .series)
        try container.encodeIfPresent(stories, forKey: .stories)
        try container.encodeIfPresent(events, forKey: .comics)
    }
}

extension Character: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Character: IdentifiableType {
    typealias Identity = Int
    
    var identity: Int {
        return id!
    }
}

extension Character {
    static let empty: Character = Character(id: nil, name: nil, description: nil, thumbnail: nil, comics: nil, series: nil, stories: nil, events: nil)
}
