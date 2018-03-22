import UIKit
import PlaygroundSupport
@testable import PizzaUI
import RxSwift
import RxCocoa

PlaygroundPage.current.needsIndefiniteExecution = true

//let vc = NavigationService.createPizzaListViewController()
//
//PlaygroundPage.current.liveView = vc


// testing

let cell = PizzaCell(style: .default
    , reuseIdentifier: PizzaCell.xibName)
cell.frame = CGRect(x: 0, y: 0, width: 420, height: 128 + 32)

let priceView = PizzaPriceView()
priceView.frame = CGRect(x: 0, y: 0, width: 56, height: 44)

let disposeBag = DisposeBag()

PizzaListingCursor()
    .flatMap { PizzaCellViewModel(pizza: $0) }
    .loadNextBatch()
    .observeOn(MainScheduler.instance)
    .subscribe(onSuccess: { elements in
        cell.configure(with: elements[0])
        priceView.configure(with: elements[0].pizza.prices[1])
        return ()
    })
    .disposed(by: disposeBag)


PlaygroundPage.current.needsIndefiniteExecution = true

PlaygroundPage.current.liveView = cell
//PlaygroundPage.current.liveView = priceView

