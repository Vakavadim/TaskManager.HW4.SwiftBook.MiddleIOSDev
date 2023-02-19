//
//  OrderedTaskManager.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 19.02.2023.
//

import Foundation

/// Task manager class which include all the Task management function with sorted tasks.
class OrderedTaskManager: ITaskManager {
	
	let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func add(task: Task) {
		self.taskManager.add(task: task)
	}
	
	func addTasks(tasks: [Task]) {
		self.taskManager.addTasks(tasks: tasks)
	}
	
	func delete(task: Task) {
		self.taskManager.delete(task: task)
	}
	
	func completeTask(task: Task) {
		self.taskManager.completeTask(task: task)
	}
	
	func getAllTasks() -> [Task] {
		sortTasks(tasks: taskManager.getAllTasks())
	}
	
	func getUnDoneTasks() -> [Task] {
		sortTasks(tasks: taskManager.getUnDoneTasks())
	}
	
	func getCompletedTasks() -> [Task] {
		sortTasks(tasks: taskManager.getCompletedTasks())
	}
	
	/// Sorting the array of Tasks. Important tasks are sorting by priority, Regular tasks append in the end of the array.
	/// - Parameter tasks: The array of Tasks class instance or/and task class inheritor instance.
	/// - Returns: Array of the task class instances or/and task class inheritor instances with sorted Important tasks by priority.
	func sortTasks(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
			
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
		
			if  $0 is RegularTask, $1 is ImportantTask {
				return false
			}

			return true
		}
	}
	
}
