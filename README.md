<a name="top"></a>

<h1 align="center">
  <strong><span>Marvel App - UIKit + Combine</span></strong>
</h1>

---

<p align="center">
  <strong><span style="font-size:20px;">Proyecto personal</span></strong>
</p>

---

<p align="center">
  <strong>Autor:</strong> Salva Moreno Sánchez
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/salvador-moreno-sanchez/">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
  </a>
</p>

## Índice
 
* [Herramientas](#herramientas)
* [Proyecto: Marvel App - UIKit + Combine](#proyecto)
	* [Descripción](#descripcion)
	* [Arquitectura](#arquitectura)
	* [Diseño](#diseno) 
	* [Problemas, decisiones y resolución](#problemas)
	* [Algunos aspectos en los que seguir mejorando la aplicación](#mejoras)

<a name="herramientas"></a>
## Herramientas

<p align="center">

<a href="https://www.apple.com/es/ios/ios-17/">
   <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS">
 </a>
  
 <a href="https://www.swift.org/documentation/">
   <img src="https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
 </a>
  
 <a href="https://developer.apple.com/xcode/">
   <img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" alt="XCode">
 </a>
  
</p>

<a name="proyecto"></a>
## Proyecto: Marvel App - UIKit + Combine

![Demo app gif](images/demoApp.gif)

<a name="descripcion"></a>
### Descripción

<a name="arquitectura"></a>
### Arquitectura

Según [uncle Bob's Clean Architecture pattern](https://blog.cleancoder.com/uncle-bob/2011/11/22/Clean-Architecture.html), se puede dividir el código en 3 capas:

* *Presentation*: todo el código que depende del *framework*. *Views, ViewModels, ViewControllers*, etc.
* *Data*: todo el código que interactúa con los repositorios (como llamadas a red, llamadas a la base de datos, valores predeterminados de usuario, etc.).
* *Domain*: todos los modelos de datos.

Siguiendo las indicaciones del citado Robert Cecil Martin, experto ingeniero de *software*, y guiado por MVVM, he construido mi código.

<a name="diseno"></a>
### Diseño

<a name="problemas"></a>
### Problemas, decisiones y resolución

<a name="mejoras"></a>
# Algunos aspectos en los que seguir mejorando la aplicación


* Hablar sobre las nestedContainer en el modelo
* Hbalar sobre combine en UIkit y escucha de estados
* Hbalar sobre la aplicación del repositorio y el caso de uso para la llamada a la API


# Inspiración

* [MARVEL APP PROTOTYPE](https://dribbble.com/shots/2671572-Marvel-App/attachments/537660?mode=media)

# Tdo

* Mejorar Modelo Character
* Agregar MARK
* Hacer README

---

[Subir ⬆️](#top)

---
