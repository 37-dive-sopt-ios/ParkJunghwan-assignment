//
//  SceneDelegate.swift
//  PotiStudy
//
//  Created by 박정환 on 1/10/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      // 1.
        guard let windowScene = (scene as? UIWindowScene) else { return }
      // 2.
        let window = UIWindow(windowScene: windowScene)
      // 3.
        let service = PostService()
        let repository = PostRepository(service: service)
        let useCase = DefaultFetchPostsUseCase(repository: repository)
        let viewModel = PostViewModel(fetchPostsUseCase: useCase)
        let vc = UINavigationController(
            rootViewController: PostViewController(viewModel: viewModel)
        )
      // 4.
        window.rootViewController = vc
      // 5.
        self.window = window
      // 6.
        window.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
