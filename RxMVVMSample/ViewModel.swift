//
//  ViewModel.swift
//  RxMVVMSample
//
//  Created by Narakky on 2018/09/10.
//  Copyright © 2018年 棤木亮翔. All rights reserved.
//

import RxSwift
import RxCocoa

final class ViewModel: ViewModelType {
    struct Dependency {

    }

    struct Inputs {
        let danTap: Signal<Void>
        let selectedTap: Signal<Int>
        let selectableTap: Signal<Int>
    }

    struct Outputs {
        let canComplete: Driver<Bool>
        let selectedBadges: Driver<[Int]>
        let selectableBadges: Driver<[Int]>
        let badgeDidSelect: Signal<Int>
        let badgeDidDeselect: Signal<Int>
    }

    private let inputs: Inputs
    private let dependency: Dependency

    private let selectedBadgesRelay = BehaviorRelay<[Int]>(value: [])
    private let badgeDidSelectRelay = PublishRelay<Int>()
    private let badgeDidDeselectRelay = PublishRelay<Int>()

    private let disposeBag = DisposeBag()

    init(inputs: ViewModel.Inputs, dependency: ViewModel.Dependency) {
        self.inputs = inputs
        self.dependency = dependency
    }

    func transform() -> ViewModel.Outputs {
        let allBadgesRelay = BehaviorRelay<[Int]>(value: [])
        let allBadges = allBadgesRelay.asDriver()

        let selectedBadges = selectedBadgesRelay.asDriver()

        let selectableBadges = Driver.combineLatest(allBadges, selectedBadges).map {
            return ViewModel.dropSelected(from: $0.0, without: Set($0.1))
        }

        let canComplete = selectedBadges
            .map { !$0.isEmpty }
            .asDriver()

//        inputs.danTap.emit(onNext: <#T##((()) -> Void)?##((()) -> Void)?##(()) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)

        inputs.selectedTap
            .emit(onNext: { [weak self] badge in
                guard let `self` = self else { return }
                self.deselect(badge: badge)
            }).disposed(by: disposeBag)

        inputs.selectableTap
            .emit(onNext: { [weak self] badge in
                guard let `self` = self else { return }
                self.select(badge: badge)
            }).disposed(by: disposeBag)

        return Outputs(canComplete: canComplete,
                      selectedBadges: selectedBadges,
                      selectableBadges: selectableBadges,
                      badgeDidSelect: badgeDidSelectRelay.asSignal(),
                      badgeDidDeselect: badgeDidDeselectRelay.asSignal())
    }

    // 与えられたバッジを選択状態にする。
    private func select(badge: Int) {
        let currentSelection = self.selectedBadgesRelay.value
        guard !currentSelection.contains(badge) else { return }

        var newSelection = currentSelection
        newSelection.append(badge)

        self.selectedBadgesRelay.accept(newSelection)
        self.badgeDidSelectRelay.accept(badge)
    }


    // 与えられたバッジを非選択状態にする。
    private func deselect(badge: Int) {
        let currentSelection = self.selectedBadgesRelay.value
        var newSelection = currentSelection

        guard let index = newSelection.index(of: badge) else { return }

        newSelection.remove(at: index)

        self.selectedBadgesRelay.accept(newSelection)
        self.badgeDidDeselectRelay.accept(badge)
    }

    private static func dropSelected(from allBadges: [Int], without selectedBadges: Set<Int>) -> [Int] {
        return allBadges
            .filter { !selectedBadges.contains($0) }
    }
}
