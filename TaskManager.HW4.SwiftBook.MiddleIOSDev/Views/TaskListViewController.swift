//
//  TaskListViewController.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 12.02.2023.
//

import UIKit

class TaskListViewController: UIViewController {
	
	weak var tableView: UITableView!
	private var taskManager: ITaskManager
	
	override func loadView() {
		super.loadView()
		setupTableView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = .white
		
		tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.indetifire)

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
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		taskManager.getNumberOfTasks()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.indetifire, for: indexPath)
		guard let cell = cell as? TaskCell else { return UITableViewCell() }
		cell.taskData = taskManager.getTaskData(at: indexPath)
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let done = UIContextualAction(style: .destructive, title: "Done") { [weak self] _, _, _ in
			self!.taskManager.comleteTask(at: indexPath)
			tableView.reloadData()
		}
		
		let swipe = UISwipeActionsConfiguration(actions: [done])
		swipe.performsFirstActionWithFullSwipe = false
		return swipe
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		70
	}
}
