import RxSwift
import RxCocoa

public extension ObservableType {
    static func createObservable<T>(_ block: @escaping () -> T) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            observer.onNext(block())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

public extension PrimitiveSequenceType where Trait == SingleTrait {
    static func createSingle<T>(_ block: @escaping () -> T) -> Single<T> {
        return Observable<T>.createObservable(block).asSingle()
    }
}
