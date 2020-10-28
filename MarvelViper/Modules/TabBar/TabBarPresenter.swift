protocol TabBarWireframe {
    
}

class TabBarPresenter: TabBarPresentation {
    
    typealias UseCases = ()
    
    weak var view: TabBarView?
    var useCases: UseCases
    
    init(useCases: UseCases) {
        self.useCases = useCases 
    }
}
