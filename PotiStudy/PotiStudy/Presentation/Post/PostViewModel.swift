//
//  MovieViewModel.swift
//  MEGABOX
//
//  Created by 박정환 on 12/17/25.
//

import Foundation
import Combine

final class PostViewModel {

    struct Input {
        let fetchTrigger: AnyPublisher<Void, Never>
        let refreshTrigger: AnyPublisher<Void, Never>
    }

    struct Output {
        let posts: AnyPublisher<[Post], Never>
        let isLoading: AnyPublisher<Bool, Never>
        let errorMessage: AnyPublisher<String?, Never>
    }

    private let fetchPostsUseCase: FetchPostsUseCase
    private var cancellables = Set<AnyCancellable>()

    // 내부 상태(출력 소스)
    private let postsSubject = CurrentValueSubject<[Post], Never>([])
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String?, Never>(nil)

    init(fetchPostsUseCase: FetchPostsUseCase) {
        self.fetchPostsUseCase = fetchPostsUseCase
    }

    func transform(input: Input) -> Output {

        let trigger = Publishers.Merge(input.fetchTrigger, input.refreshTrigger)

        trigger
            .sink { [weak self] in
                self?.loadPosts()
            }
            .store(in: &cancellables)

        return Output(
            posts: postsSubject.eraseToAnyPublisher(),
            isLoading: loadingSubject.eraseToAnyPublisher(),
            errorMessage: errorSubject.eraseToAnyPublisher()
        )
    }

    private func loadPosts() {
        loadingSubject.send(true)
        errorSubject.send(nil)

        Task { [weak self] in
            guard let self else { return }
            do {
                let posts = try await fetchPostsUseCase.execute()
                self.postsSubject.send(posts)
            } catch {
                self.errorSubject.send("불러오기 실패: \(error.localizedDescription)")
                self.postsSubject.send([])
            }
            self.loadingSubject.send(false)
        }
    }
}
