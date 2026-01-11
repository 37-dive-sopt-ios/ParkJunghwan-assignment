//
//  PostView.swift
//  PotiStudy
//
//  Created by 박정환 on 1/11/26.
//

import UIKit
import Then
import SnapKit

final class PostView: UIView {

    static let cellReuseID = "PostCell"

    let fetchButton = UIButton(type: .system).then {
        $0.setTitle("Posts 불러오기", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }

    let activityIndicator = UIActivityIndicatorView(style: .medium).then {
        $0.hidesWhenStopped = true
    }

    let errorLabel = UILabel().then {
        $0.textColor = .systemRed
        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 0
        $0.isHidden = true
    }

    let emptyStateLabel = UILabel().then {
        $0.text = "버튼을 눌러 Posts를 불러와 주세요!"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .secondaryLabel
    }

    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.tableFooterView = UIView()
    }

    let refreshControl = UIRefreshControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        addSubview(fetchButton)
        addSubview(activityIndicator)
        addSubview(errorLabel)
        addSubview(tableView)
        addSubview(emptyStateLabel)

        fetchButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.centerX.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints {
            $0.centerY.equalTo(fetchButton)
            $0.leading.equalTo(fetchButton.snp.trailing).offset(8)
        }

        errorLabel.snp.makeConstraints {
            $0.top.equalTo(fetchButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        emptyStateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            fetchButton.isEnabled = false
        } else {
            activityIndicator.stopAnimating()
            fetchButton.isEnabled = true
        }
    }
}
