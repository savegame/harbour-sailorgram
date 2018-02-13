#ifndef DEFINES_H
#define DEFINES_H

#define APP_PRETTY_NAME "Telega"
#define APP_SHORT_NAME "telega"
#define APP_NAME "harbour-" APP_SHORT_NAME
#define APP_VERSION "0.90"

#define QML_INTERFACE_BASE "harbour." APP_SHORT_NAME
#define QML_INTERFACE(x) QML_INTERFACE_BASE "." x
#define DBUS_INTERFACE "org.harbour." APP_SHORT_NAME

#define EMOJI_FOLDER "emoji"

#define NETWORK_USER_AGENT "Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405"

// Telegram API
#define TELEGRAM_API_ID 171211
#define TELEGRAM_API_HASH "7eac40b28e0c14296de77867358481dd"
#define TELEGRAM_HOST_IP "149.154.167.50"
#define TELEGRAM_HOST_PORT 443
#define TELEGRAM_DC_ID 2
#define TELEGRAM_PUBLIC_KEY_FILE "public.key"

#endif // DEFINES_H
