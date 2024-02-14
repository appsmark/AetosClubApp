# Template for Nativescript apps

# Orientation
Adapt App_Resources\Android\src\main\AndroidManifest.xml
Add in section <activity
	android:screenOrientation="portrait"
or
	android:screenOrientation="landscape"

# Splashscreen
Generate from root directory with:
	ns resources generate splashes <path to picture> --background <color>
	ns resources generate splashes res\splashscreen.png --background yellow
	
? duration

To show picture on entire screen:
Adapt App_Resources\Android\src\main\res\drawable-nodpi\splash_screen.xml
	<layer-list xmlns:android="http://schemas.android.com/apk/res/android" android:gravity="fill">
		<item>
			<bitmap android:gravity="fill" android:src="@drawable/logo" />
		</item>
	</layer-list>

# Icon
Generate from root directory with:
	ns resources generate icons <path to picture>
	ns resources generate icons res\ic_launcher.png 

Create png file sized 108x108 (not necessary, you can scale ?)
Convert to svg on https://www.pngtosvg.com/
Copy paths and colors into App_Resources\Android\src\main\res\drawable\ic_launcher_foreground.xml

Adaptive icon background
Adapt App_Resources\Android\src\main\res\values\ic_launcher_background.xml
    <color name="ic_launcher_background">#FFFFFF</color>

# App name
Set name in App_Resources\Android\src\main\res\values\string.xml
	<string name="title_activity_kimera">DISPLAY NAME</string>
	
Set name in package.json and package-lock.json
  "nativescript": {
	"id": "com.appsmark.paardensprong",
	"version": "1.5.1"
  },

Set name in nativescript.config.ts
  id: 'com.appsmark.paardensprong',
  
  
# App version
Adapt App_Resources\Android\src\main\AndroidManifest.xml
	android:versionCode="12000"
	android:versionName="1.2">
	
	
TEMPLATE
- copy directory template
- adapt:
		- nativescript.config.ts
		- package.json
		- strings.xml:
			<string name="app_name">TEMPLATE</string>
			<string name="title_activity_kimera">TEXT ICON</string>

OpenJdk has to be killed every once in a while			