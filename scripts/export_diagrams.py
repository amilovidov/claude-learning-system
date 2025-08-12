#!/usr/bin/env python3
"""
Export Excalidraw diagrams to PNG images for README
Note: This requires the excalidraw-cli tool or we can use the web API
"""

import json
import base64
import urllib.parse

def generate_excalidraw_link(json_file_path):
    """Generate a shareable Excalidraw link with embedded data"""
    with open(json_file_path, 'r') as f:
        data = json.load(f)
    
    # Convert to JSON string and encode
    json_string = json.dumps(data)
    encoded = base64.b64encode(json_string.encode()).decode()
    
    # Create shareable link
    link = f"https://excalidraw.com/#json={encoded}"
    return link

def generate_static_image_url(json_file_path):
    """Generate URL for static image preview (using Excalidraw's preview service)"""
    # Note: This is a placeholder - Excalidraw doesn't provide a direct image export API
    # You would need to either:
    # 1. Use a headless browser to capture screenshots
    # 2. Use the Excalidraw npm package to export
    # 3. Manually export from the Excalidraw editor
    pass

if __name__ == "__main__":
    # Generate shareable links
    architecture_link = generate_excalidraw_link("docs/architecture-diagram.excalidraw")
    flow_link = generate_excalidraw_link("docs/flow-diagram.excalidraw")
    
    print("Architecture Diagram Link:")
    print(architecture_link[:100] + "...")  # Truncate for display
    print("\nFlow Diagram Link:")
    print(flow_link[:100] + "...")
    
    print("\n⚠️  Note: For static images in README, you need to:")
    print("1. Open each link in Excalidraw")
    print("2. Use File > Export image > PNG")
    print("3. Save to docs/images/ directory")
    print("4. Reference in README as ![Diagram](docs/images/architecture.png)")