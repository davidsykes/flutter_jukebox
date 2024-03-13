import http.server
import socketserver
import os

class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/d':
            self.send_response(200)
            self.send_header("Content-type", "text/html")
            self.end_headers()

            name = os.environ.get('JukeboxApiServerIp')
            html = f"<html><head></head><body>API {name}</body></html>"
            self.wfile.write(bytes(html, "utf8"))
            return

        return http.server.SimpleHTTPRequestHandler.do_GET(self)

handler_object = MyHttpRequestHandler

PORT = 8000
my_server = socketserver.TCPServer(("", PORT), handler_object)

my_server.serve_forever()