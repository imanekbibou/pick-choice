import http.server
import socketserver
import webbrowser

PORT = 8080

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serveur lancé sur http://localhost:{PORT}/train.html")
    webbrowser.open(f"http://localhost:{PORT}/train.html")
    httpd.serve_forever()
