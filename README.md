## This project consists of 3 parts i.e. 

* For API: Node.js Express.js and MongoDB
* For APP: 3 Mobile Apps i.e Customer, Driver and Parents using Flutter
* For WEB: AdminPortal using Angular 17

Some UI may still not work correctly in IOS. Clone the appropriate branch below:

* For App: muluken
* For Web: dawit
* For Api: usman

## How to Use 
**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/emmonmoses/ibus.git
```

**Step 2: APPS**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3: APP**

This project uses `build_runner` package that works with code generation, execute the following command to generate files:

```
flutter pub run build_runner watch --delete-conflicting-outputs
```

**Step 4: APP**

This project supports web. Execute the following command to run the project in the web:

```
flutter run -d chrome
```

But it is optimized for mobile apps. Execute the following command to run the project in the device or simulator:

```
flutter run
```

**Step 5: WEB**

Go to project root and execute the following command in console to get the required dependencies: 

```
npm install 
```

**Step 6: WEB**

This project uses `angular-material` package. Execute the following command to run the project:

```
ng serve --open --browser chrome --port 4300
```

**Step 7: API**

Go to project root and execute the following command in console to get the required dependencies: 

```
npm install 
```

**Step 8: API**

This project uses `nodemon` package, execute the following command to run the project:

```
npm start -- run in production mode
```

```
npm run dev -- run in development mode
```