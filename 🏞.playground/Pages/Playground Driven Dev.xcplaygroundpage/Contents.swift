//: [Previous](@previous)

import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    let rootStackView = UIStackView()
    let titleLabel = UILabel()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let emailStackView = UIStackView()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let nameStackView = UIStackView()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let passwordStackView = UIStackView()
    let submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        self.rootStackView.axis = .vertical
        self.rootStackView.spacing = 16

        self.titleLabel.text = "Sign up"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: self.traitCollection)
        self.titleLabel.textColor = UIColor.init(white: 0.2, alpha: 1)

        self.nameLabel.text = "Name"
        self.nameLabel.font = UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: self.traitCollection)
        self.nameTextField.borderStyle = .roundedRect
        self.nameStackView.axis = .vertical
        self.nameStackView.addArrangedSubview(self.nameLabel)
        self.nameStackView.addArrangedSubview(self.nameTextField)

        self.emailLabel.text = "Email"
        self.emailLabel.font = UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: self.traitCollection)
        self.emailTextField.borderStyle = .roundedRect
        self.emailStackView.axis = .vertical
        self.emailStackView.addArrangedSubview(self.emailLabel)
        self.emailStackView.addArrangedSubview(self.emailTextField)

        self.passwordLabel.text = "Password"
        self.passwordLabel.font = UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: self.traitCollection)
        self.passwordTextField.borderStyle = .roundedRect
        self.passwordStackView.axis = .vertical
        self.passwordStackView.addArrangedSubview(self.passwordLabel)
        self.passwordStackView.addArrangedSubview(self.passwordTextField)

        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.backgroundColor = .blue
        self.submitButton.layer.cornerRadius = 6
        self.submitButton.clipsToBounds = true
        self.submitButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)

        self.view.addSubview(self.rootStackView)
        self.rootStackView.addArrangedSubview(self.titleLabel)
        self.rootStackView.addArrangedSubview(self.nameStackView)
        self.rootStackView.addArrangedSubview(self.emailStackView)
        self.rootStackView.addArrangedSubview(self.passwordStackView)
        self.rootStackView.addArrangedSubview(self.submitButton)

        NSLayoutConstraint.activate([
            self.rootStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.rootStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.rootStackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.rootStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor),
            ])
    }
}

let parent = UIViewController()
let vc = MyViewController()
parent.addChild(vc)

parent.view.translatesAutoresizingMaskIntoConstraints = false
parent.view.addSubview(vc.view)

NSLayoutConstraint.activate([
    vc.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
    vc.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor),
    vc.view.topAnchor.constraint(equalTo: parent.view.topAnchor),
    vc.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor)
    ])

PlaygroundPage.current.liveView = parent

//: [Next](@next)
