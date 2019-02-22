import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var addIcon: UIButton!
    
    private var snackButtons = [UIButton]()
    var itemsToDisplay = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var snackLabel: UILabel!
    var stacks = [UIImageView]()
    
    var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snackLabel.text = "Snacks"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addIconPressed(_ sender: Any) {
        
        setUpNavBarFrame()
        createStackView()
    }
    
    
    func setUpNavBarFrame() {
        
        if heightConstraint.constant != 150 {
            
            snackLabel.text = "Snacks"
            setUpSpringNavigationEffect()
            addIcon.transform = addIcon.transform.rotated(by: 0.25*CGFloat.pi)
            
        }  else {
            
            heightConstraint.constant = 64
            snackLabel.text = "Add a snack"
            addIcon.transform = addIcon.transform.rotated(by: 0.25*CGFloat.pi)
            stackView.isHidden = true
            
        }
    }
    
    func setUpSpringNavigationEffect() {
        
        stackView.isHidden = false
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
            
            self.topConstraint.isActive = true
            self.heightConstraint.constant = 150
            self.navBarView.layoutIfNeeded()
            
        })
    }
    
    func createStackView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.addSubview(stackView)
        
        
        stackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: navBarView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: navBarView.rightAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.distribution = .fillEqually
        
        
        if stacks.count == 0 {
            for _ in 0..<5 {
                
                let newImage = UIImageView()
                stacks.append(newImage)
                
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false

                snackButtons.append(button)
                newImage.isUserInteractionEnabled = true
                
                stackView.addArrangedSubview(newImage)
                newImage.addSubview(button)
                
                button.addTarget(self, action: #selector(snackTapped(button:)), for: .touchUpInside)
                button.topAnchor.constraint(equalTo: newImage.topAnchor).isActive = true
                button.leadingAnchor.constraint(equalTo: newImage.leadingAnchor).isActive = true
                button.trailingAnchor.constraint(equalTo: newImage.trailingAnchor).isActive = true
                button.bottomAnchor.constraint(equalTo: newImage.bottomAnchor).isActive = true
                
            }
        }
        
        stacks[0].image = UIImage(named: "oreos")
        stacks[1].image = UIImage(named: "pizza_pockets")
        stacks[2].image = UIImage(named: "pop_tarts")
        stacks[3].image = UIImage(named: "popsicle")
        stacks[4].image = UIImage(named: "ramen")
        
    }
    
    @objc func snackTapped(button: UIButton) {
        print("tapped")
        guard let index = snackButtons.index(of: button) else {
            fatalError("the button \(button) is not in the array")
        }
        
        let selectedSnack = index + 1
        
        switch selectedSnack {
        case 1:
            itemsToDisplay.append("Oreos")
        case 2:
            itemsToDisplay.append("Pizza")
        case 3:
            itemsToDisplay.append("Pop tarts")
        case 4:
            itemsToDisplay.append("Popsicle")
        case 5:
            itemsToDisplay.append("Ramen")
        default:
            print("default case")
        }
        
        print("HERE IS MY ARRAY COUNT.. PLEASE BE MORE THAN 0 \(itemsToDisplay.count)")
        tableView.reloadData()
        
    }
    
    // Table view stuff
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else {
            fatalError("could not find cell")
        }
        
        let snack = itemsToDisplay[indexPath.row]
        cell.snackLabel.text = snack
        
        return cell
        
    }
    
}

