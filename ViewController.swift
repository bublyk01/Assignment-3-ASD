import UIKit

struct Student: Codable {
    let id: Int
    let name: String
    let age: Int?
    let subjects: [String]?
    let address: Address?
    let scores: [String: Int?]?
    let hasScholarship: Bool?
    let graduationYear: Int?
}

struct Address: Codable {
    let street: String
    let city: String
    let postCode: String?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var students: [Student] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Students"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "students", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([String: [Student]].self, from: data)
            students = jsonData["students"] ?? []
            tableView.reloadData()
        } catch {
            print("Could not read from the .json file: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else {
            return UITableViewCell()
        }

        let student = students[indexPath.row]

        cell.nameLabel.text = student.name
        cell.ageLabel.text = "Age: \(student.age ?? 0)"

        let scores = student.scores?.values.compactMap { $0 } ?? []
        let averageScore = scores.isEmpty ? 0 : scores.reduce(0, +) / scores.count
        cell.scoreLabel.text = "Average Score: \(averageScore)"

        if let hasScholarship = student.hasScholarship {
            cell.scholarshipIndicator.backgroundColor = hasScholarship ? .green : .red
        } else {
            cell.scholarshipIndicator.backgroundColor = .gray
        }

        cell.avatarView.image = UIImage(named: "avatar")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStudent = students[indexPath.row]
        let detailVC = Details()
        detailVC.student = selectedStudent
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//I only made this task up to the point (including it) which
//earns 8 points in total - where a second screen has to be done
//showing details about a particular student
