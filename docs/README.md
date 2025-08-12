# Documentation

## 📊 Visual Diagrams

This directory contains interactive Excalidraw diagrams that illustrate the Claude Learning System architecture.

### Viewing Diagrams

You have several options to view the diagrams:

#### Option 1: Excalidraw Web Editor (Recommended)
1. Go to [excalidraw.com](https://excalidraw.com)
2. Click File → Open
3. Select one of the `.excalidraw` files from this directory

#### Option 2: VS Code Extension
1. Install the [Excalidraw VS Code extension](https://marketplace.visualstudio.com/items?itemName=pomdtr.excalidraw-editor)
2. Open any `.excalidraw` file directly in VS Code

#### Option 3: Direct Links
- [Architecture Diagram](https://excalidraw.com) - Then open `architecture-diagram.excalidraw`
- [Flow Diagram](https://excalidraw.com) - Then open `flow-diagram.excalidraw`

### Available Diagrams

#### 1. Architecture Diagram (`architecture-diagram.excalidraw`)
Shows the complete system architecture including:
- User input flow
- Slash command processing
- Python handler logic
- Storage mechanisms (CLAUDE.md and JSON)
- Claude's reading process

#### 2. Flow Diagram (`flow-diagram.excalidraw`)
Simplified 4-step process:
1. Teach (user input)
2. Process (categorization)
3. Store (persistence)
4. Apply (next session)

### Exporting Diagrams

To export diagrams as images:
1. Open in Excalidraw
2. Select File → Export image
3. Choose format (PNG/SVG)
4. Save to `docs/images/` directory

## 📚 Other Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed system architecture
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute to the project
- [Examples](../examples/) - Example learnings and use cases