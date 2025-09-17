# create-mvc-cli

🚀 A simple **command-line tool** to generate a backend project with an **MVC architecture**.  
Supports **Node.js (Express)** and **Python (FastAPI)**. Future support planned for **Java**.  

---

## ✨ Features
- 📂 Auto-generates MVC folder structure:
  - `controllers`, `models`, `routes`, `services`, `config`, `middlewares`
- ⚡ Quick setup for:
  - **Node.js + Express**
  - **Python + FastAPI** (pip or uv)
- 🎨 Colorful CLI prompts
- 🐍 Interactive choice for Python frameworks
- 🛠 Extensible design for more languages/frameworks in future
- 📦 Installer script for easy setup and PATH integration

---

## 📦 Installation

1. Clone the repo:
    ```bash
    git clone https://github.com/<your-username>/create-mvc-cli.git
    cd create-mvc-cli
    ```

2.  Make the script executable:
    ```bash
    chmod +x create-mvc.sh install-create-mvc.sh
    ```

3.  Run the installer (recommended, sets up PATH automatically):
    ```bash
    zsh install-create-mvc.sh
    ```
    
    ```
    NOTE: This installs the CLI in a hidden folder ~/.create-mvc and adds it to your PATH.
    If this is the first time on a macOS account, the installer will create .zshrc if it doesn’t exist.
    You may need to restart the terminal or run source ~/.zshrc after installation.
    ```

4.  Verify Installation:
    ```bash
    create-mvc --help
    ```

## Usage

1.  Node.js + Express.js
    ```bash
    create-mvc --lang node my-backend
    ```

2.  Python + FastAPI
    ```bash
    create-mvc --lang python my-api
    ```
    Then choose
    ```bash
    🐍 Python backend detected.
    👉 Choose a framework option:
    1) FastAPI (pip)
    2) FastAPI (uv)
    ```

3.  Java
    ```bash
    create-mvc --lang java my-service
    ```
    comming soon (☕️)

## 📂 Example Project Structure

1.  Node.js

    ```bash
    my-backend/
    ├── server.js
    ├── package.json
    └── src/
        ├── app.js
        ├── controllers/
        ├── models/
        ├── routes/
        ├── services/
        ├── config/
        └── middlewares/
    ```

2.  Python
    ```bash
    my-api/
    ├── requirements.txt   # or uv project files
    └── app/
        ├── main.py
        ├── api/
        ├── models/
        ├── schemas/
        ├── services/
        ├── core/
        │   └── config.py
        └── middlewares/
    ```

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues and PRs to add more languages, frameworks, or features.

## 📜 License
MIT License. See [LICENSE](LICENSE) for details.
