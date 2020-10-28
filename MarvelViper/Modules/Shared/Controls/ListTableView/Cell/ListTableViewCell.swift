import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(using comic: ComicSummary?) {
        titleLabel.text = comic?.name
    }
    
}
