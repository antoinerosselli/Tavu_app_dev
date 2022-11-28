import UIKit

class GroupViewController: UIViewController {
    let defaults = UserDefaults.standard

    @IBOutlet weak var n_members: UILabel!
    @IBOutlet weak var idgroup: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idgroup.text = defaults.string(forKey: "group_id")
        let groupmember = ["antoine","florian"]
        n_members.text = String(groupmember.count)
        gmCreator(groupmember: groupmember)
    }
    
    func gmCreator(groupmember :[String]) {
        var y = 200
        for member in groupmember {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
            label.center = CGPoint(x: 190, y: y)
            label.textAlignment = .center
            label.font = label.font.withSize(40)
            label.text = member
            self.view.addSubview(label)
            y = y + 60
        }
    }

}
