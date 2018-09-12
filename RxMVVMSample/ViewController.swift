import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let numberOfBadges = 15
    private var viewModel: ViewModel!
    
    private let selectedTapPublishRelay = PublishRelay<Int>()
    private var selectedTapSignal: Signal<Int> {
        return selectedTapPublishRelay.asSignal()
    }
    private let selectableTapPublishRelay = PublishRelay<Int>()
    private var selectableTapSignal: Signal<Int> {
        return selectableTapPublishRelay.asSignal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BadgeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "badgeCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .plain, target: nil, action: nil)
        
        viewModel = ViewModel(inputs: ViewModel.Inputs(danTap: (navigationItem.rightBarButtonItem?.rx.tap.asSignal())!,
                                                       selectedTap: selectedTapSignal,
                                                       selectableTap: selectableTapSignal),
                              dependency: ViewModel.Dependency())
        let outputs = viewModel.transform()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 3 : 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "badgeCell", for: indexPath) as? BadgeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = (indexPath.section == 0) ? UIColor.lightGray : UIColor.white
        cell.configure(badgeColor: UIColor.random)
        if indexPath.section == 0 {
            cell.button.rx.tap.asSignal()
                .map { indexPath.row }
                .emit(to: selectedTapPublishRelay)
                .disposed(by: cell.disposeBag)
        } else {
            cell.button.rx.tap.asSignal()
                .map { indexPath.row }
                .emit(to: selectableTapPublishRelay)
                .disposed(by: cell.disposeBag)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 2
        let numberOfItemOfSection: CGFloat = 3
        let cellSize: CGFloat = view.bounds.width / numberOfItemOfSection - spacing
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
