//
//  TaskCell.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 15.02.2023.
//

import UIKit

class TaskCell: UITableViewCell {
	static let indetifire = "TaskCell"
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var taskPriorityLabel: UILabel!
	@IBOutlet weak var taskDeadlineLabel: UILabel!
	@IBOutlet weak var checkMark: UIImageView!
	

	var taskData: MainModel.ViewData.Task! {
			didSet {
				setupUI()
			}
	}
	
	private func setupUI() {
		switch taskData {
		case .importantTask(let task):
			titleLabel.text = task.name
			taskDeadlineLabel.textColor = task.isOverdue ? .red : .darkGray
			taskDeadlineLabel.text = task.deadLine
			taskPriorityLabel.text = task.priority
			checkMark.image = task.isDone ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
			checkMark.tintColor = task.isDone ? .systemBlue : .systemGray3
		case .regularTask(let task):
			titleLabel.text = task.name
			taskPriorityLabel.text = ""
			taskDeadlineLabel.text = ""
			checkMark.image = task.isDone ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
			checkMark.tintColor = task.isDone ? .systemBlue : .systemGray3
		case .none:
			titleLabel.text = "none"
		}
	}
}
