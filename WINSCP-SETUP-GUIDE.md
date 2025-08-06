# 📘 PANDUAN LENGKAP SETUP WINSCP UNTUK HOSTINGER

## 🔽 STEP 1: DOWNLOAD WINSCP

1. **Buka link:** https://winscp.net/eng/download.php
2. **Download:** WinSCP 5.25.6 Installation package
3. **File size:** ~11MB
4. **Gratis & Aman**

## 📦 STEP 2: INSTALL WINSCP

1. **Run installer** sebagai Administrator
2. **Accept License Agreement**
3. **Choose components:**
   - ✅ WinSCP Application
   - ✅ Drag & Drop Extension
   - ✅ Windows Explorer Integration
4. **Installation location:** Default (C:\Program Files\WinSCP)
5. **Click Install**
6. **Finish & Launch WinSCP**

## ⚙️ STEP 3: SETUP KONEKSI KE HOSTINGER

### Kredensial Hostinger Anda (UPDATED):
```
Protocol: FTP 
Host: 145.79.14.23
Port: 21
Username: u230709022
Password: [password baru yang sudah direset]
Target Folder: public_html (bukan domains/berkahcakrasolusindo.com/public_html)
```

### Setup di WinSCP:
1. **Launch WinSCP**
2. **Login Dialog** akan muncul
3. **Input data:**
   ```
   File protocol: FTP (BUKAN SFTP!)
   Host name: 145.79.14.23
   Port number: 21 (BUKAN 22!)
   User name: u230709022
   Password: [masukkan password FTP Anda]
   ```
4. **Advanced Settings (IMPORTANT):**
   - Klik **Advanced**
   - **Environment** → **Directories** → **Remote directory**: `/public_html` (BUKAN /domains/...)
   - **Connection** → **Timeout**: 30 seconds
   - **Connection** → **Passive mode**: ✅ Checked
5. **Save Session:**
   - ✅ **Save password** (untuk kemudahan)
   - **Session name**: "Hostinger - berkahcakrasolusindo"
   - Klik **Save**
6. **Test Connection:**
   - Klik **Login**
   - Jika muncul warning certificate → **Yes/Accept**

## 🎯 STEP 4: NAVIGASI KE FOLDER TARGET

Setelah koneksi berhasil:

### Panel Kiri (Local - Komputer Anda):
```
Navigate ke:
C:\Users\LOQ\OneDrive\Desktop\Company-Profile\sleepy-spiral\dist\
```

### Panel Kanan (Remote - Hostinger Server):
```
Navigate ke:
/ → public_html (langsung ke folder utama)
```

**Target Path:** `/public_html`

## 📤 STEP 5: UPLOAD WEBSITE FILES (INDIVIDUAL - RECOMMENDED)

### 🎯 UPLOAD STRATEGY (No ZIP, No Extract):

#### **PHASE 1: Core Files (Upload Priority 1)**
```
1. index.html (62.94 KB) ← UTAMA!
2. favicon.png (109.36 KB)
3. favicon.svg (0.73 KB)  
4. site.webmanifest (0.55 KB)
```

#### **PHASE 2: CSS Files (Upload Priority 2)**
```
5. _astro/index.2Ygoppxk.css (68.39 KB)
```

#### **PHASE 3: Images (Upload Priority 3)**
```
6. images/logo-cakra-solusindo-placeholder.txt (0.54 KB)
7. images/affiliates/ folder dengan semua PNG/JPG files
```

### Cara Upload Individual:
1. **Di panel kiri:** Browse ke folder `dist/`
2. **JANGAN Select All!** - Pilih file satu per satu atau batch kecil
3. **Start with index.html** - Upload file utama dulu
4. **Drag & Drop** individual files ke panel kanan (public_html)
5. **Upload folders** satu per satu

### Transfer Options:
```
Transfer Mode: Binary (Auto)
Overwrite: Yes to All
Resume: Yes (if interrupted)
Upload Method: Individual Files (NO ZIP!)
```

### ✅ KEUNTUNGAN INDIVIDUAL UPLOAD:
- ❌ **No 500 Server Error**
- ❌ **No extraction needed**
- ❌ **No memory limit issues**
- ✅ **Direct upload ke public_html**
- ✅ **Faster & more reliable**
- ✅ **Can resume if interrupted**

