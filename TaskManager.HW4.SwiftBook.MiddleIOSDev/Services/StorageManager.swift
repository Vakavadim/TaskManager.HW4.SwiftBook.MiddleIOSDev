//
//  StorageManager.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

protocol IStorageManager {
	func fetchData() -> [Task]
}

class StorageManager: IStorageManager {

	private var tasks: [Task] = [
		RegularTask(title: "Сut the grass", completed: true),
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
	
	func fetchData() -> [Task] {
		let overdueTask = ImortantTask(title: "Buy Bitcoin in 2014", taskPriority: .medium)
		overdueTask.deadLine = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
		tasks.append(overdueTask)
		return tasks
	}
}
