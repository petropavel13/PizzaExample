import LeadKit
import UIKit

extension NavigationService {

    static func createPizzaListViewController() -> PizzaListViewController {
        let controller = PizzaListViewController(nibName: PizzaListViewController.xibName, bundle: Bundle(for: PizzaListViewController.self))
        let assembly = PizzaListAssembly()
        assembly.configure(input: controller)
        return controller
    }

}
