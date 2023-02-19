//
//  TaskListPresenter.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 19.02.2023.
//

import Foundation

/// This protocol describe functionality of TaskListPresenter class.
protocol TaskListPresenterProtocol {
	func getTaskData()
	func doneTask(indexPath: IndexPath)
	func getSectionsTitles() -> [String]
	func getTasksForSection(completed: [TaskCellData], unDone: [TaskCellData], section: Int) -> [TaskCellData]
}

/// TaskListPresenter class keep the business logic of the application away from the UI methods layer and provide to the view only requred data.
class TaskListPresenter: TaskListPresenterProtocol {
	private unowned let view: TaskListViewProtocol
	private let taskManager: ITaskManager
	
	required init(view: TaskListViewProtocol, taskManager: ITaskManager) {
		self.view = view
		self.taskManager = taskManager
	}
	
	/// Public presenter method which preparing and transfer the data to the view.
	func getTaskData() {
		let comletedTaskData = taskManager.getCompletedTasks().map {
			matTaskToTaskCellData(task: $0)
		}
		
		let unDoneTaskData = taskManager.getUnDoneTasks().map {
			matTaskToTaskCellData(task: $0)
		}
		
		view.render(viewData: ViewData(
			comletedTaskData: comletedTaskData,
			unDoneTaskData: unDoneTaskData)
		)
	}
	
	/// Public presenter method which change the parameter Complete of the Task for the opposite.
	/// - Parameter indexPath: A list of indexes that together represent the path to a specific location in a tree of nested arrays.
	func doneTask(indexPath: IndexPath) {
		let task = {
			switch indexPath.section {
			case 1:
				return self.taskManager.getCompletedTasks()[indexPath.row]
			default:
				return self.taskManager.getUnDoneTasks()[indexPath.row]
			}
		}
		taskManager.completeTask(task: task())
	}
	
	
	/// Public presenter method which returns an array of title for tableView section.
	/// - Returns: an array of title for tableView section.
	func getSectionsTitles() -> [String] {
		return ["Umcompleted", "Completed"]
	}
	
	/// Public presenter method which contains the segmentation logic of the taskLIst.
	/// - Parameters:
	///   - completed: TaskCellData array of completed task.
	///   - unDone: TaskCellData array of uncompleted task.
	///   - sectionIndex: sectionIndex.
	/// - Returns: TaskCellData array of the certain section of the table view.
	func getTasksForSection(completed: [TaskCellData], unDone: [TaskCellData], section: Int) -> [TaskCellData] {
		switch section {
		case 1:
			return completed
		default:
			return unDone
		}
	}

	/// Preparing date data for string representation.
	/// - Parameter date: struct Date.
	/// - Returns: Date string in format "dd/MM/YY".
	private func dateString(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "dd/MM/YY"
		dateFormatter.string(from: date)
		return dateFormatter.string(from: date)
	}
	
	/// Preparing the task data for using in UI layer and implementing in TaskCell.
	/// - Parameter task: Task class instance or task class inheritor instance.
	/// - Returns: TaskCellData structure.
	private func matTaskToTaskCellData(task: Task) -> TaskCellData {
		if let task = task as? ImportantTask {
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
	
	/// Checking the date for the overdue.
	/// - Parameter date: Date of the deadline.
	/// - Returns: Returns true if the date was overdue.
	private func isOutOfDadeline(date: Date) -> Bool {
		return Date() > date
	}
}
