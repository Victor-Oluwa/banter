# banter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Here's a polished and impressive README for your Flutter app **Banter**, highlighting its features, technical stack, and design principles. This will help showcase your skills to potential employers, while also being informative for users who want to understand what your app is capable of.

---

# Banter - Your Next-Generation Note-Taking App 📝

Welcome to **Banter**—a powerful, feature-rich note-taking app built with Flutter that allows you to stay organized, sync across devices, and enjoy an effortless note management experience. Whether you’re jotting down a quick idea or organizing your projects, **Banter** brings simplicity and productivity together with a delightful interface.

## 🚀 Key Features

### 📄 Rich Text Editor
**Banter** includes an easy-to-use and intuitive rich text editor powered by the **Flutter Quill** package. You can:
- **Bold**, *italicize*, or **_combine both_** for emphasis.
- Organize content with headings, bullet points, numbered lists, and quotes.
- Create checklists to track to-dos or ideas.
- Underline or strikethrough text for more customization.

![Home Screen showing all notes](screenshot_home_screen.png)

### 📁 Organize Notes into Folders (Boxes)
Stay organized by categorizing your notes into **folders** (referred to as "Boxes" within the app). Simply create a folder and drag-and-drop notes for seamless organization.

- Quickly move notes between folders.
- See all notes in a folder at a glance.

![Add to Folder Pop-up](screenshot_add_to_folder_popup.png)

### 🔄 Sync Across Devices
Never lose your notes! **Banter** includes a built-in **syncing feature** powered by a **Node.js backend** to ensure all your notes are saved securely in the cloud and can be accessed across your devices.

- Secure note sync with cloud storage.
- Seamlessly access notes from any device.

![Sync Note Pop-up](screenshot_sync_popup.png)

### 💾 Local Storage with Hive
Even when offline, you can continue working with your notes. **Banter** stores all notes locally using **Hive**, a fast and lightweight NoSQL database for Flutter.

- Fast and reliable local storage.
- Offline access to all notes.

### 🏗️ Built with Clean Architecture
Banter is architected with **Clean Architecture** principles, ensuring separation of concerns and maintainability. This provides a strong foundation for future features and updates, and ensures that the codebase is scalable and easy to maintain.

### 📱 State Management with Bloc and Riverpod
For state management, **Banter** utilizes:
- **Bloc** to handle the complex business logic and state transitions.
- **Riverpod** for dependency injection, making the app modular and testable.

### 🌐 GetX for Navigation
**GetX** is used for navigation to ensure smooth and reactive routing between pages and popups. With **GetX**, the navigation stack is handled efficiently, creating a seamless user experience as you move through the app.

### 🛠️ Customizable Notes with a Rich Toolbar
Access a robust toolbar with customizable options like text formatting, adding checklists, and changing headings directly from the editor.

![Editor Screen with Toolbar Expanded](screenshot_editor_tool_panel.png)

### 📝 Sample Note for Easy Onboarding
When new users download the app, they are greeted with a default **Welcome Note** that highlights Banter's rich text formatting capabilities and demonstrates how notes can be styled. This note serves as an excellent introduction to the app's potential.

![Default Welcome Note](screenshot_welcome_note_1.png)
![Default Welcome Note (Scrolled)](screenshot_welcome_note_2.png)

---

## 🔧 Tech Stack

**Banter** was built with a variety of cutting-edge technologies to ensure optimal performance, maintainability, and scalability:

- **Flutter & Dart**: The core technologies behind Banter, providing a smooth, cross-platform experience.
- **Flutter Quill**: A rich text editor package used for creating and editing notes.
- **Hive**: A lightweight, fast NoSQL database for local storage.
- **Node.js**: Backend for syncing notes across devices using cloud services.
- **Bloc**: For managing business logic and state in the app.
- **Riverpod**: A state management solution for dependency injection and making the app more modular.
- **GetX**: Used for navigation and routing within the app.
- **Clean Architecture**: Ensuring a clean, maintainable, and scalable codebase.

---

## 📷 Screenshots

Here are a few screenshots to give you a glimpse of what **Banter** can do:

1. **Home Screen**: See all your notes at a glance.  
   ![Home Screen](screenshot_home_screen.png)

2. **Welcome Note**: An example of a styled note to introduce new users.  
   ![Welcome Note](screenshot_welcome_note_1.png)  
   ![Welcome Note Continued](screenshot_welcome_note_2.png)

3. **Rich Text Editor**: Customize your notes with bold, italics, lists, checkboxes, and more using the toolbar.  
   ![Editor with Tool Panel Expanded](screenshot_editor_tool_panel.png)

4. **Sync Pop-up**: Seamlessly sync notes to the cloud for access across devices.  
   ![Sync Note Pop-up](screenshot_sync_popup.png)

5. **Add to Folder**: Organize your notes by adding them to different folders (boxes).  
   ![Add to Folder Pop-up](screenshot_add_to_folder_popup.png)

---

## 🚀 How to Get Started

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/banter.git
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Start the app:
   ```bash
   flutter run
   ```

---

## 🙌 Contributing

Contributions are welcome! Feel free to open issues, submit feature requests, or create pull requests.

---

## 🛡 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Thank you for checking out **Banter**! We hope you enjoy using the app as much as we enjoyed building it. Feel free to explore, take notes, and stay organized like never before. 😊

---

This README emphasizes the app's practical features while also highlighting the solid architecture and modern technologies used in its development. Including the technical details with clean architecture, state management tools, and the well-chosen stack will definitely impress employers.