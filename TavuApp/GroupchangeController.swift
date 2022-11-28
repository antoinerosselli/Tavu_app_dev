import UIKit

class GroupchangeController: UIViewController {
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var groupJoin: UITextField!
    
    @IBAction func joinGroup(_ sender: Any) {
        defaults.set(groupJoin.text, forKey: "group_id")

    }
}
