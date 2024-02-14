rem Sign Aetos app
rem Password: AppsMark
del aetos.keystore
C:\Work\Android\keytool -genkey -v -keystore aetos.keystore -alias aetos -keyalg RSA -keysize 2048 -validity 10000