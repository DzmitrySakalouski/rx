import UIKit
import Material
import RxSwift

class AddTaskViewController: UIViewController {
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    lazy var saveButton: UIBarButtonItem = {
        var btn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        btn.tintColor = .white
        return btn
    }()
    
    lazy var taskInputTextField: TextInput = {
        let tf = TextInput()
        tf.placeholder = "Add task"
        
        return tf
    }()
    
    private lazy var priorityControl: UISegmentedControl = {
        let items = ["High", "Medium", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.superview?.layer.borderWidth = 1
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskInputTextField.delegate = self
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.navigationBar.tintColor = UIColor.white
        configureView()
        
        self.navigationController!.navigationBar.topItem!.title = ""
    }
    
    func configureView() {
        view.addSubview(priorityControl)
        priorityControl.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 110, paddingLeft: 10, paddingRight: 10, height: 40)
        priorityControl.selectedSegmentIndex = 1
        view.addSubview(taskInputTextField)
        taskInputTextField.anchor(top: priorityControl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 10)
        
    }
    
    @objc func handleSave(_ sender: UIBarButtonItem) {
        guard let priority = Priority(rawValue: self.priorityControl.selectedSegmentIndex) else { return }
        let title = taskInputTextField.text!

        let task = Task(title: title, priority: priority)

        taskSubject.onNext(task)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handlePressSegmentedView( _ sender: UISegmentedControl) {
        print("Press")
    }
    
    @objc func navigateBack() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

extension AddTaskViewController: UITextFieldDelegate, UINavigationControllerDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
