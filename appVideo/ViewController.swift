//
//  ViewController.swift
//  appVideo
//
//  Created by Gustavo Rigor on 27/08/20.
//  Copyright © 2020 Gustavo Rigor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

//MARK: Componentes da tela
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var identificacao: UILabel!
    @IBOutlet weak var botao: UIButton!
    
//MARK: Carregamento da tela
    override func viewDidLoad() {
        super.viewDidLoad()
        imagem.image = UIImage(named: "senac-apple-logo")
    }
    
//MARK: Ação do botão selecionar Imagem
    @IBAction func pegarImagem(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated:true)
    }
//MARK: Função para pegar imagem do fotos
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let imagem = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Deu ruim no picker")
        }
        
        self.imagem.image = imagem
        identificacao.text = "Processando informação..."
        
        //guard let ciImage = CIImage(image: imagem) else{
        //    fatalError("AAAAA Não converteu...")
        //}
        //detectandoImagem(ciImage)
    }
    


}

