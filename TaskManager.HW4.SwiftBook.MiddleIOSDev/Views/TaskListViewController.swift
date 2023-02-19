//
//  TaskListViewController.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 12.02.2023.
//

import UIKit

protocol TaskListViewProtocol: AnyObject {
	func render(viewData: ViewData)
}

class TaskListViewController: UIViewController {
	weak var tableView: UITableView!
	private var presenter: TaskListPresenterProtocol!
	private let heightForRow: CGFloat = 70
	private var comletedTaskData = [TaskCellData]()
	private var unDoneTaskData = [TaskCellData]()
	
	override func loadView() {
		super.loadView()
		setupTableView()
		setupTableViewCell()
		assemblingPresenter()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = .white
		presenter.getTaskData()
	}
	
	private func assemblingPresenter() {
		let repository: ITaskRepository = TaskRepositoryStub()
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		taskManager.addTasks(tasks: repository.getTasks())
		presenter = TaskListPresenter(view: self, taskManager: taskManager)
	}
	
	private func setupTableView() {
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
	/// return Task from indexPath
	private func getTaskDataForIndex(_ indexPath: IndexPath) -> TaskCellData {
		presenter.getTasksForSection(
			completed: comletedTaskData,
			unDone: unDoneTaskData,
			section: indexPath.section
		)[indexPath.row]
	}
}

extension TaskListViewController: TaskListViewProtocol {
	func render(viewData: ViewData) {
		self.comletedTaskData = viewData.comletedTaskData
		self.unDoneTaskData = viewData.unDoneTaskData
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.getTasksForSection(
			completed: comletedTaskData,
			unDone: unDoneTaskData,
			section: section
		).count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		presenter.getSectionsTitles().count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		presenter.getSectionsTitles()[section]
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.indetifire, for: indexPath)
		guard let cell = cell as? TaskCell else { return UITableViewCell() }
		let taskData = getTaskDataForIndex(indexPath)
		cell.taskData = taskData
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let title = indexPath.section == 0 ? "Done" : "Undone"
		let done = UIContextualAction(style: .normal, title: title) { [unowned self] _, _, _ in
			self.presenter.doneTask(indexPath: indexPath)
			self.presenter.getTaskData()
			DispatchQueue.main.async {
				tableView.reloadData()
			}
		}
		
		let swipe = UISwipeActionsConfiguration(actions: [done])
		swipe.performsFirstActionWithFullSwipe = false
		return swipe
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		self.heightForRow
	}
}
