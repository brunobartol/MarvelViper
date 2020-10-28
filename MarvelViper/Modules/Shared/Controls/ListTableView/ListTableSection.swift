import Foundation
import RxDataSources

struct ListTableSection {
    var header: UUID
    var items: [Item]
}

extension ListTableSection: AnimatableSectionModelType {
    
    typealias Item = ComicSummary
    typealias Identity = UUID
    
    var identity: UUID {
        header
    }
    
    init(original: ListTableSection, items: [ComicSummary]) {
        self = original
        self.items = items
    }
}

extension ListTableSection {
    
    init(items: [Item]) {
        self.init(header: UUID(), items: items)
    }
    
    static func sections(usingItems items: [Item]) -> [ListTableSection] {
        return [ListTableSection(items: items)]
    }
}
