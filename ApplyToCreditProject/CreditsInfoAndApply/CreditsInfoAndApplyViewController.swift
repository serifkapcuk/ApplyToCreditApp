//
//  CreditsInfoAndApplyViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 22.07.2025.
//

import UIKit

final class CreditsInfoAndApplyViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    @IBOutlet weak var creditAmountTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var myImageView:UIImageView!
    
    
    private let viewModel = CreditsInfoAndApplyViewModel()
    var selectedCreditId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
    }

    func setupUI() {
        if selectedCreditId == 3 {
            myImageView.image = UIImage(named:"homeCredit")
            labelTitle.text = "Hayalinizdeki Eve Sahip Olun"
            labelBody.text = " Sabit faiz oranları, esnek ödeme planları ve 120 aya \nkadar vade seçenekleriyle bütçenize uygun \nçözümler sizi bekliyor.Aşağıdaki alanları doldurarak \nbaşvurunuzu hemen başlatın!"
            labelBody.textColor = .black
            labelTitle.textColor = .black
        }
        else if selectedCreditId == 4 {
            myImageView.image = UIImage(named:"carCredit")
            labelTitle.text = "Sadece birkaç adımda hayalindeki arabaya ulaş!"
            labelBody.text = " Uygun faiz oranları,ister sıfır ister ikinci el aracınıza \n48 aya varan vade seçenekleri ve esnek ödeme \nplanlarıyla bütçenizi yormadan araç sahibi \nolabilirsiniz.Aşağıdaki bilgileri girerek başvurunuzu kolayca tamamlayın."
            labelBody.textColor = .black
            labelTitle.textColor = .black
            
        }
        else if selectedCreditId == 6 {
            myImageView.image = UIImage(named:"weddingCredit")
            labelTitle.text = "Hayalinizdeki düğün için tam destek yanınızda!"
            labelBody.text = "Düğün masraflarınızı kolayca karşılayabileceğiniz \nuygun faiz oranları ve 36 aya varan vade \nseçenekleriyle size özel ödeme planları \nsunuyoruz.Aşağıdaki bilgileri doldurarak \nbaşvurunuzu yapın."
            labelBody.textColor = .black
            labelTitle.textColor = .black
            
        }
        else if selectedCreditId == 7 {
            myImageView.image = UIImage(named:"educationCredit")
            labelTitle.text = "Geleceğiniz için eğitiminizi ertelemeyin!"
            labelBody.text = "Eğitim kredisi ile okul, kurs veya yurt dışı eğitim \nmasraflarınızı kolayca karşılayın. Uygun faiz oranları \nve 36 aya varan vade seçenekleriyle eğitiminize \nkesintisiz devam edin.Aşağıdaki alanları doldurarak \nbaşvurunuzu hızlıca gerçekleştirin."
            labelBody.textColor = .black
            labelTitle.textColor = .black
            
        }
        else if selectedCreditId == 8 {
            myImageView.image = UIImage(named:"farmingCredit")
            labelTitle.text = "Üretiminize güç, toprağınıza can katın!"
            labelBody.text = " Ekipman alımı, mazot, gübre ve diğer tarımsal \ngiderleriniz için uygun faiz oranları ve esnek ödeme \nplanlarıyla finansal destek sunuyoruz. Aşağıdaki \nbilgileri girerek başvurunuzu kolayca başlatın."
            labelBody.textColor = .black
            labelTitle.textColor = .black
            
        }
        else if selectedCreditId == 9 {
            myImageView.image = UIImage(named:"needingCredit")
            labelTitle.text = "Acil nakit ihtiyaçlarınızda yanınızdayız!"
            labelBody.text = " Uygun faiz oranları sağlık, seyahat ,alışveriş gibi \ntüm bireysel harcamalarınız, hızlı onay süreci ve 36 \naya varan vade seçenekleriyle dilediğiniz anda \nfinansal rahatlık sağlayın.Aşağıdaki bilgileri \ndoldurarak başvurunuzu hemen başlatın."
            labelBody.textColor = .black
            labelTitle.textColor = .black
            
        }
        
        creditAmountTextField.attributedPlaceholder = NSAttributedString(
            string: "Talep Ettiğiniz Kredi Tutarını Giriniz",
            attributes: [.foregroundColor: UIColor.black]
        )
        salaryTextField.attributedPlaceholder = NSAttributedString(
            string: "Maaşınızı Giriniz",
            attributes: [.foregroundColor: UIColor.black]
        )
        
        creditAmountTextField.textColor = .black
        salaryTextField.textColor = .black
        creditAmountTextField.backgroundColor = .white
        salaryTextField.backgroundColor = .white
        creditAmountTextField.tintColor = .black
        salaryTextField.tintColor = .black
    }
    
    @IBAction func clickedBackButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "dashboardID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        guard let userId = UserManager.shared.userID,
              let loanText = creditAmountTextField.text,
              let loanAmount = Int(loanText),
              let salaryText = salaryTextField.text,
              let salary = Int(salaryText)
        else {
            print("Lütfen geçerli değerler girin.")
            return
        }
        
        viewModel.applyForCredit(
            userId: userId,
            creditId: selectedCreditId,
            loanAmount: loanAmount,
            monthlySalary: salary
        )
    }
    
}

extension CreditsInfoAndApplyViewController: CreditApplicationViewModelDelegate {
    
    func applicationSucceeded() {
        print("Başvuru başarılı!")
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "TEBRİKLER!", message:"Başvurunuz başarı ile alınmıştır.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyboard.instantiateViewController(withIdentifier: "resultID")
                nextVC.modalPresentationStyle = .custom
                self.present(nextVC, animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
  
    }
    
    func applicationFailed(error: Error) {
        print("Başvuru başarısız: \(error.localizedDescription)")
    }
    
}
