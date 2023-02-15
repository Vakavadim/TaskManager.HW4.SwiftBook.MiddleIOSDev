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
	

	var taskData: TaskCellData! {
			didSet {
				setupUI()
			}
	}
	
	private func setupUI() {
		if taskData.priority != nil {
			titleLabel.text = taskData.title
			taskDeadlineLabel.textColor = taskData.isOutOfDeadline! ? .red : .darkGray
			taskDeadlineLabel.text = taskData.date
			taskPriorityLabel.text = "\(taskData.priority!)"
			checkMark.image = taskData.completed ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
			checkMark.tintColor = taskData.completed ? .systemBlue : .systemGray3
		} else {
			titleLabel.text = taskData.title
			taskPriorityLabel.text = ""
			taskDeadlineLabel.text = ""
			checkMark.image = taskData.completed ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
			checkMark.tintColor = taskData.completed ? .systemBlue : .systemGray3
		}
	}
	
	private func isOutOfDadeline(date: Date) -> Bool {
		return Date() > date
	}

}
