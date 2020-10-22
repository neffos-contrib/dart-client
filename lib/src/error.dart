
class SocketError extends Error implements UnsupportedError  {

  final String message;

  SocketError(this.message);

  String toString() {
    var message = this.message;
    return (message != null)
        ? "SocketError: $message"
        : "SocketError";
  }
}

var errBadNamespace = new SocketError("bad namespace");
var errorClosed = new SocketError("use of closed connection");
var errWrite = new SocketError("write closed");