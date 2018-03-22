import LeadKit

struct PizzaListAssembly {}

extension PizzaListAssembly: ModuleConfigurator {

    func configure(input: PizzaListViewController) {
        let viewModel = PizzaListViewModel()
        input.viewModel = viewModel
    }

}
