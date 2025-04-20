# RSChat

RSChat is a real-time chat application for iOS, built with a modern MVVM architecture and programmatic UIKit. The app connects to a Rust-based server via TCP socket communication using Apple's `NWConnection` framework, enabling seamless and efficient message exchange. RSChat provides a clean, responsive user interface and a robust backend for real-time messaging.

## Screenshots

![RSChat Interface](https://github.com/user-attachments/assets/4d88f9fe-3c72-43c4-86c3-ffe642fd5cd0)

## Features

- **Real-Time Messaging**: Send and receive messages instantly using TCP socket connections.
- **Programmatic UIKit**: A fully programmatic user interface built without Storyboards, ensuring flexibility and maintainability.
- **MVVM Architecture**: Modular and testable codebase with clear separation of concerns.
- **Rust Backend**: A high-performance server written in Rust, handling socket communication reliably.
- **Dynamic Configuration**: Server IP configuration via `xcconfig` for easy environment switching.
- **User-Friendly Input**: A `UITextView` with placeholder support for intuitive message composition.
- **Auto-Scrolling**: Automatically scrolls to the latest message for a smooth user experience.

## Tech Stack

### iOS Client

- **Language**: Swift
- **Framework**: UIKit (100% programmatic)
- **Architecture**: MVVM
- **Networking**: `NWConnection` for TCP socket communication
- **Configuration**: `xcconfig` for environment-specific settings
- **UI Components**: Custom `UITableView` for message display, `UITextView` with placeholder
- **Dependencies**: SnapKit for programmatic layout

### Server

- **Language**: Rust
- **Protocol**: TCP socket for real-time communication
- **Purpose**: Handles client connections and message relaying
- **Repository**: [Rust Server] https://github.com/BaranBaranDev/TCP-Chat


## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/BaranBaranDev/RSChat.git
cd RSChat
