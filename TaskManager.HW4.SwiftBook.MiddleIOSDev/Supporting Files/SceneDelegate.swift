//
//  SceneDelegate.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		window?.makeKeyAndVisible()
		window?.rootViewController = assembly(repository: TaskRepositoryStub())
	}
	
	private func assembly(repository: ITaskRepository) -> UIViewController {
		let viewController = TaskListViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		taskManager.addTasks(tasks: repository.getTasks())
		let sectionManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = TaskListPresenter(
			view: viewController,
			sectionManager: sectionManager
		)
		viewController.presenter = presenter
		return viewController
	}
}