### File Structure Target:
```
public_html/
├── index.html              ← MAIN FILE
├── favicon.png
├── favicon.svg
├── site.webmanifest
├── images/                 ← FOLDER
│   ├── logo-cakra-solusindo-placeholder.txt
│   └── affiliates/         ← SUBFOLDER
│       └── [all PNG/JPG files]
└── _astro/                 ← FOLDER
    └── index.2Ygoppxk.css  ← CSS FILE
```

## ✅ STEP 6: VERIFIKASI UPLOAD

### Check List:
- [ ] **index.html** ada di root public_html
- [ ] **Folder images/** terupload lengkap
- [ ] **Folder _astro/** dengan CSS file
- [ ] **Total 17 files** terupload
- [ ] **No error messages**

### Test Website:
1. **Buka browser**
2. **Visit:** https://berkahcakrasolusindo.com
3. **Check loading:** CSS, images, responsive

## 🔧 TROUBLESHOOTING

### Koneksi Gagal:
```
❌ "530 Login incorrect" 
→ PASSWORD SALAH! Check password di hPanel
→ Username mungkin salah format
→ Coba username@domain format
→ Reset password FTP di hPanel

❌ "Network error: Connection timed out"
❌ "Server rejected SFTP connection"
→ GUNAKAN FTP bukan SFTP!
→ Port 21 bukan 22!
→ Check internet connection
→ Verify credentials
→ Enable Passive Mode di Advanced settings
```

### Upload Lambat:
```
❌ "Transfer taking too long"
→ Upload during off-peak hours
→ Upload files in batches
→ Check background apps using internet
```

### Permission Denied:
```
❌ "Permission denied"
→ Check folder ownership in hPanel
→ Set permissions: Files 644, Folders 755
→ Contact Hostinger support
```

### File Corruption:
```
❌ "File appears corrupted"
→ Re-upload specific files
→ Check antivirus interference
→ Use Binary transfer mode
```

### ZIP Extraction Error (500 Internal Server Error):
```
❌ "500 Internal Server Error" saat ekstrak ZIP
→ JANGAN upload ZIP file ke shared hosting!
→ ZIP terlalu besar (40MB+) untuk shared hosting
→ Server timeout saat ekstraksi
→ Memory limit PHP terlampaui

SOLUSI TERBAIK:
✅ Upload files INDIVIDUAL dengan WinSCP/FileZilla
✅ Upload folder dist/ langsung tanpa ZIP
✅ Gunakan FTP client, bukan File Manager
✅ Upload step-by-step: Core files → CSS → Images
✅ NO COMPRESSION, NO EXTRACTION needed!
```

### Upload Individual Success Tips:
```
✅ "Start with index.html first"
→ Upload file utama dulu untuk test
→ Lalu favicon files
→ Kemudian CSS di folder _astro/
→ Terakhir images di folder images/

✅ "Upload in small batches"
→ Max 3-5 files per batch
→ Wait for completion before next batch
→ More reliable than bulk upload
```

## 🎉 SUCCESS INDICATORS

### Upload Berhasil Jika:
✅ **All 17 files transferred** without errors
✅ **Website loads** di https://berkahcakrasolusindo.com
✅ **CSS styling** tampil dengan benar
✅ **Images loading** semua
✅ **Mobile responsive** bekerja

## 📞 BANTUAN TAMBAHAN

### WinSCP Support:
- **Documentation:** https://winscp.net/docs/
- **Video Tutorials:** YouTube "WinSCP Tutorial"
- **Community Forum:** https://winscp.net/forum/

### Hostinger Support:
- **Live Chat:** 24/7 di hPanel
- **Knowledge Base:** support.hostinger.com
- **Phone Support:** Available in hPanel

---

## 🚀 QUICK SUMMARY

1. **Download WinSCP** → Install
2. **Setup SFTP connection** dengan kredensial Hostinger
3. **Navigate** ke public_html folder
4. **Upload folder dist/** dengan drag & drop
5. **Test website** di browser

**Total waktu: 10-15 menit** ⏱️

**Website akan LIVE setelah upload selesai!** 🎉
