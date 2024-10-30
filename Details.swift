import UIKit

class Details: UIViewController {
    var student: Student?

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let scholarshipIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoresStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(avatarImageView)
        avatarImageView.addSubview(scholarshipIndicatorView)
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(addressLabel)
        view.addSubview(scoresStackView)
        
        setupConstraints()
        
        configureView()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            scholarshipIndicatorView.widthAnchor.constraint(equalToConstant: 20),
            scholarshipIndicatorView.heightAnchor.constraint(equalTo: scholarshipIndicatorView.widthAnchor),
            scholarshipIndicatorView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -10),
            scholarshipIndicatorView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scoresStackView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            scoresStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoresStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureView() {
        guard let student = student else { return }

        avatarImageView.image = UIImage(named: "avatar")
        
        if let hasScholarship = student.hasScholarship {
            scholarshipIndicatorView.backgroundColor = hasScholarship ? .green : .red
        } else {
            scholarshipIndicatorView.backgroundColor = .gray
        }

        nameLabel.text = student.name
        ageLabel.text = "Age: \(student.age ?? 0)"
        
        if let address = student.address {
            let postalCode = address.postCode ?? "N/A"
            addressLabel.text = "Address: \(address.street), \(address.city), \(postalCode)"
        } else {
            addressLabel.text = "Address: Not found"
        }

        scoresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (subject, score) in student.scores ?? [:] {
            let scoreContainer = UIView()
            scoreContainer.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            scoreContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let scoreLabel = UILabel()
            scoreLabel.font = UIFont.systemFont(ofSize: 18)
            scoreLabel.text = "\(subject): \(score ?? 0)"
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            
            scoreContainer.addSubview(scoreLabel)
            
            NSLayoutConstraint.activate([
                scoreLabel.leadingAnchor.constraint(equalTo: scoreContainer.leadingAnchor, constant: 10),
                scoreLabel.trailingAnchor.constraint(equalTo: scoreContainer.trailingAnchor, constant: -10),
                scoreLabel.topAnchor.constraint(equalTo: scoreContainer.topAnchor, constant: 5),
                scoreLabel.bottomAnchor.constraint(equalTo: scoreContainer.bottomAnchor, constant: -5)
            ])
            
            scoresStackView.addArrangedSubview(scoreContainer)
        }
    }
}
