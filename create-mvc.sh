#!/bin/zsh

set -e

# 🎨 Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ----------------------
# Helper / Usage message
# ----------------------
show_help() {
  echo ""
  echo -e "${BLUE}🚀 create-mvc - Generate a backend project with MVC structure${NC}"
  echo ""
  echo "Usage:"
  echo "  create-mvc --lang <node|python|java> <project-name>"
  echo ""
  echo "Options:"
  echo "  --lang <node|python|java>   Specify backend language"
  echo "  --help                      Show this help message"
  echo ""
  echo "Examples:"
  echo "  create-mvc --lang node my-backend"
  echo "  create-mvc --lang python my-api"
  echo "  create-mvc --lang java my-service"
  echo ""
}

# ----------------------
# Parse arguments
# ----------------------
if [[ "$1" == "--help" || $# -lt 3 ]]; then
  show_help
  exit 0
fi

if [[ "$1" != "--lang" ]]; then
  echo -e "${RED}❌ Missing or invalid flag. Use --lang${NC}"
  show_help
  exit 1
fi

LANG=$2
PROJECT_NAME=$3

# ----------------------
# Node.js + Express setup
# ----------------------
setup_node() {
  mkdir -p $PROJECT_NAME
  cd $PROJECT_NAME

  echo -e "${YELLOW}📂 Creating MVC structure for Node.js + Express in $PROJECT_NAME${NC}"

  npm init -y >/dev/null 2>&1
  npm install express >/dev/null 2>&1

  mkdir -p src/{controllers,models,routes,services,config,middlewares}

  # app.js
  cat <<EOL > src/app.js
const express = require('express');
const app = express();

// Middleware
app.use(express.json());

// Routes (to be added)
app.use('/api', require('./routes'));

module.exports = app;
EOL

  # server.js
  cat <<EOL > server.js
const app = require('./src/app');
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(\`🚀 Server running on http://localhost:\${PORT}\`);
});
EOL

  npx json -I -f package.json -e 'this.scripts.start="node server.js"'

  echo -e "${GREEN}✅ Node.js MVC project $PROJECT_NAME created successfully!${NC}"
  echo -e "👉 cd $PROJECT_NAME && npm start"
}

# ----------------------
# Python + FastAPI (pip)
# ----------------------
setup_fastapi_pip() {
  mkdir -p $PROJECT_NAME
  cd $PROJECT_NAME

  echo -e "${YELLOW}📂 Creating MVC structure for FastAPI (pip) in $PROJECT_NAME${NC}"

  echo "fastapi" > requirements.txt
  echo "uvicorn[standard]" >> requirements.txt

  mkdir -p app/{api,models,schemas,services,core,middlewares} tests

  touch app/api/__init__.py app/models/__init__.py app/schemas/__init__.py \
        app/services/__init__.py app/core/__init__.py app/middlewares/__init__.py \
        tests/__init__.py app/__init__.py

  cat <<EOL > app/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World from FastAPI (pip) MVC setup!"}
EOL

  cat <<EOL > app/core/config.py
PROJECT_NAME = "FastAPI MVC Project"
VERSION = "0.1.0"
EOL

  echo -e "${GREEN}✅ FastAPI (pip) project $PROJECT_NAME created successfully!${NC}"
  echo -e "👉 cd $PROJECT_NAME && pip install -r requirements.txt && uvicorn app.main:app --reload"
}

# ----------------------
# Python + FastAPI (uv)
# ----------------------
setup_fastapi_uv() {
  echo -e "${YELLOW}📂 Creating MVC structure for FastAPI (uv) in $PROJECT_NAME${NC}"

  uv init $PROJECT_NAME >/dev/null 2>&1
  cd $PROJECT_NAME

  uv add fastapi uvicorn >/dev/null 2>&1

  mkdir -p app/{api,models,schemas,services,core,middlewares} tests

  touch app/api/__init__.py app/models/__init__.py app/schemas/__init__.py \
        app/services/__init__.py app/core/__init__.py app/middlewares/__init__.py \
        tests/__init__.py app/__init__.py

  cat <<EOL > app/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World from FastAPI (uv) MVC setup!"}
EOL

  cat <<EOL > app/core/config.py
PROJECT_NAME = "FastAPI MVC Project"
VERSION = "0.1.0"
EOL

  echo -e "${GREEN}✅ FastAPI (uv) project $PROJECT_NAME created successfully!${NC}"
  echo -e "👉 cd $PROJECT_NAME && uv run uvicorn app.main:app --reload"
}

# ----------------------
# Dispatcher
# ----------------------
case $LANG in
  node)
    setup_node
    ;;
  python)
    echo -e "${YELLOW}🐍 Python backend detected.${NC}"
    echo -e "${BLUE}👉 Choose a framework option:${NC}"
    echo -e "1) FastAPI (pip)"
    echo -e "2) FastAPI (uv)"
    read -r choice

    case $choice in
      1) setup_fastapi_pip ;;
      2) setup_fastapi_uv ;;
      *) echo -e "${RED}❌ Invalid choice${NC}"; exit 1 ;;
    esac
    ;;
  java)
    echo -e "${RED}☕ Java scaffolding not implemented yet.${NC}"
    ;;
  *)
    echo -e "${RED}❌ Unsupported language: $LANG${NC}"
    show_help
    exit 1
    ;;
esac
