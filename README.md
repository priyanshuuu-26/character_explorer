# 🚀 Character Explorer  

A **Flutter application** for exploring characters from the **Rick and Morty universe**.
This project demonstrates **Firebase integration, real-time configuration, and state management** with Riverpod.  

---

## 🌟 Features  

- **Google Authentication:** Secure login using Firebase Authentication.  
- **Infinite Scroll:** Characters load automatically while scrolling.  
- **Character Details:** Tap to view detailed information.  
- **Favorites System:** Save and view favorites powered by Cloud Firestore.  
- **Search & Filter:** Search by name or filter by status (*Alive / Dead / All*).  
- **Dynamic UI:** Firebase Remote Config toggles episode count display on character cards.  
- **Themed UI:** Immersive, consistent design with background theming.  

---

## 💻 Tech Stack & Architecture  

### Frontend (Client)  
- **Flutter:** Cross-platform mobile development.  
- **Riverpod:** Robust state management.  
- **dio:** Networking package for API calls.  
- **cached_network_image:** Efficient image caching.  

### Backend-as-a-Service (Serverless)  
- **Firebase Authentication:** Google Sign-In integration.  
- **Cloud Firestore:** Database for favorites.  
- **Firebase Remote Config:** Remote feature flag for dynamic UI updates.  

### 🔗 Architecture Overview  

The **Flutter app (client)** connects to the **Rick and Morty API** to fetch characters and uses **Firebase** for authentication, favorites, and dynamic configuration.  

1. A user logs in using **Google Sign-In** via Firebase Authentication.  
2. The app fetches characters with **infinite scrolling** from the API.  
3. On character tap → Detailed info is displayed.  
4. Users can save favorites → Stored in **Cloud Firestore**.  
5. **Firebase Remote Config** controls whether the episode count appears on cards.  

---

## 🚀 Getting Started  

Follow these instructions to set up the project on your local machine.  

### ✅ Prerequisites  

Make sure you have installed:  
- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- A [Firebase Project](https://console.firebase.google.com/)  
- Android Emulator or physical device  

---

## ⚙️ Project Setup  

1. **Clone the repository**  
    ```bash
    git clone https://github.com/priyanshuuu-26/character_explorer.git
    cd character_explorer
    ```

2. **Firebase Setup**  
   - Create a new project in the Firebase Console.  
   - Enable **Google Sign-In** under **Authentication**.  
   - Enable **Cloud Firestore**.  
   - Set up **Remote Config** with parameter:  
     ```text
     showEpisodeCount = true
     ```  
   - Run FlutterFire CLI to connect your app:  
     ```bash
     flutterfire configure
     ```
     This generates the `firebase_options.dart` file.  

3. **Install dependencies & run**  
    ```bash
    flutter pub get
    flutter run
    ```

---

## 🧪 How to Use  

1. **Sign In**: Tap *Sign in with Google* to log in.  
2. **Browse Characters**: Scroll to load more automatically.  
3. **Search & Filter**: Search by name or filter by status (*Alive / Dead / All*).  
4. **View Details**: Tap a character card for more info.  
5. **Manage Favorites**: Tap *Add to Favorites* on the details screen. View saved characters via ❤️ icon.  

---

## 📸 Screenshots  

<!-- Replace placeholders with actual screenshots -->
<p align="center">
  <img src="https://via.placeholder.com/250x500?text=Home+Screen" width="30%" />
  <img src="https://via.placeholder.com/250x500?text=Character+Details" width="30%" />
  <img src="https://via.placeholder.com/250x500?text=Favorites" width="30%" />
</p>  

---

## 🌱 Future Improvements  

- [ ] Dark Mode support  
- [ ] Episode browsing for each character  
- [ ] Offline caching for recently viewed characters  
- [ ] Advanced filters (species, gender, origin)  
- [ ] Animations for smoother transitions  

---

## 🙌 Acknowledgements  

- [Rick and Morty API](https://rickandmortyapi.com/)  
- [Firebase](https://firebase.google.com/)  
- [Flutter](https://flutter.dev/)  

---
