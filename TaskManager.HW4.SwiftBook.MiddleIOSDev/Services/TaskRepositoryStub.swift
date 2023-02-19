//
//  StorageManager.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

protocol ITaskRepository {
	func getTasks() -> [Task]
}

class TaskRepositoryStub: ITaskRepository {

	private var tasks: [Task] = [
		RegularTask(title: "Сut the grass", completed: true),
		RegularTask(title: "Take out the trash"),
		RegularTask(title: "Go to the hairdresser"),
		RegularTask(title: "Buy new goggles"),
		ImportantTask(title: "Buy a birthday present",
					 taskPriority: .medium),
		ImportantTask(title: "Submit the homework",
					 taskPriority: .hight),
		ImportantTask(title: "Buy cat food",
					 taskPriority: .hight),
		ImportantTask(title: "Download a new game",
					 taskPriority: .low)
	]
	
	func getTasks() -> [Task] {
		let overdueTask = ImportantTask(title: "Buy Bitcoin in 2014", taskPriority: .medium)
		overdueTask.deadLine = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
		tasks.append(overdueTask)
		return tasks
	}
}
