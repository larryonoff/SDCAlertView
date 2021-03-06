import UIKit

final class ActionCell: UICollectionViewCell {

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private var highlightedBackgroundView: UIView!

    var enabled = true {
        didSet { self.titleLabel.enabled = self.enabled }
    }

    override var highlighted: Bool {
        didSet { self.highlightedBackgroundView.hidden = !self.highlighted }
    }

    func setAction(action: AlertAction, withVisualStyle visualStyle: VisualStyle) {
        action.actionView = self

        self.titleLabel.font = visualStyle.font(forAction: action)
        self.titleLabel.textColor = visualStyle.textColor(forAction: action)
        self.titleLabel.attributedText = action.attributedTitle

        self.backgroundColor = visualStyle.actionColor(forAction: action)
        self.highlightedBackgroundView.backgroundColor = visualStyle.actionHighlightColor(forAction: action)

        self.titleLabel.accessibilityLabel = action.attributedTitle?.string
        self.isAccessibilityElement = true
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        self.titleLabel.textColor = self.tintColor
    }
}

final class ActionSeparatorView: UICollectionReusableView {

    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)

        if let attributes = layoutAttributes as? ActionsCollectionViewLayoutAttributes {
            self.backgroundColor = attributes.backgroundColor
        }
    }
}
