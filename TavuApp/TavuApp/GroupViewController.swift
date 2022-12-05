import UIKit

class GroupViewController: UIViewController {
    let defaults = UserDefaults.standard

    @IBOutlet weak var n_members: UILabel!
    @IBOutlet weak var idgroup: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let members: [User] = [
            User(googleId: "123", username: "Florian"),
            User(googleId: "1234", username: "Antoine"),
            User(googleId: "1234", username: "Max")
        ];
        let group: Group = Group(id: "1", nbMember: members.count, name: "CSC App Dev", Members: members)
        n_members.text = String(group.nbMember)
        idgroup.text = group.name
        gmCreator(groupmember: group.Members)
    }
    
    func gmCreator(groupmember :[User]) {
        var y = 200
        for member in groupmember {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
            label.center = CGPoint(x: 190, y: y)
            label.textAlignment = .center
            label.font = label.font.withSize(40)
            label.text = member.username
            self.view.addSubview(label)
            y = y + 60
        }
    }

}
