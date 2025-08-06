# 🚀 WINSCP SESSION IMPORT GUIDE

## 📋 CARA IMPORT SESSION HOSTINGER

### STEP 1: Locate WinSCP Configuration
1. **Buka Windows Explorer**
2. **Navigate ke:** `%APPDATA%\WinSCP 2`
   - Atau ketik di address bar: `C:\Users\%USERNAME%\AppData\Roaming\WinSCP 2`
3. **Cari file:** `WinSCP.ini`

### STEP 2: Backup Original Config
1. **Copy file:** `WinSCP.ini`
2. **Rename copy:** `WinSCP.ini.backup`
3. **Safety first!** 🛡️

### STEP 3: Import Session (METHOD 1 - Manual)
1. **Open:** `WinSCP.ini` dengan Notepad
2. **Scroll ke bagian bawah** file
3. **Copy & Paste** content dari `Hostinger-Session.ini`
4. **Save file**

### STEP 4: Import Session (METHOD 2 - Replace)
1. **Close WinSCP** jika sedang buka
2. **Replace:** `WinSCP.ini` dengan `Hostinger-Session.ini`
3. **Rename:** `Hostinger-Session.ini` → `WinSCP.ini`

### STEP 5: Buka WinSCP
1. **Launch WinSCP**
2. **Session akan muncul:** "Hostinger-BerkahCakraSolusindo"
3. **Input password** FTP Anda
4. **Klik Login**

## ⚙️ SESSION DETAILS

```
Session Name: Hostinger-BerkahCakraSolusindo
Protocol: FTP
Host: 145.79.14.23
Port: 21
Username: u230709022
Password: [You need to enter manually]
Local Directory: C:\Users\LOQ\OneDrive\Desktop\Company-Profile\sleepy-spiral\dist
Remote Directory: /public_html
Passive Mode: Enabled
Timeout: 30 seconds
```

## 🎯 ADVANTAGES

✅ **No manual setup** - Session sudah configured
✅ **Auto navigate** ke folder yang benar
✅ **Optimal settings** untuk Hostinger
✅ **Quick connect** - tinggal input password
✅ **Passive mode** enabled untuk shared hosting

## 🔧 JIKA IMPORT GAGAL

### Alternative - Manual Setup:
1. **Launch WinSCP**
2. **New Session**
3. **Input manually:**
   ```
   File protocol: FTP
   Host name: 145.79.14.23
   Port: 21
   User name: u230709022
   Password: [your FTP password]
   ```
4. **Advanced Settings:**
   - Remote directory: `/public_html`
   - Passive mode: ✅ Enabled
   - Timeout: 30 seconds
5. **Save session** as "Hostinger-BerkahCakraSolusindo"

## 🚀 QUICK START

Setelah session imported:
1. **Double-click** session "Hostinger-BerkahCakraSolusindo"
2. **Enter password** FTP
3. **Connect!**
4. **Upload files** dari `dist/` ke `public_html/`

**Total setup time: 2 menit!** ⚡

---

*File session ini sudah dioptimalkan untuk Hostinger shared hosting dengan passive mode enabled dan timeout yang sesuai.*
