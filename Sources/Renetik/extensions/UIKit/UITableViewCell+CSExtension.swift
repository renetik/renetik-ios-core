extension UITableViewCell: CSHasTextProtocol {
    public func text() -> String? { textLabel?.text }

    public func text(_ text: String?) { textLabel?.text = text }
}
