
import UIKit
import Foundation
import RxSwift

let reuseIdentifier = "ListId"

class TaskListViewController: UIViewController {
    let bag = DisposeBag()
    var prioritySegmentedControl: UISegmentedControl = {
        let items = ["All", "High", "Medium", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    var tableContainer: UIView = {
        let v = UIView()
        let frameOflView : CGRect = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        v.frame = frameOflView
        return v
    }()
    
    lazy var addButton: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToAddTask))
        return barBtn
    }()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        configureHeaderButton()
        view.addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 120, paddingLeft: 10, paddingRight: 10)
        configureTableView()
        tableContainer.anchor(top: prioritySegmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    @objc func navigateToAddTask() {
        let addTaskVC = AddTaskViewController()
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureHeaderButton() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureTableView() {
        view.addSubview(tableContainer)
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableContainer.addSubview(tableView)
        tableView.frame = tableContainer.frame
    }
    
    func test() {
        
        
        let subject = PublishSubject<String>()
        
        subject.subscribe(onNext: { event in
            print(event)
        }).disposed(by: self.bag)
        
        subject.onNext("!!!")
        subject.onNext("!WORKS!")
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
