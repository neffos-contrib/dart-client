const OnNamespaceConnect = "_OnNamespaceConnect";

/* The OnNamespaceConnected is the event name that it's fired on after namespace connect. */
const OnNamespaceConnected = "_OnNamespaceConnected";

/* The OnNamespaceDisconnect is the event name that it's fired on namespace disconnected. */
const OnNamespaceDisconnect = "_OnNamespaceDisconnect";

/* The OnRoomJoin is the event name that it's fired on before room join. */
const OnRoomJoin = "_OnRoomJoin";

/* The OnRoomJoined is the event name that it's fired on after room join. */
const OnRoomJoined = "_OnRoomJoined";

/* The OnRoomLeave is the event name that it's fired on before room leave. */
const OnRoomLeave = "_OnRoomLeave";

/* The OnRoomLeft is the event name that it's fired on after room leave. */
const OnRoomLeft = "_OnRoomLeft";

/* The OnAnyEvent is the event name that it's fired, if no incoming event was registered, it's a "wilcard". */
const OnAnyEvent = "_OnAnyEvent";

/* The OnNativeMessage is the event name, which if registered on empty ("") namespace
   it accepts native messages(Message.Body and Message.IsNative is filled only). */
const OnNativeMessage = "_OnNativeMessage";

const ackBinary = 'M'; // see `onopen`, comes from client to server at startup.
// see `handleAck`.
// comes from server to client after ackBinary and ready as a prefix, the rest message is the conn's ID.
const ackIDBinary = 'A';

// comes from server to client if `Server#OnConnected` errored as a prefix, the rest message is the error text.
const ackNotOKBinary = 'H';

const waitIsConfirmationPrefix = '#';

const waitComesFromClientPrefix = '\$';