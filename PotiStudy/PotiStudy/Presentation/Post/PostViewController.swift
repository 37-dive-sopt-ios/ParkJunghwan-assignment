//
//  PostViewController.swift
//  PotiStudy
//
//  Created by 박정환 on 1/11/26.
//

import UIKit
import Combine
final class PostViewController: UIViewController {

    private let viewModel: PostViewModel
    private let postView = PostView()

    private var cancellables = Set<AnyCancellable>()
    private var posts: [Post] = []

    // Combine Inputs
    private let fetchTap = PassthroughSubject<Void, Never>()
    private let refreshTap = PassthroughSubject<Void, Never>()

    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = postView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"

        postView.tableView.dataSource = self
        postView.tableView.delegate = self

        bindUI()
        bindViewModel()
    }

    private func bindUI() {
        postView.fetchButton.addTarget(self, action: #selector(didTapFetchButton), for: .touchUpInside)

        postView.tableView.refreshControl = postView.refreshControl
        postView.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }

    private func bindViewModel() {
        let output = viewModel.transform(
            input: .init(
                fetchTrigger: fetchTap.eraseToAnyPublisher(),
                refreshTrigger: refreshTap.eraseToAnyPublisher()
            )
        )

        output.posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] posts in
                guard let self else { return }
                self.posts = posts
                self.postView.emptyStateLabel.isHidden = !posts.isEmpty
                self.postView.tableView.reloadData()
            }
            .store(in: &cancellables)

        output.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                self.postView.setLoading(isLoading)
                if !isLoading {
                    self.postView.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)

        output.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] msg in
                guard let self else { return }
                self.postView.errorLabel.text = msg
                self.postView.errorLabel.isHidden = (msg == nil)
            }
            .store(in: &cancellables)
    }

    @objc private func didTapFetchButton() {
        fetchTap.send(())
    }

    @objc private func didPullToRefresh() {
        refreshTap.send(())
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostView.cellReuseID)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: PostView.cellReuseID)

        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        cell.detailTextLabel?.numberOfLines = 2
        cell.selectionStyle = .none
        return cell
    }
}
