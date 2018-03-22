import TableKit
import FlexLayout
import PinLayout
import Nuke

private extension CGFloat {

    static let cellPadding: CGFloat = 12
    static let separatorHeight: CGFloat = 0.5

}

final class PizzaCell: UITableViewCell {

    private let flexContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true

        return imageView
    }()

    private let pizzaNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .darkGray

        return label
    }()

    private let ingridientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 2

        return label
    }()

    private let horizontalSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray

        return separator
    }()

    private var priceViews: [PizzaPriceView] = []

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLayout()

        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)

        // 2) Layout the contentView's controls
        layout()

        // 3) Returns a size that contains all controls
        return CGSize(width: contentView.frame.width,
                      height: contentView.subviewsMaxY + .separatorHeight)
    }

}

extension PizzaCell: ConfigurableCell {

    func configure(with viewModel: PizzaCellViewModel) {
        priceViews.forEach { $0.removeFromSuperview() }
        priceViews = viewModel.pizza.prices.map { PizzaPriceView(price: $0) }

        pizzaNameLabel.text = viewModel.pizza.name
        ingridientsLabel.text = viewModel.ingridients

        reconfigureLayout()

        Manager.shared.loadImage(with: viewModel.pizza.imageUrl,
                                 into: pizzaImageView)

    }

}

extension PizzaCell {

    func configureLayout() {
        [flexContainerView, horizontalSeparator].forEach {
            contentView.addSubview($0)
        }
    }

    func reconfigureLayout() {
        flexContainerView.removeAllSubviews()

        flexContainerView.flex
            .addItem()
            .direction(.row)
            .padding(.cellPadding)
            .define { flex in
                flex.addItem(pizzaImageView)
                    .width(100)
                    .aspectRatio(1)

                flex.addItem()
                    .direction(.column)
                    .marginLeft(10)
                    .shrink(1)
                    .define { flex in
                        flex.addItem(pizzaNameLabel).marginBottom(4)
                        flex.addItem(ingridientsLabel).marginBottom(8)
                        flex.addItem()
                            .direction(.row)
                            .height(36)
                            .define { flex in
                                priceViews.forEach {
                                    flex.addItem($0)
                                        .direction(.column)
                                        .maxWidth(72)
                                        .minWidth(56)
                                        .marginRight(4)
                                        .shrink(1)
                                        .grow(1)
                                }
                        }
                }
        }

        setNeedsLayout()
    }

    func layout() {
        flexContainerView.pin.top().horizontally().layout()

        // 2) Then let the flexbox container layout itself. Here the container's height will be adjusted automatically.
        flexContainerView.flex.layout(mode: .adjustHeight)

        horizontalSeparator.pin
            .below(of: flexContainerView)
            .height(.separatorHeight)
            .start(.cellPadding)
            .end()
    }

}

private extension UIView {

    func removeAllSubviews() {
        return subviews.forEach { $0.removeFromSuperview() }
    }

    var subviewsMaxY: CGFloat {
        return subviews
            .map { $0.frame.maxY }
            .max() ?? frame.maxY
    }

}
