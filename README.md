## Double Up

![alt text](https://doubleup.s3.amazonaws.com/res/promo.gif)


## Links to Demo

Apple Devices (TestFlight): https://testflight.apple.com/join/eziBERo9

_How to Install on an Apple Device_
1. Install TestFlight from the App Store.
2. Open the link on your iPhone.
3. Click accept and then install.

Android Devices (APK) : https://doubleup.s3.amazonaws.com/res/app-debug.apk

_How to install on an Android Device_
1. Download the APK on your device.
2. Open the APK from the File Manager
3. Click to allow installs from this source

Receipt Generator : https://doubleup-be445.web.app

Go here to generate the receipts to use with the Double Up app.

## Theme

Industrial and Commercial

## Inspiration

![alt text](https://blog.smartsense.co/hs-fs/hubfs/2020/Blog%20Images/ReFED%20food%20waste.png?width=1920&name=ReFED%20food%20waste.png)

Did you know that supermarkets are responsible for 10% of all U.S. food waste i.e 41 billion pounds annually? All of that food waste makes up 23% of the landfill waste while accounting for $18.2 billion dollars of annual loss.

_Source: https://blog.smartsense.co/supermarkets-zero-food-waste_

Double Up is a rewards app with a purpose. Double Up reduces food waste and improves the profitability of your business, All while rewarding the users for shopping at participating supermarkets.

The name “Double Up” derives from the idea that we give both consumers and businesses benefits; Rewarding customers with gift cards they can use and reducing food waste.

## What it does

- For a customer Double Up is a rewards program which gives you discounts on specific items as well as points which can be used to buy gift cards offer by the BlinkSky API.

- For a business Double Up automatically calculates a discount amount based on the sales and losses which in turn is used to move slower items in the supermarket.

_Features_
- Discount products based on how well it is selling, This algorithm uses the sales history and the turnover for the month to calculate the discount amount and the points awarded for purchasing the product.
- Recommends products based on the discount amount so the slower moving products can get love.
- Recommends Supermarkets based on your area
- Search for Products , Supermarkets
- Send gift cards by Email , Phone Number
- Creating accounts with email verification.
- Save your favourite products, gift cards, supermarkets.
- Scan QR codes from receipts to redeem points given from shopping at participating supermarkets.
- Dark Mode.


## How I built it


![alt text](https://doubleup.s3.amazonaws.com/diagram.png)

We decided to leverage the Amazon Web Services (AWS) platform to create the backend for the
application.

_Tools_
- Android Studio
- Amazon Web Services

_SDK_
- Flutter

_APIs_
- Blinksky API

_Utilization_

- Server-less architecture using AWS AppSync GraphQL using DynamoDB.
- Event scheduling using AWS Event Bridge to update the points/discount distribution of each product - monthly feeding the model.
- Flutter was used to develop a cross platform application (Android/IOS)
- Sending Gift cards using the Blinsky API.
- AWS Lambda for serverless functions.
- AWS Cognito with Amplify for the profiles.
- Image storage using Amazon S3.
- AWS API Gateway with AWS Lambda


## Challenges we ran into

- It was challenging to come up with a solution that was feasible, providing a business value while being sustainable for the environment.
- Coming up with an idea that would have a high retention while providing a genuine value to them.
- Determining the data needed to come up with the algorithm to calculate the discounts.


## Accomplishments that we are proud of

- Creating a solution that is feasible and provides business value while being sustainable to the environment.
- Creating a complete and working solution that can be scaled to fit any user size due to the utilization of Amazon Web Services.
- A solution that can be integrated into any market for both the business and consumer standpoint.

## What we learned

The most important information I learned was about the BlinkSky API and the value it can provide to an application with the gift cards being available on demand and can be instantly sent to users.

## What's next for Double Up

- Adding a business dashboard for each supermarket where they can modify the parameters for generating the discounts for their products.
- Implement a feature called “Double Up Exclusives” where the lowest selling items are featured in the application and shelf edges are provided for them.
- Improve our algorithm for our points system using the AI Algorithm LSTM (Long Term Short Term Memory).
- Adding a recommendation system for BlinkSky gift cards based on the shopping history of the user. I believe that the best data set for recommending gift cards would be a person’s shopping history.


## Team

Carl Duncan (876)-831-1162

Email : cdsoftwaresja@gmail.com

Carl Duncan attended the University of the West Indies  (2018-2021) and has been programming for 6 years. He has created apps that have been featured all over the internet such as FacePause (100,000) Downloads. He has also worked with companies to develop apps.


Juliet Duncan

Email: jumelisa@yahoo.com

Juliet Duncan attended the University of Technology where she studied Pharmacy. She has worked with the University Health Center and as a Freelance Pharmacist for 0 years and is also running a business called JC Epiphany which also has an online customer base.


## Assets

- https://doubleup.s3.amazonaws.com/res/2-01.jpg
- https://doubleup.s3.amazonaws.com/res/3-01.jpg
- https://doubleup.s3.amazonaws.com/res/icon-01.jpg
- https://doubleup.s3.amazonaws.com/res/icon-03.jpg
- https://doubleup.s3.amazonaws.com/res/icon-04.jpg

