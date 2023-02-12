//
//  StorageManager.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

protocol DataManager {
	func getTasks() -> [Task]
}

class StorageManager: DataManager {
	private var tasks: [Task] = [
		RegularTask(title: "Сut the grass"),
		RegularTask(title: "Take out the trash"),
		RegularTask(title: "Go to the hairdresser"),
		RegularTask(title: "Buy new goggles"),
		ImortantTask(title: "Buy a birthday present",
					 taskPriority: .medium),
		ImortantTask(title: "Submit the homework",
					 taskPriority: .hight),
		ImortantTask(title: "Buy cat food",
					 taskPriority: .hight),
		ImortantTask(title: "Download a new game",
					 taskPriority: .low)
	]
	
	func getTasks() -> [Task] {
		return tasks
	}
}
