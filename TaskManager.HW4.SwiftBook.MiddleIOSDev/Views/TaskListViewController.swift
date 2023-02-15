//
//  TaskListViewController.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 12.02.2023.
//

import UIKit

class TaskListViewController: UIViewController {
	weak var tableView: UITableView!
	private let heightForRow: CGFloat = 70
	private var taskManager: ITaskManager
	private var presenter: IPresenter
	
	override func loadView() {
		super.loadView()
		setupTableView()
		setupTableViewCell()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = .white
	}
	
	func setupTableView() {
		let tv = UITableView(frame: .zero, style: .plain)
		tv.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tv)
		NSLayoutConstraint.activate([
			tv.topAnchor.constraint(equalTo: view.topAnchor),
			tv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tv.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		self.tableView = tv
	}
	
	private func setupTableViewCell() {
		let nib = UINib(nibName: "TaskCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: TaskCell.indetifire)
	}
	
	init(taskManager: ITaskManager, presenter: IPresenter) {
		self.taskManager = taskManager
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		section == 0 ? taskManager.getUnDoneTasks().count : taskManager.getCompletedTasks().count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		2
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		section == 0 ? "CURRENT TASKS" : "COMPLETED TASKS"
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.indetifire, for: indexPath)
		guard let cell = cell as? TaskCell else { return UITableViewCell() }
		let undoneTasks = presenter.sortTasks(tasks: taskManager.getUnDoneTasks())
		let comletedTask = presenter.sortTasks(tasks: taskManager.getCompletedTasks())
		
		let task = indexPath.section == 0 ? undoneTasks[indexPath.row] : comletedTask[indexPath.row]
		let taskData = presenter.matTaskToTaskCellData(task: task)
		cell.taskData = taskData
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let title = indexPath.section == 0 ? "Done" : "Undone"
		let done = UIContextualAction(style: .normal, title: title) { [unowned self] _, _, _ in
			let undoneTasks = presenter.sortTasks(tasks: taskManager.getUnDoneTasks())
			let comletedTask = presenter.sortTasks(tasks: taskManager.getCompletedTasks())
			let task = indexPath.section == 0 ? undoneTasks[indexPath.row] : comletedTask[indexPath.row]
			
			self.taskManager.completeTask(task: task)
			print(undoneTasks)
			tableView.reloadData()
		}
		
		let swipe = UISwipeActionsConfiguration(actions: [done])
		swipe.performsFirstActionWithFullSwipe = false
		return swipe
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		self.heightForRow
	}
}
