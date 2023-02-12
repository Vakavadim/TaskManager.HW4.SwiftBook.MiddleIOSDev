//
//  TaskManager.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

protocol ITaskManager {
	func getNumberOfTasks() -> Int
	func getTaskData(at indexPath: IndexPath) -> TaskCellData?
	func comleteTask(at indexPath: IndexPath)
}

class TaskManager:	ITaskManager {
	private var dataManager: DataManager
	private var tasks: [Task] {
		dataManager.getTasks()
	}
	
	init(dataManager: DataManager = StorageManager()) {
		self.dataManager = dataManager
	}
	
	func getNumberOfTasks() -> Int {
		tasks.count
	}
	
	func getTaskData(at indexPath: IndexPath) -> TaskCellData? {
		let task = tasks[indexPath.row]
		if let task = task as? ImortantTask {
			let data = TaskCellData(title: task.title,
									comleted: task.comleted,
									priority: task.taskPriority,
									date: task.deadLine)
			return data
		} else if let task = task as? RegularTask  {
			let data = TaskCellData(title: task.title,
									comleted: task.comleted,
									priority: nil,
									date: nil)
			return data
		}
		return nil
	}
	
	func comleteTask(at indexPath: IndexPath) {
		tasks[indexPath.row].comleted.toggle()
	}
}
