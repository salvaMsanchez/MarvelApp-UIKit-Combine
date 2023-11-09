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

Además de seguir las indicaciones del citado Robert Cecil Martin, experto ingeniero de *software*, he concretdo la organización de mi código como se observa en la siguiente imagen:

![Demo app gif](images/diagramaMVVM.png)

De esta forma, conseguimos:

* **Separación de responsabilidades:** esto facilita la resolución de numerosos problemas de desarrollo y hace que una aplicación sea más fácil de probar, mantener y evolucionar.
* **Reducción de la lógica de negocio:** se reduce la cantidad de lógica de negocio requerida en el código detrás de ella.
* **Facilita las pruebas unitarias:** aunque en este caso no se han añadido *tests*, realizar la arquitectura como se indica facilita la inyección de dependencias con casos *fake*, por ejemplo. Incluso nos podría servir para diseñar nuestras pantallas sin realizar llamadas a la API.
* **Independencia de componentes:** se trabajar de forma independiente y simultánea en los componentes durante el desarrollo.
* **Reutilización de código:** mantiene una separación limpia entre la lógica de la aplicación y la UI, lo que puede mejorar significativamente las oportunidades de reutilización de código.

Debemos destacar el rol del *respository*, el cual es el responsable de manejar las operaciones de datos. Puede interactuar con diferentes fuentes de datos como “Local” (CoreData, por ejemplo) o “Network” (API, por ejemplo).

<a name="diseno"></a>
### Diseño

Como inspiración, he partido del **[concepto creativo y prototipo](https://dribbble.com/shots/2671572-Marvel-App/attachments/537660?mode=media)** del usuario llamado [Luis Herrero](https://dribbble.com/luisherrero) encontrado en la web [Dribbble](https://dribbble.com/shots/22234085-Dragon-Ball-Z-Character-Info), punto de partida que me ha ayudado para comenzar este proyecto.

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

* Hacer README

---

[Subir ⬆️](#top)

---
