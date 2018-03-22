import UIKit
import LeadKit
import TableKit

final class PizzaListViewController: UIViewController {

    var viewModel: PizzaListViewModel!

    @IBOutlet private weak var tableView: UITableView!

    private lazy var tableDirector: TableDirector = {
        TableDirector(tableView: tableView)
    }()

    private lazy var paginationWrapper = {
        PaginationWrapper(wrappedView: AnyPaginationWrappableView(view: tableView),
                          cursor: viewModel.cursor,
                          delegate: self)
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

}

extension PizzaListViewController: PaginationWrapperDelegate {

    typealias DataSourceType = PizzaListingCursor

    func paginationWrapper(didLoad newItems: [Pizza],
                           using dataSource: PizzaListingCursor) {

        tableDirector.append(rows: newItems.tableRows)
    }

    func paginationWrapper(didReload allItems: [Pizza],
                           using dataSource: PizzaListingCursor) {

        tableDirector.replace(withRows: allItems.tableRows)
    }

    func retryLoadMoreButtonIsAboutToShow() {
        // nothing
    }

    func retryLoadMoreButtonIsAboutToHide() {
        // nothing
    }

    func clearView() {
        tableDirector.replace(withSections: [])
    }

}

extension PizzaListViewController: ConfigurableController {

    func bindViews() {
        paginationWrapper.reload()
    }

}

private extension Array where Element == Pizza {

    var tableRows: [TableRow<PizzaCell>] {
        return map { TableRow(item: PizzaCellViewModel(pizza: $0)) }
    }
//
//    var tableRows: [Row] {
//        return []
//    }

}
