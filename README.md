# Click To Shop  

## Set up  

Make sure you have Flutter and Dart installed and the instructions can be found at https://www.flutter.dev.  
Ensure your computer meets the following minimum requirements.  
-  At least Windows 10, Mac OS(10.15), Catalina, Debian Linux 11 and Ubuntu 20.04 LTS  
- At least 4 CPU cores (basically core i5)  
- Hard disk space may vary from Os to Os but anything bigger than 20GB free disk space should be sufficient.  
- RAM, at least 8GB.  

## Running the Application  

You can clone the repository to the application from it's GitHub account and on to your computer and from the cloned repo's home directory, assuming all the above requirements are met, from a command line window inside the root of the cloned repo, type flutter run, to run the app.  
You can also open the cloned repo from a code editor like Visual Studio Code and then from the menu bar, run the app.

## Introduction

This web application is build using Dart and Flutter and utilizes Google's Firebase cloud platform for authenticating users and the firestore database to store the products

The web application allows registered users to view, add onto a shopping cart or remove items.

## General flow

On startup users are presented with a screen from where registered users can sign in as new users register.  
Upon successful log in where the application accepts Firebase email and password log in credentials when the option is configured, the user is redirected to a products page.  

### The Home Screen

This screen is only visible after sucessful log in or registration and from the screen, users can add to or delete products from the shopping cart.  

#### The Shopping cart

This screen displays the items currently added to the cart and the total amount due.  
It also displays an icon from where you can remove an item from the cart.  
It also displays a **Proceed To Payment** button which when clicked, takes you to a **Payment Screen**.  

#### The Proceed To Payment Screen  

This screen appears after the user has made a decision to **proceed with payment**  
It displays two **dummy** payment options which will be implemented in Click To Shop version 2.0.0.  
Both payment options when clicked will show a **successfully completed transaction** and will navigate to a **dummy receipt** confirming the same.  
Clicking ok on the message takes the user to the products screen.  

#### The Details Screen

This screen is navigated to when the user clicks on details and it is from here where they get to view the details about a particular product.  

#### The Product Search Screen  

As the name implies, users, after a successful log in can search for a product by it's name.  

#### The Register/Login/Logout Screens  

From the products screen, a user can logout of the online shop and the application will then display the initial Registration/Log in screen.  

### Future Development  

Click To Shop version 2.0.0 will see a completely implemented payment gateways handling in real time and to that end i will leverage Safaricom's **Daraja API** and indeed APIs from all other telcos.  
I will also follow these steps to include credit card payments in my application  
- Choose a payment gateway  
- Apply for a merchant account  
- Choose which cards to accept  
- Set up payment processing  
- Ensure compliance with payment card industry (PCI) standards  

Implementing payment options will involve consuming APIs from applications not necessarily written in Dart/Flutter.  

I will also in the meantime get to work on fine tuning the UX and UI aspects of the app.  

## Click To Shop ** Pitch Deck**  

Also included in the project is a **pitch deck** for Click To Shop showcasing what, why and how.  
Check out the projected market growth and trends in online shopping and the huge gap between online shopping and the archaic physical contact based shopping.  
