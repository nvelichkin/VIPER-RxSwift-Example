//
//  PostsListViewController.swift
//  Viper-RxSwift-Example
//
//  Created by Nikita Velichkin on 19/01/2020.
//  Copyright (c) 2020 Nikita Velichkin. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class PostsListViewController: UIViewController {
    typealias PostSection = AnimatableSectionModel<String, Post>
    
    // MARK: - Public properties -
    var presenter: PostsListPresenterInterface!

    // MARK: - Private properties -
    @IBOutlet private var tableView: UITableView!
    private var dataSource: RxTableViewSectionedAnimatedDataSource<PostSection>!
    internal let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: - Extensions -

extension PostsListViewController: PostsListViewInterface {
}

private extension PostsListViewController {
    func configure() {
        setupTableView()
        let input = buildInputs()
        setupBindings(withInput: input)
    }
    
    private func buildInputs() -> PostsList.ViewInput {
        let output = PostsList.ViewOutput(didSelectPost: tableView.rx.modelSelected(Post.self))
        return presenter.configure(with: output)
    }
    
    private func setupBindings(withInput input: PostsList.ViewInput) {
        input.posts
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        dataSource = RxTableViewSectionedAnimatedDataSource<PostSection>(configureCell: configureCell)
    }
    
    private var configureCell: RxTableViewSectionedAnimatedDataSource<PostSection>.ConfigureCell {
        return { dataSource, tableView, indexPath, post in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PostCell")
            cell.textLabel?.text = post.title
            cell.detailTextLabel?.text = post.body
            cell.selectionStyle = .none
            
            return cell
        }
    }

}
