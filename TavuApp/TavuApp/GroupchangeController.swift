import UIKit

class GroupchangeController: UIViewController {
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var groupJoin: UITextField!
    
    @IBAction func joinGroup(_ sender: Any) {
        defaults.set((groupJoin.text == "" ? "638c81b39e2d4600ad8a33c3" : groupJoin.text)!, forKey: "groupId")
        print(groupJoin.text)
        Service().joinGroup(groupId: (groupJoin.text == "" ? "638c81b39e2d4600ad8a33c3" : groupJoin.text)!)
        do {
            sleep(1)
        }
    }
}
