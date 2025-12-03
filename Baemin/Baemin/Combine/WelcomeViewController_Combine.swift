//
//  WelcomeViewController.swift
//  sopt-37th-01Junior
//
//  Created by 박정환 on 10/11/25.
//

import UIKit

import SnapKit
import Then
import Combine

protocol BackButtonDelegate: AnyObject {
    func didTapBackButton()
}

final class WelcomeViewController_Combine: UIViewController {

    var viewModel: WelcomeViewModel?
    weak var delegate: BackButtonDelegate?

    private var cancellables = Set<AnyCancellable>()

    private let navigationBar = CustomNavigationBar(title: "대체 뼈짐 누가 시켰어??")
    private let welcomeImageView = UIImageView()
    private let welcomeTitle = UILabel()
    private let welcomeLabel = UILabel()
    private lazy var backToLoginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true

        setUI()
        setLayout()
        setStyle()
        bind()
    }
    
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .white
    }

    private func setLayout() {
        [navigationBar, welcomeImageView, welcomeTitle, welcomeLabel, backToLoginButton].forEach {
            self.view.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        welcomeTitle.snp.makeConstraints {
            $0.top.equalTo(welcomeImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeTitle.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        backToLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(48)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalTo(343)
        }
    }
    
    private func setStyle() {
        welcomeImageView.do {
            $0.image = UIImage(named: "welcomeImg")
        }
        
        welcomeTitle.do {
            $0.text = "환영합니다"
            $0.font = UIFont(name: "Pretendard-Bold", size: 24)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        welcomeLabel.do {
            $0.text = "???님 반가워요!"
            $0.font = UIFont(name: "Pretendard-Semibold", size: 18)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        backToLoginButton.do {
            $0.backgroundColor = .mint500
            $0.setTitle("뒤로가기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
            $0.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        }
    }

    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.$username
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                self?.welcomeLabel.text = "\(name)님 반가워요!"
            }
            .store(in: &cancellables)
    }

    @objc
    private func backToLoginButtonDidTap() {
        delegate?.didTapBackButton()
        navigationController?.popViewController(animated: true)
    }
}

#Preview() {
    let vc = WelcomeViewController_Combine()
    vc.viewModel = WelcomeViewModel(username: "OO님")
    return vc
}
