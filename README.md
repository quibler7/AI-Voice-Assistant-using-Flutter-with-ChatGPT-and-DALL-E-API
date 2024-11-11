# Flutter ChatGPT DALL-E Assistant

Welcome to **Flutter ChatGPT DALL-E Assistant**! This Flutter application integrates OpenAI's ChatGPT for conversational AI and DALL-E for AI-powered image generation. The app allows users to interact with an AI assistant through both text and image creation.

## Table of Contents

- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)

---

## About

The **Flutter ChatGPT DALL-E Assistant** is a mobile application built with **Flutter**, utilizing OpenAI's **ChatGPT** for text-based interactions and **DALL-E** for generating images based on text prompts. This project serves as an AI-powered voice assistant, enabling users to chat with an AI and even generate images in real-time.

Key highlights of the project:
- Voice-based input with AI-powered text responses (ChatGPT).
- Text-based input for image generation (DALL-E).
- Developed with Flutter for cross-platform compatibility (Android and iOS).

## Features

- **Voice Interaction**: Speak to the assistant and get text-based responses from ChatGPT.
- **Text-to-Image Generation**: Enter a prompt, and the app will generate an image using OpenAI's DALL-E API.
- **Cross-Platform Support**: Built using Flutter, ensuring compatibility on both Android and iOS devices.
- **Simple and Intuitive UI**: Clean and easy-to-use interface for smooth interactions.

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- A valid OpenAI API key (for ChatGPT and DALL-E).
- Git for cloning the repository.

### Steps

1. **Clone the Repository**  
   Clone the repository to your local machine.
   
   ```
   git clone https://github.com/quibler7/Flutter-ChatGPT-DALL-E-Assistant.git
   cd Flutter-ChatGPT-DALL-E-Assistant
   ```
   
3. **Install Dependencies**
   Install the Flutter dependencies for the project.
   
   ```
   flutter pub get
   ```
   
5. **Add Your OpenAI API Key**
   - Open the `lib/secrets/secrets.dart` file and add your OpenAI API key:
   ```
   const openAPIKey = 'your_openai_api_key';
   ```
   
   - Make sure to add the `secrets.dart` file to `.gitignore` to keep your key private and avoid accidentally pushing it to GitHub.

     
6. Run the Application
   Run the app on your connected device or emulator.
   
   ```
   flutter run
   ```

## Usage

Start the App: Launch the app on your device (iOS or Android).
Voice Interaction: Tap the microphone button to begin speaking with the assistant. The assistant will transcribe your voice and generate responses.
Image Generation: Type or speak a prompt to generate an image via DALL-E.

## Project Structure

The project is structured as follows:

```
lib
├── main.dart               # Entry point of the application
├── components              # Contains reusable widgets
│   └── feature_box.dart    # Custom widget to display features
├── pages                   # Contains different screens (home, chat, image generation)
│   └── home_page.dart      # Home page UI and logic
├── secrets                 # Contains sensitive information like API keys
│   └── secrets.dart        # Stores the OpenAI API key
├── services                # Manages API requests and business logic
│   └── open_service.dart   # Handles communication with OpenAI APIs (ChatGPT, DALL-E)
└── pubspec.yaml            # Project dependencies and metadata
```

`main.dart`: The entry point of the application.
`components/`: Contains reusable widgets that are used across multiple screens.
`pages/`: Contains different UI pages such as `home_page.dart` for the main interface.
`secrets/`: Stores sensitive API keys such as `secrets.dart` where the OpenAI API key is stored.
`services/`: Contains services like `open_service.dart` that handle API communication.

## Contributing

Contributions are welcome! If you would like to improve the project, please follow these steps:

1. Fork the repository.
2. Create a new branch (feature or bugfix).
3. Implement your changes and thoroughly test them.
4. Open a pull request with a description of your changes.

