import UIKit

class ItemTableViewCell: UITableViewCell {
    
    var todoItem: TodoItem? {
        didSet {
            guard let currentItem = todoItem else {return}
            if let title = currentItem.title {
                titleLabel.text = title
                checkMark.image = currentItem.isMarkedDone ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
    
    let checkMark: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        image.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        image.clipsToBounds = true
        return image
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its childrenViews do not go out of the boundary
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = AppColors.itemTitleFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill // content will never be strecthed vertially or horizontally
        button.setImage(UIImage(systemName: "trash"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(checkMark)
        containerView.addSubview(titleLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(deleteButton)
        
        checkMark.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        checkMark.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        checkMark.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkMark.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.checkMark.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.deleteButton.leadingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        deleteButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
