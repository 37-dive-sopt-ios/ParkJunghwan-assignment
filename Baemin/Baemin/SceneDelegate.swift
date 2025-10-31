//
//  SceneDelegate.swift
//  sopt-37th-01Junior
//
//  Created by 박정환 on 10/11/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
      // 1. scene이 UIWindowScene으로 캐스팅 가능한지 확인하고, 아니라면 종료
        guard let windowScene = (scene as? UIWindowScene) else { return }
      // 2. UIWindow 객체를 windowScene 기반으로 생성
        let window = UIWindow(windowScene: windowScene)
      // 3. LoginViewController를 루트로 하는 UINavigationController 생성
        let vc = UINavigationController(rootViewController: LoginViewController())
      // 4. 생성한 UINavigationController를 윈도우의 루트 뷰 컨트롤러로 설정
        window.rootViewController = vc
      // 5. SceneDelegate의 window 프로퍼티에 생성한 윈도우 할당
        self.window = window
      // 6. 윈도우를 키 윈도우로 설정하고 화면에 표시
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

