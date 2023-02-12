//
//  Task.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

enum TaskPriority: Int {
	case hight
	case medium
	case low
}

class Task {
	var title: String
	var comleted = false
	
	init(title: String) {
		self.title = title
	}
}

final class RegularTask: Task {}

final class ImortantTask: Task {
	
	var taskPriority: TaskPriority
	var deadLine: Date {
		switch taskPriority {
		case .hight:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		}
	}
	
	init(title: String, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title)
	}
}
