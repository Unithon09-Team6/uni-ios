import UIKit
import RxSwift
import RxCocoa
import Moya
import SnapKit
import Then
import Kingfisher

class BaseViewController: UIViewController {
    
    // 자주 사용하는 프로퍼티를 넣어줘도 되요
    // MARK: - Property
    var disposeBag = DisposeBag()
    private(set) var didSetupConstraints = false
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setupConstraints()
        self.initialize()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func initialize() {
        
    }
    
    func configureUI() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setLayout() {
        
    }
    
}
