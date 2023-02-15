//
//  TaskManager.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

protocol ITaskManager {
	func add(task: Task)
	func delete(task: Task)
	func completeTask(task: Task)
	func getAllTasks() -> [Task]
	func getUnDoneTasks() -> [Task]
	func getCompletedTasks() -> [Task]
}


/// Task manager class which include all the Task management function.
final class TaskManager:	ITaskManager {
	private var dataManager: IStorageManager
	private var tasks: [Task] = []
	
	init(dataManager: IStorageManager = StorageManager()) {
		self.dataManager = dataManager
		self.tasks = dataManager.fetchData()
	}
	
	/// Add task function
	/// - Parameter task: Task class instance or task class inheritor instance
	func add(task: Task) {
		tasks.append(task)
	}
	
	/// Delete task function
	/// - Parameter task: Task class instance or task class inheritor instance contained in the tasks array
	func delete(task: Task) {
		tasks.removeAll { $0 === task }
	}
	
	/// Change the parameter Complete of the Task for the opposite
	/// - Parameter task: Task class instance or task class inheritor instance contained in the tasks array
	func completeTask(task: Task) {
		for i in tasks {
			if i === task {
				task.completed.toggle()
			}
		}
	}
	
	/// The function returns all the tasks which contain in the tasks array
	/// - Returns: Array of the Task class instances and inheritor instances
	func getAllTasks() -> [Task] {
		return tasks
	}
	
	///  The function returns the array of task instances which parameter Completed is false
	/// - Returns: Array of the Task class instances and inheritor instances
	func getUnDoneTasks() -> [Task] {
		return tasks.filter{$0.completed == false}
	}
	
	///  The function returns the array of task instances which parameter Completed is true
	/// - Returns: Array of the Task class instances and inheritor instances
	func getCompletedTasks() -> [Task] {
		return tasks.filter{$0.completed == true}
	}
}
