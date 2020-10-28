import UIKit

public final class WindowBuilder {
    
    public static func build(windowScene: UIWindowScene) -> UIWindow {
        let window = Window(windowScene: windowScene)
        
        let landingModule = LandingBuilder.build
        let tabbarModule = TabBarBuilder.build
        
        let router = WindowRouter(
            window: window,
            submodules: (
                landingModule: landingModule,
                tabbarModule: tabbarModule
            )
        )
        
        let presenter = WindowPresenter(router: router)

        window.presenter = presenter
        
        return window
    }
}

