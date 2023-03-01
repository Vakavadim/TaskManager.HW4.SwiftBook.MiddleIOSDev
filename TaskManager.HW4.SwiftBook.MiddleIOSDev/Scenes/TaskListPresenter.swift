//
//  TaskListPresenter.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 19.02.2023.
//

import Foundation

/// This protocol describe functionality of TaskListPresenter class.
protocol ITaskListPresenter {
	func viewIsReady()
	func didDoneButtonPressed(indexPath: IndexPath)
}

/// TaskListPresenter class keep the business logic of the application away from the UI methods layer and provide to the view only requred data.
class TaskListPresenter: ITaskListPresenter {
	private var sectionManager: ISectionForTaskManagerAdapter!
	private unowned let view: ITaskListView
	
	required init(view: ITaskListView, sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
		self.view = view
	}
	
	/// Public presenter method which preparing and transfer the data to the view.
	func viewIsReady() {
		view.render(viewData: mapViewData())
	}
	
	/// Public presenter method which change the parameter Complete of the Task for the opposite.
	/// - Parameter indexPath: A list of indexes that together represent the path to a specific location in a tree of nested arrays.
	func didDoneButtonPressed(indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		view.render(viewData: mapViewData())
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
	
	private func mapViewData() -> MainModel.ViewData {
		var sections = [MainModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = MainModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section) )
			)
			
			sections.append(sectionData)
		}
		
		return MainModel.ViewData(tasksBySections: sections)
	}
	
	private func mapTasksData(tasks: [Task]) -> [MainModel.ViewData.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> MainModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = MainModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(dateString(date: task.deadLine))",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			let result = MainModel.ViewData.RegularTask(
				name: task.title,
				isDone: task.completed
			)
			return .regularTask(result)
		}
	}
}
