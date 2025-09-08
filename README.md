# 🚀 Character Explorer

A **Flutter application** for exploring characters from the **Rick and Morty universe**, built as a submission for an internship task.  

This app lets users:
- Sign in with Google
- Browse characters with infinite scrolling
- View detailed information
- Save favorites
- Filter results dynamically  
All fully integrated with **Firebase** (Authentication, Firestore, and Remote Config).  

---

## 🎥 Demo
<!-- Replace the link below with a GIF or screenshot of your app -->
![App Demo](https://via.placeholder.com/800x400?text=App+Demo+GIF+Here)

---

## ✨ Features

- 🔑 **Google Authentication** — Secure login via Firebase Auth.  
- 🔄 **Infinite Scroll** — Characters load automatically while scrolling.  
- 📄 **Character Details** — Tap to view more information.  
- ❤️ **Favorites System** — Save/view favorites with Cloud Firestore.  
- 🔍 **Search & Filter** — Filter characters by name and status (*Alive / Dead*).  
- ⚡ **Dynamic UI** — Firebase Remote Config controls episode count display.  
- 🎨 **Themed UI** — Immersive full-screen background with consistent styling.  

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: Flutter  
- **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)  
- **BaaS**: Firebase  
- **Authentication**: [firebase_auth](https://pub.dev/packages/firebase_auth), [google_sign_in](https://pub.dev/packages/google_sign_in)  
- **Database**: [cloud_firestore](https://pub.dev/packages/cloud_firestore)  
- **Remote Config**: [firebase_remote_config](https://pub.dev/packages/firebase_remote_config)  
- **Networking**: [dio](https://pub.dev/packages/dio)  
- **Image Caching**: [cached_network_image](https://pub.dev/packages/cached_network_image)  

---

## ⚙️ Setup & Installation

### 1. Prerequisites  
- Install the **[Flutter SDK](https://docs.flutter.dev/get-started/install)**  
- Set up a **Firebase Project**  

### 2. Clone the Repository  
```bash
git clone https://github.com/your-username/character_explorer.git
cd character_explorer
