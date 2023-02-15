//
//  TaskCellData.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 12.02.2023.
//

import Foundation

/// TaskCellData is the data structure which use to transport the data of task to ui elements
struct TaskCellData {
	let title: String
	let date: String?
	let priority: TaskPriority?
	let completed: Bool
	let isOutOfDeadline: Bool?
}
