import LeadKit
import PinLayout

private extension CGFloat {

    static let verticalMargin: CGFloat = 3
    static let horizontalMargin: CGFloat = 8

}

final class PizzaPriceView: UIView {

    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .lightGray

        return label
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .white

        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor

        [sizeLabel,
         priceLabel].forEach { addSubview($0) }
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
        pin.width(size.width)

        // 2) Layout the contentView's controls
        layout()

        // 3) Returns a size that contains all controls
        return CGSize(width: frame.width, height: priceLabel.frame.maxY + .verticalMargin)
    }

}

extension PizzaPriceView: ConfigurableView {

    func configure(with viewModel: Price) {
        sizeLabel.text = viewModel.sizeString
        priceLabel.text = viewModel.priceString

        setNeedsLayout()
    }

}

extension PizzaPriceView {

    convenience init(price: Price) {
        self.init()
        self.configure(with: price)
    }

}

private extension PizzaPriceView {

    func layout() {
        sizeLabel.pin
            .horizontally(.horizontalMargin)
            .vertically(.verticalMargin)
            .sizeToFit(.heightFlexible)

        priceLabel.pin
            .below(of: sizeLabel)
            .start(to: sizeLabel.edge.start)
            .end(to: sizeLabel.edge.end)
            .sizeToFit(.heightFlexible)
    }

}

private extension Price {

    var sizeString: String {
        return "\(size) см"
    }

    var priceString: String {
        return "\(price) ₽"
    }

}
