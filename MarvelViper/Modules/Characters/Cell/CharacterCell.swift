import UIKit
import RxSwift

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    private(set) var reuseBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func configure(using viewModel: CharacterCellViewModel) {
        
        viewModel.titleLabel
            .asDriver()
            .drive(self.title.rx.text)
            .disposed(by: reuseBag)
    }
}
