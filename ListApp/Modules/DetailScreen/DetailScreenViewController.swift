//
//  DetailScreenViewController.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit
import Utility
import Extensions
import Kingfisher

private typealias Module = DetailScreenModule

extension Module {
    final class ViewController: BaseViewController, DetailScreenDisplayLogic {
        var interactor: DetailScreenBusinessLogic?
        var router: (NSObjectProtocol & DetailScreenRoutingLogic & DetailScreenDataPassing)?

        // MARK: - UIComponents
        private lazy var scrollView: UIScrollView = .init()
        private lazy var rootView: UIView = .init()

        // MARK: - Stack Views
        private lazy var contentStackView: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack0
            $0.spacing = 24
            $0.alignment = .center
        }

        var infoStackView: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack0
            $0.distribution = .equalSpacing
            $0.spacing = 16
        }

        private lazy var photoImageView: UIImageView = build {
            $0.contentMode = .scaleAspectFill
            $0.image = AppAssets.Placeholder.avatarPlaceholder.image
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }

        private lazy var titleLabel: UILabel = build {
            $0 <~ Style.Label.commonBold24
        }

        // MARK: View lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            setupUI()
            interactor?.fetchData()
        }

        func displaySomething(with item: DetailScreenModule.Models.ViewModel) {
            setupInfo(with: item)
        }
    }
}

private extension Module.ViewController {
    func setupUI() {
        title = AppLocale.DetailScreen.title
        view.backgroundColor = AppColors.Bachground.common.color

        setupViews()
        setupConsstraints()
    }

    func setupViews() {
        view.addSubviews(scrollView)

        scrollView.addSubviews(rootView)
        rootView.addSubviews(contentStackView)

        contentStackView.addArrangedSubviews(photoImageView, titleLabel, infoStackView)
    }

    func setupConsstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        rootView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(32)
        }

        photoImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
    }

    func setupInfo(with model: Module.Models.ViewModel) {
        photoImageView.kf.setImage(with: model.image.link, placeholder: AppAssets.Placeholder.avatarPlaceholder.image)
        titleLabel.text = model.name

        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.status, detail: model.status)
        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.species, detail: model.species)
        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.type, detail: model.type)
        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.gender, detail: model.gender)
        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.origin, detail: model.origin.name)
        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.location, detail: model.location.name)
        addInfo(with: infoStackView, title: AppLocale.DetailScreen.Model.created, detail: model.created)
    }

    func addInfo(with rootStackView: UIStackView, title: String, detail: String) {
        let rootView: UIView = build {
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
            $0.backgroundColor = AppColors.Bachground.info.color
        }

        let stackView: UIStackView = build {
            $0 <~ Style.Stack.defaultHorizontalStack0
            $0.distribution = .equalSpacing
        }

        let titleLabel: UILabel = .init() <~ Style.Label.commonRegular12
        let detailLabel: UILabel = .init() <~ Style.Label.commonRegular12

        titleLabel.text = title
        detailLabel.text = detail

        rootView.addSubviews(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        stackView.addArrangedSubviews(titleLabel, detailLabel)
        rootStackView.addArrangedSubviews(rootView)
    }
}
