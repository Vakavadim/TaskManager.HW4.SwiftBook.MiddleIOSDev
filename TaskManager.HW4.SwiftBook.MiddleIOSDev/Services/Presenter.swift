//
//  Presenter.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 15.02.2023.
//

import Foundation

protocol IPresenter {
	func matTaskToTaskCellData(task: Task) -> TaskCellData
	func sortTasks(tasks: [Task]) -> [Task]
}


/// The Presenter class assumes responsibility for the preparation of data for presentation in UI
class Presenter: IPresenter {
	
	/// Preparing date data for string representation
	/// - Parameter date: struct Date
	/// - Returns: Date string in format "dd/MM/YY"
	private func dateString(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "dd/MM/YY"
		dateFormatter.string(from: date)
		return dateFormatter.string(from: date)
	}
	
	
	/// Checking the date for the overdue
	/// - Parameter date: Date of the deadline
	/// - Returns: Returns true if the date was overdue
	private func isOutOfDadeline(date: Date) -> Bool {
		return Date() > date
	}
	
	
	/// Preparing the task data for using in UI layer and implementing in TaskCell
	/// - Parameter task: Task class instance or task class inheritor instance
	/// - Returns: TaskCellData structure
	func matTaskToTaskCellData(task: Task) -> TaskCellData {
		if let task = task as? ImortantTask {
			let data = TaskCellData(title: task.title,
									date: dateString(date: task.deadLine),
									priority: task.taskPriority,
									completed: task.completed,
									isOutOfDeadline: isOutOfDadeline(date: task.deadLine))
			return data
		} else if let task = task as? RegularTask  {
			let data = TaskCellData(title: task.title,
									date: nil,
									priority: nil,
									completed: task.completed,
									isOutOfDeadline: nil)
			return data
		}
		return TaskCellData(title: "Error task tipe", date: nil, priority: nil, completed: false, isOutOfDeadline: nil)
	}
	
	
	/// Sorting the array of Tasks. Important tasks are sorting by priority, Regular tasks append in the end of the array.
	/// - Parameter tasks: The array of Tasks class instance or/and task class inheritor instance.
	/// - Returns: Array of the task class instances or/and task class inheritor instances with sorted Important tasks by priority.
	func sortTasks(tasks: [Task]) -> [Task] {
		var imortantTasks = tasks.compactMap { task in
			let task = task as? ImortantTask
			return task
		}
		imortantTasks.sort { $0.taskPriority < $1.taskPriority }
		
		let regularTasks = tasks.compactMap { task in
			let task = task as? RegularTask
			return task
		}
		return imortantTasks + regularTasks
	}
}
