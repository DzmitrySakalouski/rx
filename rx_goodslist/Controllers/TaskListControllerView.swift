
import UIKit
import Foundation
import RxSwift
import RxCocoa

let reuseIdentifier = "ListId"

class TaskListViewController: UIViewController {
    private let bag = DisposeBag()
    private var filterdTasks = [Task]()
    
    private var tasks = BehaviorRelay<[Task]>(value: [Task]())
        
    private var prioritySegmentedControl: UISegmentedControl = {
        let items = ["All", "High", "Medium", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.addTarget(self, action: #selector(handlePressSegmentedView), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private var tableContainer: UIView = {
        let v = UIView()
        let frameOflView : CGRect = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        v.frame = frameOflView
        return v
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToAddTask))
        barBtn.tintColor = Colors.COLOR_WHITE
        return barBtn
    }()
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        configureHeaderButton()
        view.addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 130, paddingLeft: 10, paddingRight: 10)
        configureTableView()
        tableContainer.anchor(top: prioritySegmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10)
    }
    
    @objc private func handlePressSegmentedView( _ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    @objc func navigateToAddTask() {
        let addTaskVC = AddTaskViewController()
        
        _ = addTaskVC.taskSubjectObservable.subscribe({ [unowned self] task in
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            var existingTasks = self.tasks.value
            guard let task = task.element else { return }
            
            existingTasks.append(task)
            self.tasks.accept(existingTasks)
            
            self.filterTasks(by: priority)
        }).disposed(by: bag)
        
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
    
    private func configureHeaderButton() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureTableView() {
        view.addSubview(tableContainer)
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableContainer.addSubview(tableView)
        tableView.frame = tableContainer.frame
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filterdTasks = self.tasks.value
        } else {
            _ = self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority!}
            }.subscribe(onNext: { [weak self] tasks in
                print(tasks)
                self?.filterdTasks = tasks
            }).disposed(by: self.bag)
        }
        
        self.updateTableView()
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterdTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.filterdTasks[indexPath.row].title
        
        return cell
    }
}
