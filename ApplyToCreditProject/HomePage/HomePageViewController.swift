
import UIKit


class HomePageViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet var upperSignInButtonLabel: UILabel!
    @IBOutlet var secondUpperSignInButtonLabel: UILabel!
    @IBOutlet weak var scrollViewHomePage: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var loginButton:UIButton!
    @IBOutlet var signInButton: UIButton!
    
    let viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.createSlides()
        setupSlideScrollView()
        scrollViewHomePage.delegate = self
        pageControl.numberOfPages = viewModel.slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
    }
    func updateUI() {
        upperSignInButtonLabel.font = UIFont.TDTitle
        secondUpperSignInButtonLabel.font = UIFont.TDTitle
    }
    func scrollViewConfig(){
        scrollViewHomePage.alwaysBounceVertical = false
        scrollViewHomePage.alwaysBounceHorizontal = true
        scrollViewHomePage.bounces = false
        scrollViewHomePage.showsVerticalScrollIndicator = false
        scrollViewHomePage.isPagingEnabled = true
        
        scrollViewHomePage.contentSize = CGSize(width: scrollViewHomePage.frame.width * CGFloat(viewModel.slides.count), height: scrollViewHomePage.frame.height)
        
        for i in 0..<viewModel.slides.count {
            viewModel.slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollViewHomePage.addSubview(viewModel.slides[i])
        }
        
    }
    
    func setupSlideScrollView() {
        scrollViewConfig()
        
    }
    
    func scrollViewDidScroll(_ scrollViewHomePage:UIScrollView) {
        let pageIndex = round(scrollViewHomePage.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
  
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "loginID")
        self.navigationController?.pushViewController(nextVC, animated: true)
        if let navController = self.navigationController {
            navController.pushViewController(nextVC, animated: true)
        } else {
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}
 
 




