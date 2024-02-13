//
//  ViewController.swift
//  HWlesson22
//
//  Created by Карина Дьячина on 13.02.24.
//

import UIKit

class ViewController: UIViewController {

    let myButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitle("Показать сообщение", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cityArray = [ "Москва", "Нью-Йорк", "Лондон", "Париж"]
        
    lazy var pickerView: UIPickerView = {
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            return picker
        }()
    
    let  cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.text = ""
        label.font = UIFont(name: "Optima", size: 20)
        label.textColor = .black
        label.alpha = 0.5
        label.frame = CGRect(x: 50, y: 250, width: 100, height: 30)
        return label
    }()
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        view.addSubview(cityLabel)
        setConstraints()
        
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        setupCityLabel()
        
        setupImageButton()
        setupImageView()
    }

    @objc func myButtonTapped() {
        
        let alert = UIAlertController(title: "Важное сообщение", message: "Спасибо, что выбрали наше приложение!", preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
            self.thankyouMessage()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
         
        self.present(alert, animated: true)
    }
    
    func thankyouMessage() {
        let  myLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .systemGray
            label.text = "Спасибо!"
            label.font = UIFont(name: "Optima", size: 30)
            label.textColor = .white
            label.frame = CGRect(x: 130, y: 150, width: 150, height: 40)
            return label
        }()
        
        view.addSubview(myLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: myLabel.removeFromSuperview)
    
    }
    
    func setupCityLabel() {
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        cityLabel.isUserInteractionEnabled = true
        cityLabel.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func labelTapped(_ gesture: UITapGestureRecognizer) {
        print("print")
        view.addSubview(pickerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: pickerView.removeFromSuperview)
    
    }
    
    func setupImageButton() {
        let imageButton: UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 20
            button.backgroundColor = .systemBlue
            button.setTitle("Загрузить изображение", for: .normal)
            button.frame = CGRect(x: 50, y: 500, width: 300, height: 40)
            return button
        }()
        
        view.addSubview(imageButton)
        
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func imageButtonTapped() {
        classicActionSheet()
    }
    
    func classicActionSheet() {
        let alert = UIAlertController(title: "Add Photo from Gallery", message: "Do You want to add photo?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default, handler: { _ in
            self.pickPhotoButtonTapped()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel")
        }))
        self.present(alert, animated: true)
        
    }
    
    func pickPhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setupImageView() {
        imageView.frame = CGRect(x: 50, y: 650, width: 130, height: 130)
        
        imageView.layer.cornerRadius = 65
        
        imageView.image = UIImage(systemName: "camera.on.rectangle")
        
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        
        view.addSubview(imageView)
    }
}

extension ViewController {
    
    func setConstraints() {
        view.addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myButton.heightAnchor.constraint(equalToConstant: 70),
            myButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return cityArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityLabel.text = "\(cityArray[row])"
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


//1. Добавьте на главный экран (UIViewController) кнопку с надписью"Показать сообщение».
//• При нажатии на кнопку, открывайте UIAlertController с заголовком и текстом (например,
//"Важное сообщение" и "Спасибо, что выбрали наше приложение!»).
//• UIAlertController должен содержать две кнопки: "OK" и "Отмена". При нажатии на "OK",
//выведите на экран сообщение"Спасибо!". При нажатии на "Отмена", закройте
//UIAlertController.
//2. Добавьте на главный экран UIPickerView с компонентами для выбора города. Вы можете
//использовать список городов, например: "Москва", "Нью-Йорк", "Лондон", «Париж».
//• Добавьте UILabel для отображения выбранного города.
//• При выборе города в UIPickerView, отобразите выбранный город в UILabel.
//3. Добавьте на главный экран еще одну кнопку с надписью"Загрузить изображение».
//• При нажатии на кнопку, открывайте UIImagePickerController, который позволит
//пользователю выбрать изображение из фотоальбома устройства.
//• После выбора изображения, отображайте его на экране (например, в UIImageView).
