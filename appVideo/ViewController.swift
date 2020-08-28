//
//  ViewController.swift
//  appVideo
//
//  Created by Gustavo Rigor on 27/08/20.
//  Copyright © 2020 Gustavo Rigor. All rights reserved.
//

import UIKit
import CoreML
import Vision

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
    
//MARK: Utilizar o modelo de Machine Learning
    func detectandoImagem(_ imagem: CIImage){
    //carregar o modelo
    guard let modelo = try? VNCoreMLModel.init(for: Resnet50().model)else{
        fatalError("Deu ruim no modelo")
    }
    let request = VNCoreMLRequest(model: modelo){ request, error in
        
        guard let resultado = request.results as? [VNClassificationObservation], let primeiroResultado = resultado.first else{
            fatalError("Deu ruim no request")
            }
        DispatchQueue.main.async{
            self.identificacao.text = "Confiança é de \(Int(primeiroResultado.confidence*100))% que isso pode ser \(primeiroResultado.identifier)"
        }
    }
    
    //rodar o CoreML no global dispatch para classificação
    let handler = VNImageRequestHandler.init(ciImage: imagem)
    
    do {
        try  handler.perform([request])
    } catch{
        print("F por \(error)")
    }
    }


}

