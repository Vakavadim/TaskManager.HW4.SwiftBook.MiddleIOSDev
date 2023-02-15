//
//  Task.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 11.02.2023.
//

import Foundation

/// Task priority enum which is used to set the priority in ImortantTask class
enum TaskPriority: Int, Comparable {
	case hight
	case medium
	case low
	
	static func < (lhs: TaskPriority, rhs: TaskPriority) -> Bool {
		return lhs.rawValue < rhs.rawValue
	}
}

/// The base class of the task object
class Task {
	var title: String
	var completed: Bool
	
	init(title: String, completed: Bool = false) {
		self.title = title
		self.completed = completed
	}
}

/// The inheritor of the Task class for implementing a regular task without any additional data
final class RegularTask: Task {}

/// The inheritor of the Task class for implementing am important class with priority level and deadline date
final class ImortantTask: Task {
	private var _deadLine: Date? = nil
	
	var taskPriority: TaskPriority
	var deadLine: Date {
		get {
			if self._deadLine != nil {
				return _deadLine!
			} else {
				switch taskPriority {
				case .hight:
					return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
				case .medium:
					return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
				case .low:
					return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
				}
			}
		} set {
			_deadLine = newValue
		}
	}
	
	init(title: String, completed: Bool = false, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title, completed: completed)
	}
}
