# Movile App

This is an app get movies from The movie db [here](https://developers.themoviedb.org/), this app show the **Top rated**, **Upcoming** and **Popular Movies**.

## Application

For this application I'm using MVVM:

**persistence**:

* MoviewDiskService

**Views**:

* HomeViewController
* MovieListViewController
* MovieDetailViewController
* HomeTableViewCell
* MoviewPreviewTableViewCell

**Networking**:

* MovieNetworkingService
* Router

**Business**:

* MovieListViewModel
* MovieDetailViewModel
* HomeViewModel

##Clases
* Router: It's an implementation to keep a clean code of alamofire router, that put together the URLS, headers that you need for a request,
* MovieDiskService: have the database(realm) querys. 
* MovieNetworkingService: have all the network request
* MovieAPI:
* Movie: Definition of the the Object Movie.
* Coordinator: Definition of the coordinators.
* AppCoordinator: will drive the app into HomeViewController when it start/
* HomeCoordinator: will drive the app into  the list of movies and the detail.
* HomeViewController: shows the menu View and it have all the interface.
* HomeViewModel: here you will have all the data that is used in the viewController to show the menu 
* MoviewDetailViewController: It have the interface that will show the Movie Detail 
* MovieViewModel: It have the movie that the movieDetailViewController have to show
* MovieListViewController: have all the funcionality that the tableView need to show the list of movies that the viewModel will give him
* MovieListViewModel: will get all the movies from the networking of realm to give them to the view and tells the view when coordinator when a movie has been selected 


## Solid

Talks about how each class must have responsability for a single part of funcionalito of a software, it must be encapsulated by this class and all of the services must be aling with this.


## Clean code

Doing a code that is abstract, easy to read with is no duplicity and others characteristics that make any project easy to work with. Basically, it's using best practices






