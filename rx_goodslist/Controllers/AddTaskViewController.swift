import UIKit
import Material

class AddTaskViewController: UIViewController {
    
    lazy var saveButton: UIBarButtonItem = {
        var btn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        return btn
    }()
    
    var taskInputTextField: TextField = {
        let tf = TextField()
        tf.placeholder = "Add task"
        tf.dividerNormalColor = .white
        tf.dividerActiveColor = .white
        tf.textColor = .white
        tf.placeholderNormalColor = .white
        tf.placeholderActiveColor = .white
        return tf
    }()
    
    var prioritySegmentedControl: UISegmentedControl = {
        let items = ["High", "Medium", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = saveButton
        view.backgroundColor = .gray
        configureView()
    }
    
    func configureView() {
        view.addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 90, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(taskInputTextField)
        taskInputTextField.anchor(top: prioritySegmentedControl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 10)
    }
    
    @objc func handleSave(_ sender: UIBarButtonItem) {
        print("SAVE")
    }

}
