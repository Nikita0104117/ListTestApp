//
//  ListScreenViewController.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 30.03.2025.
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

private typealias Module = ListScreenModule

extension Module {
    final class ViewController: BaseViewController, ListScreenDisplayLogic {
        var interactor: ListScreenBusinessLogic?
        var router: (NSObjectProtocol & ListScreenRoutingLogic)?

        // MARK: - UIComponents
        private lazy var refreshControler: UIRefreshControl = build {
            $0.addTarget(self, action: #selector(tapRefresh), for: .valueChanged)
        }

        private lazy var tableView: UITableView = build(.init(frame: .zero, style: .insetGrouped)) {
            $0.backgroundColor = AppColors.Bachground.common.color
            $0.refreshControl = refreshControler
            $0.dataSource = self
            $0.delegate = self
        }

        // MARK: View lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            setupUI()
            interactor?.fetchData(false)
        }

        func displaySomething(with difference: CollectionDifference<ListScreenModule.Models.ViewModel>) {
            updateDataSource(tableView, with: difference)
        }

        @objc func tapRefresh() {
            interactor?.fetchData(true)
        }
    }
}

private extension Module.ViewController {
    func setupUI() {
        title = AppLocale.ListScreen.title
        view.backgroundColor = AppColors.Bachground.common.color

        setupViews()
        setupConsstraints()
    }

    func setupViews() {
        view.addSubviews(tableView)
    }

    func setupConsstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateDataSource(_ tableView: UITableView, with difference: CollectionDifference<Module.Models.ViewModel>) {
        refreshControler.endRefreshing()

        tableView.performBatchUpdates {
            difference.forEach {
                switch $0 {
                    case .remove(let offset, _, _):
                        tableView.deleteRows(at: [.init(row: offset, section: .zero)], with: .automatic)
                    case .insert(let offset, _, _):
                        tableView.insertRows(at: [.init(row: offset, section: .zero)], with: .automatic)
                }
            }
        }
    }
}

// MARK: - ListScreenModule + UITableViewDataSource
extension Module.ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor?.dataSourceCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = interactor?.getDataSourceItemInfo(for: indexPath) else { return .init() }

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = item.name
        cell.imageView?.kf.setImage(with: item.image.link, placeholder: AppAssets.Placeholder.avatarPlaceholder.image)
        cell.detailTextLabel?.text = item.status

        return cell
    }
}

// MARK: - ListScreenModule + UITableViewDelegate
extension Module.ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard let router else { return }

        router.pushDetailScreen(with: indexPath.item)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - tableViewHeight * 1.1 {
            interactor?.fetchData(false)
        }
    }
}
