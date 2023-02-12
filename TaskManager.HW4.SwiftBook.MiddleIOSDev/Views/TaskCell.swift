//
//  TaskCell.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 12.02.2023.
//

import UIKit

class TaskCell: UITableViewCell {
	static let indetifire = "TaskCell"
	
	var taskData: TaskCellData! {
		didSet {
			if taskData.priority != nil {
				print("Did set Data")
				titleLabel.text = taskData.title
				deadline.textColor = isOutOfDadeline(date: taskData.date!) ? .red : .darkGray
				deadline.text = dateString(date: taskData.date!)
				taskPriorityLabel.text = "\(taskData.priority!)"
				checkedBox.image = taskData.comleted ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle.dotted")
			} else {
				titleLabel.text = taskData.title
				checkedBox.image = taskData.comleted ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle.dotted")
			}
		}
	}
	private let titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.font = titleLabel.font.withSize(16)
		titleLabel.numberOfLines = 0
		return titleLabel
	}()
	
	private var taskPriorityLabel: UILabel = {
		let taskPriorityLabel = UILabel()
		taskPriorityLabel.textColor = .darkGray
		taskPriorityLabel.font = taskPriorityLabel.font.withSize(16)
		taskPriorityLabel.textAlignment = .center
		return taskPriorityLabel
	}()
	
	private var deadline: UILabel = {
		let deadline = UILabel()
		deadline.font = deadline.font.withSize(16)
		return deadline
	}()
	
	private var checkedBox: UIImageView = {
		let checkedBox = UIImageView()
		return checkedBox
	}()
	private var stack: UIStackView! {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.backgroundColor = .blue
		return stack
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(titleLabel)
		contentView.addSubview(taskPriorityLabel)
		contentView.addSubview(deadline)
		contentView.addSubview(checkedBox)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let imageSize = contentView.frame.size.height/2
		let deadlineSize = contentView.frame.size.width * 0.2
		titleLabel.frame = CGRect(x: 8,
								  y: 5,
								  width: contentView.frame.size.width * 0.45,
								  height: contentView.frame.size.height - 10)
		taskPriorityLabel.frame = CGRect(x: 8 + titleLabel.frame.size.width,
								  y: 5,
								  width: contentView.frame.size.width * 0.15,
								  height: contentView.frame.size.height - 10)
		deadline.frame = CGRect(x: contentView.frame.size.width - deadlineSize - imageSize - 16,
								  y: 5,
								  width: deadlineSize,
								  height: contentView.frame.size.height - 10)
		checkedBox.frame = CGRect(x: contentView.frame.size.width - imageSize - 8,
								  y: imageSize/2,
								  width: imageSize,
								  height: imageSize)
	}
	
	private func dateString(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "dd/MM/YY"
		dateFormatter.string(from: date)
		return dateFormatter.string(from: date)
	}
	
	private func isOutOfDadeline(date: Date) -> Bool {
		return Date() > date
	}
	
}
