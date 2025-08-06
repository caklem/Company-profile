# 🚀 PANDUAN HOSTING MANUAL - HOSTINGER

## 📋 INFORMASI KONEKSI
```
FTP Host: 145.79.14.23
Username: u230709022
Password: [password Anda]
Port: 21
Target Directory: /domains/berkahcakrasolusindo.com/public_html
```

## 🎯 METODE 1: FILE MANAGER HOSTINGER (TERMUDAH)

### Langkah-langkah:
1. **Login hPanel Hostinger**
   - Masuk ke https://hostinger.com
   - Login dengan akun Anda

2. **Buka File Manager**
   - Cari menu "File Manager" di hPanel
   - Klik untuk membuka

3. **Navigasi ke Public HTML**
   - Masuk ke folder: `domains`
   - Masuk ke: `berkahcakrasolusindo.com`
   - Masuk ke: `public_html`

4. **Upload File Website**
   - Klik tombol "Upload"
   - Pilih semua file dari folder `dist/`
   - Atau zip folder `dist/` lalu upload dan extract

5. **Atur Permission (jika perlu)**
   - Pastikan file permission 644
   - Folder permission 755

## 🎯 METODE 2: FILEZILLA (FTP CLIENT)

### Install FileZilla:
1. Download dari https://filezilla-project.org
2. Install FileZilla Client

### Koneksi:
1. **Buka FileZilla**
2. **Input kredensial:**
   - Host: `sftp://145.79.14.23` atau `ftp://145.79.14.23`
   - Username: `u230709022`
   - Password: [password Anda]
   - Port: 22 (SFTP) atau 21 (FTP)

3. **Klik Connect**

4. **Navigasi ke target:**
   - Remote directory: `/domains/berkahcakrasolusindo.com/public_html`
   - Local directory: `C:\Users\LOQ\OneDrive\Desktop\Company-Profile\sleepy-spiral\dist`

5. **Upload files:**
   - Drag & drop semua file dari `dist/` ke `public_html/`

## 🎯 METODE 3: ZIP & EXTRACT

### Langkah mudah:
1. **Zip folder dist:**
   ```
   Right-click pada folder dist/ → Send to → Compressed folder
   ```

2. **Upload zip ke hPanel File Manager**

3. **Extract di public_html:**
   - Upload `dist.zip` ke `public_html/`
   - Right-click zip → Extract
   - Pindahkan isi folder ke root `public_html/`
   - Hapus zip file

## ✅ VERIFIKASI WEBSITE

Setelah upload selesai, website Anda akan live di:
- **https://berkahcakrasolusindo.com**

### Test checklist:
- [ ] Website bisa diakses
- [ ] CSS loading dengan benar  
- [ ] Gambar muncul semua
- [ ] Responsive di mobile
- [ ] Loading speed baik

## 🔧 TROUBLESHOOTING

### Jika website tidak muncul:
1. **Clear browser cache** (Ctrl + F5)
2. **Check file structure** - pastikan `index.html` di root
3. **Check DNS propagation** - tunggu 24 jam maksimal
4. **Check SSL** - aktifkan di hPanel

### Jika gambar tidak muncul:
1. **Check case sensitivity** - Linux sensitive
2. **Check file paths** - pastikan path benar
3. **Check file permissions** - 644 untuk file

### Jika CSS tidak loading:
1. **Check _astro folder** uploaded
2. **Check file permissions**
3. **Clear CDN cache** di hPanel

## 🎉 SELAMAT!

Website Company Profile Anda sekarang sudah LIVE di internet!

### Next Steps:
1. ✅ Setup SSL Certificate (Let's Encrypt)
2. ✅ Submit to Google Search Console  
3. ✅ Setup Google Analytics
4. ✅ Test performance di PageSpeed
5. ✅ Share ke social media

**Happy hosting! 🚀**

---
*Jika ada masalah, hubungi Hostinger Support 24/7 melalui live chat di hPanel.*
