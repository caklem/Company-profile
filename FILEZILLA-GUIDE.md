# 📁 PANDUAN UPLOAD FILEZILLA - HOSTINGER

## 🔗 KREDENSIAL KONEKSI
```
Protocol: SFTP (Secure FTP)
Host: sftp://145.79.14.23
Port: 22
Username: u230709022
Password: [your password]
```

## 📋 LANGKAH-LANGKAH FILEZILLA

### 1. Download & Install FileZilla
- Download: https://filezilla-project.org/download.php?type=client
- Install FileZilla Client (GRATIS)

### 2. Setup Koneksi
1. **Buka FileZilla**
2. **File** → **Site Manager** (Ctrl+S)
3. **New Site** → Nama: "Hostinger - berkahcakrasolusindo"
4. **Input kredensial:**
   ```
   Protocol: SFTP - SSH File Transfer Protocol
   Host: 145.79.14.23
   Port: 22
   Logon Type: Normal
   User: u230709022
   Password: [your password]
   ```
5. **Connect**

### 3. Navigasi Directory
**Remote site (Hostinger):**
```
/ (root)
└── domains/
    └── berkahcakrasolusindo.com/
        └── public_html/  ← TARGET FOLDER
```

**Local site (Komputer Anda):**
```
C:\Users\LOQ\OneDrive\Desktop\Company-Profile\sleepy-spiral\dist\
```

### 4. Upload Files
1. **Di panel kiri** (Local): Navigate ke folder `dist/`
2. **Di panel kanan** (Remote): Navigate ke `public_html/`
3. **Select all files** di panel kiri (Ctrl+A)
4. **Right-click** → **Upload**
5. **Tunggu transfer selesai**

### 5. Verifikasi Upload
Pastikan struktur di `public_html/` seperti ini:
```
public_html/
├── index.html
├── favicon.png
├── favicon.svg
├── site.webmanifest
├── .htaccess
├── images/
│   ├── logo-cakra-solusindo-placeholder.txt
│   └── affiliates/
│       ├── Badan Nasional Sertifikasi Profesi.png
│       ├── Badan Pengawas Obat Makanan.png
│       └── [all affiliate logos]
└── _astro/
    └── index.2Ygoppxk.css
```

## ⚡ TIPS UPLOAD SUCCESS

### Jika koneksi terputus:
- FileZilla auto-resume transfer
- Right-click → "Resume transfer"

### Jika ada file yang gagal:
- Right-click → "Re-queue file"
- Atau upload manual satu-satu

### Check file permissions:
- Files: 644
- Folders: 755
- Right-click → File permissions

## 🚨 TROUBLESHOOTING

### Koneksi ditolak:
1. Coba ganti Protocol ke FTP (port 21)
2. Check firewall/antivirus
3. Coba koneksi dari lokasi berbeda

### Upload lambat:
1. Pause/Resume transfer
2. Upload di jam sepi (malam)
3. Upload file besar terpisah

### Permission denied:
1. Check folder ownership di hPanel
2. Set permission 755 untuk folder
3. Set permission 644 untuk file

## ✅ TESTING WEBSITE

Setelah upload selesai:
1. **Visit**: https://berkahcakrasolusindo.com
2. **Test loading speed**
3. **Check di mobile**
4. **Verify all images load**

## 🎉 SUCCESS!

Website Company Profile berhasil di-hosting! 🚀
