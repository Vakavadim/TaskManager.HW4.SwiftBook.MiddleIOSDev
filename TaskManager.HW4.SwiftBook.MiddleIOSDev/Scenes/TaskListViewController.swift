//
//  TaskListViewController.swift
//  TaskManager.HW4.SwiftBook.MiddleIOSDev
//
//  Created by Вадим Гамзаев on 12.02.2023.
//

import UIKit

protocol ITaskListView: AnyObject {
	func render(viewData: MainModel.ViewData)
}

class TaskListViewController: UIViewController {
	weak var tableView: UITableView!
	var viewData: MainModel.ViewData = MainModel.ViewData(tasksBySections: [])
	var presenter: ITaskListPresenter!
	
	private let heightForRow: CGFloat = 70

	
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
		
		presenter.viewIsReady()
	}
	
	private func setupTableView() {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		self.tableView = tableView
	}
	
	private func setupTableViewCell() {
		let nib = UINib(nibName: "TaskCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: TaskCell.indetifire)
	}
}

extension TaskListViewController: ITaskListView {
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.indetifire, for: indexPath)
		guard let cell = cell as? TaskCell else { return UITableViewCell() }
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		cell.taskData = taskData
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let title = indexPath.section == 0 ? "Done" : "Undone"
		let done = UIContextualAction(style: .normal, title: title) { [unowned self] _, _, _ in
			self.presenter.didDoneButtonPressed(indexPath: indexPath)

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
