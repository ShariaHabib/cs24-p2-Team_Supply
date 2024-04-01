# cs24-p2-Team_Supply

**Run using docker compose**
* Clone the repository
* Run the command ```docker compose up --build```
* Go to the link ```http://127.0.0.1:8200/```
* <span style="color:red">**To see the maps please disable the CORS of your browser.**</span>




**To run this application in your local machine please follow the instructions:**

* Clone the directory on you local machine
* Please follow the instructions to run flutter application https://docs.flutter.dev/get-started/install
* Run ```flutter pub get``` to install the dependancies.
* Run ```flutter run -d chrome --web-hostname=127.0.0.1 --web-port=8200 --web-browser-flag "--disable-web-security"``` [As we are using map that need to disable CORS]
