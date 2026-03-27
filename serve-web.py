#!/usr/bin/env python3
"""
Serveur HTTP simple avec support des fonts pour Flutter Web
"""
import http.server
import socketserver
import mimetypes
import sys
import os

# Configuration MIME types pour les fonts
mimetypes.add_type('font/otf', '.otf')
mimetypes.add_type('font/ttf', '.ttf')
mimetypes.add_type('application/font-woff', '.woff')
mimetypes.add_type('application/font-woff2', '.woff2')
mimetypes.add_type('application/x-font-opentype', '.otf')
mimetypes.add_type('application/x-font-truetype', '.ttf')

PORT = 8080
DIRECTORY = "build/web"

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def do_GET(self):
        # Flutter Web SPA routing: rediriger toutes les routes vers index.html
        # sauf les fichiers réels (assets, js, css, images, etc.)
        path = self.path.split('?')[0]  # Retirer les query params

        # Si c'est une route Flutter (pas un fichier avec extension)
        # et que le fichier n'existe pas, servir index.html
        if not os.path.splitext(path)[1] and not os.path.exists(os.path.join(DIRECTORY, path.lstrip('/'))):
            if path != '/':  # Pas la racine
                self.path = '/index.html'

        return super().do_GET()

        self.send_header('Access-Control-Allow-Headers', '*')

        # Cache control pour les fonts
        if self.path.endswith(('.otf', '.ttf', '.woff', '.woff2')):
            self.send_header('Cache-Control', 'public, max-age=31536000')

        super().end_headers()

if __name__ == '__main__':
    # Vérifier que le dossier build/web existe
    if not os.path.exists(DIRECTORY):
        print(f"❌ Erreur: Le dossier '{DIRECTORY}' n'existe pas")
        print("   Assurez-vous d'être dans le dossier racine du projet")
        sys.exit(1)

    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        print(f"✅ Serveur Flutter Web démarré")
        print(f"🌐 URL: http://localhost:{PORT}")
        print(f"📁 Dossier: {DIRECTORY}")
        print(f"")
        print(f"Appuyez sur Ctrl+C pour arrêter")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n👋 Serveur arrêté")
            sys.exit(0)
