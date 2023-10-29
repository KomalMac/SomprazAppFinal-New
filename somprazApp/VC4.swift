import UIKit

class VC4: UIViewController {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var quesInMinImgView: UIImageView!
    
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var astroBtn: UIButton!
    @IBOutlet weak var entrtnBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    
    
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var scienceBtn: UIButton!
    @IBOutlet weak var literBtn: UIButton!
    @IBOutlet weak var geoBtn: UIButton!
    
    
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var wildBtn: UIButton!
    @IBOutlet weak var techBtn: UIButton!
    @IBOutlet weak var mathsBtn: UIButton!
    
    var selectedDoctorID = ""
    var selectedDoctorName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getPlayedCategory()
        
    }
    
    func getPlayedCategory() {
        
//    https://quizapi-omsn.onrender.com/api/get/user-category/652e6c3ee7ebfa7c955fed2e
      
//        call api
//        after that call setupui and add blur logic to setupui
        
        
        guard let url = URL(string: "https://quizapi-omsn.onrender.com/api/get/user-category/\(selectedDoctorID)") else {
            print("QUIZ ERROR OCCURRED")
            return
        }
        
        URLSession.shared.makeRequest(url: url, expecting: DoctorModel.self) { [weak self] result in
            switch result {
            case .success(let doctors):
                print(result)
                DispatchQueue.main.async {
                    self?.updateBlurbutton(doctorsList: doctors)
                   //Do something here
                print(doctors)
                }
            case .failure(let error):
                print(error)
            }
//             Dismiss the loading indicator when the network request is complete
        }
    }
    
    func updateBlurbutton(doctorsList: DoctorModel) {
        
        for i in 0..<doctorsList.count {
            let doctor = doctorsList[i].isPlayed
            if doctor {
                switch i {
                case 0:
                    entrtnBtn.addBlurEffect(cornerRadius: 20)
                    entrtnBtn.isUserInteractionEnabled = false
                case 1:
                    astroBtn.addBlurEffect(cornerRadius: 20)
                    astroBtn.isUserInteractionEnabled = false
                case 2:
                    historyBtn.addBlurEffect(cornerRadius: 20)
                    historyBtn.isUserInteractionEnabled = false
                case 3:
                    scienceBtn.addBlurEffect(cornerRadius: 20)
                    scienceBtn.isUserInteractionEnabled = false
                case 4:
                    literBtn.addBlurEffect(cornerRadius: 20)
                    literBtn.isUserInteractionEnabled = false
                case 5:
                    geoBtn.addBlurEffect(cornerRadius: 20)
                    geoBtn.isUserInteractionEnabled = false
                case 6:
                    wildBtn.addBlurEffect(cornerRadius: 20)
                    wildBtn.isUserInteractionEnabled = false
                case 7:
                    techBtn.addBlurEffect(cornerRadius: 20)
                    techBtn.isUserInteractionEnabled = false
                case 8:
                    mathsBtn.addBlurEffect(cornerRadius: 20)
                    mathsBtn.isUserInteractionEnabled = false
                default:
                    break
                }
            }
        }
    }
    
    
    func setUpUI() {
        
        entrtnBtn.setBackgroundImage(UIImage(named: "EntertainmentYellow"), for: .selected)
        astroBtn.setBackgroundImage(UIImage(named: "AstronomyYellow"), for: .selected)
        historyBtn.setBackgroundImage(UIImage(named: "HistoryYellow"), for: .selected)
        
        scienceBtn.setBackgroundImage(UIImage(named: "Science Yellow"), for: .selected)
        literBtn.setBackgroundImage(UIImage(named: "Literature Yellow"), for: .selected)
        geoBtn.setBackgroundImage(UIImage(named: "Geography Yellow"), for: .selected)
        
        wildBtn.setBackgroundImage(UIImage(named: "Wildlife Yellow"), for: .selected)
        techBtn.setBackgroundImage(UIImage(named: "Technology Yellow"), for: .selected)
        mathsBtn.setBackgroundImage(UIImage(named: "Mathematics Yellow"), for: .selected)
        
    }
    
    @IBAction func onBtnTapped(_ sender: UIButton) {
        
        var intTag = ""
        //        var selectedImageName: String = ""
        var selectedCategory = ""
        
        entrtnBtn.isSelected = false
        astroBtn.isSelected = false
        historyBtn.isSelected = false
        scienceBtn.isSelected = false
        literBtn.isSelected = false
        geoBtn.isSelected = false
        wildBtn.isSelected = false
        techBtn.isSelected = false
        mathsBtn.isSelected = false
        
        // Determine the selected category based on the button's tag
           switch sender.tag {
           case 1:
               selectedCategory = "Entertainment"
               entrtnBtn.isSelected = true
               intTag = "EntertainmentYellow"
           case 2:
               selectedCategory = "Astronomy"
               astroBtn.isSelected = true
               intTag = "AstronomyYellow"
           case 3:
               selectedCategory = "History"
               historyBtn.isSelected = true
               intTag = "HistoryYellow"
           case 4:
               selectedCategory = "Science"
               scienceBtn.isSelected = true
               intTag = "Science Yellow"
           case 5:
               selectedCategory = "Literature"
               literBtn.isSelected = true
               intTag = "Literature Yellow"
           case 6:
               selectedCategory = "Geography"
               geoBtn.isSelected = true
               intTag = "Geography Yellow"
           case 7:
               selectedCategory = "Wildlife"
               wildBtn.isSelected = true
               intTag = "Wildlife Yellow"
           case 8:
               selectedCategory = "Technology"
               techBtn.isSelected = true
               intTag = "Technology Yellow"
           case 9:
               selectedCategory = "Mathematics"
               mathsBtn.isSelected = true
               intTag = "Mathematics Yellow"
           
           default:
               break
           }
        
        print("Selected image identifier: \(intTag)")
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "VC5") as! VC5
        VC.Id = intTag
        VC.selectedCategory = selectedCategory
        VC.selectedDoctorID = selectedDoctorID
        VC.selectedDoctorName = selectedDoctorName
        self.navigationController?.pushViewController(VC, animated: true)
    }
}


extension UIButton {
    func addBlurEffect(style: UIBlurEffect.Style = .regular, cornerRadius: CGFloat = 0, padding: CGFloat = 0) {
        backgroundColor = .clear
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurView.isUserInteractionEnabled = false
        blurView.backgroundColor = .clear
        if cornerRadius > 0 {
            blurView.layer.cornerRadius = cornerRadius
            blurView.layer.masksToBounds = true
        }
        self.insertSubview(blurView, at: 0)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -padding).isActive = true
        self.topAnchor.constraint(equalTo: blurView.topAnchor, constant: padding).isActive = true
        self.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -padding).isActive = true

        if let imageView = self.imageView {
            imageView.backgroundColor = .clear
            self.bringSubviewToFront(imageView)
        }
    }
}
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
