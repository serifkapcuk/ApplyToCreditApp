//
//  LoginViewModel.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 14.07.2025.
//


import UIKit

protocol HomePageViewModelInterface {
    func createSlides()
}

final class HomePageViewModel: HomePageViewModelInterface {
    
    
    var slides: [Slide] = []
    
    func createSlides()  {
        
        guard let slide1 = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)?.first as? Slide else { return }
        slide1.Image1.image = UIImage(named: "page1")
        slide1.labelTitle.text = "Anında Kredi, \n Zahmetsiz Başvuru!"
        slide1.labelBody.text = "İhtiyacın olan krediye saniyeler içinde başvur,\nonayla ve hesabına geçsin. Hepsi VakıfBankMobil’de!"
        
        guard let slide2 = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)?.first as? Slide else { return }
        slide2.Image1.image = UIImage(named: "page2")
        slide2.labelTitle.text = "Harcamanı Ertele,\nRahatça Alışveriş Yap!"
        slide2.labelBody.text =  "VakıfBank erteleme özelliği ile alışverişlerini \nşimdi yap, ödemeni 2 aya kadar ertele.\nÜstelik ek ücret yok!"
        
        guard let slide3 = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)?.first as? Slide else { return }
        slide3.setupUI()
        slide3.Image1.image = UIImage(named: "page3")
        slide3.labelTitle.text = "Sen Harca,\nBiz Takip Edelim!"
        slide3.labelBody.text = "Harcama alışkanlıklarını analiz eden Vakıf \nAsistan ile bütçeni akıllıca yönet \nFinansal rehberin her zaman yanında"
        
        guard let slide4 = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)?.first as? Slide else { return }
        slide4.setupUI()
        slide4.Image1.image = UIImage(named: "page4")
        slide4.labelTitle.text = "Vadeli Hesap İle\nParan Değer Kazansın!"
        slide4.labelBody.text = "TL, döviz ya da altın... Tüm birikimlerini\nVakıfBank Vadeli Hesap ile güvenle \ndeğerlendir, kazancını artır!"
        
        guard let slide5 = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)?.first as? Slide else { return }
        slide5.setupUI()
        slide5.Image1.image = UIImage(named: "page5")
        slide5.labelTitle.text = "Bankacılık Temassız,\nİşlemler Işık Hızında!"
        slide5.labelBody.text = "ATM’ye gitmeden QR ile para çek,\n ödemeni kolayca yap."

        slides = [slide1, slide2,slide3,slide4,slide5]
    }
}



