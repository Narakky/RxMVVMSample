import UIKit
import RxSwift

final class BadgeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var button: UIButton!

    private(set) var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        button.tintColor = UIColor.white
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    func configure(badgeColor: UIColor) {
        layoutIfNeeded()

        button.backgroundColor = badgeColor
        button.layer.cornerRadius = button.bounds.width / 2
    }
}
