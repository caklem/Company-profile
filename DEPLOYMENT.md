# 🚀 Deployment Guide ke Hostinger

Panduan lengkap untuk hosting website Astro Company Profile di Hostinger.

## 📋 Persiapan

### 1. Akun & Hosting Hostinger
- Beli hosting di [Hostinger.com](https://hostinger.com)
- Pilih paket sesuai kebutuhan
- Setup domain Anda

### 2. Kredensial yang Dibutuhkan
Dari hPanel Hostinger, catat:
- **FTP Host**: `your-domain.com` atau IP server
- **FTP Username**: username hosting Anda
- **FTP Password**: password hosting Anda
- **Directory**: `/public_html`

## 🛠️ Cara Deploy

### Metode 1: Manual Upload (Recommended untuk Pemula)

1. **Build project:**
   ```bash
   npm run build
   ```

2. **Login ke hPanel Hostinger**
   - Masuk ke File Manager
   - Navigasi ke folder `public_html`

3. **Upload file:**
   - Upload semua isi folder `dist/` ke `public_html/`
   - Pastikan file `index.html` ada di root `public_html/`

4. **Setup SSL (Optional tapi Recommended):**
   - Di hPanel → SSL → Let's Encrypt → Generate

### Metode 2: FTP Client (FileZilla)

1. **Download FileZilla** dari [filezilla-project.org](https://filezilla-project.org)

2. **Koneksi SFTP:**
   - Host: `sftp://your-domain.com`
   - Username: username hosting
   - Password: password hosting
   - Port: 22

3. **Upload:**
   - Drag & drop isi folder `dist/` ke `public_html/`

### Metode 3: Menggunakan Script Deployment

1. **Edit file `Deploy-Hostinger.ps1`:**
   ```powershell
   # Ganti kredensial ini dengan milik Anda
   $FtpHost = "your-domain.com"
   $FtpUser = "your-username"
   $FtpPass = "your-password"
   ```

2. **Jalankan script:**
   ```powershell
   .\Deploy-Hostinger.ps1
   ```

## 🔧 Konfigurasi Tambahan

### SSL Certificate
1. Di hPanel Hostinger
2. Masuk ke **SSL**
3. Pilih **Let's Encrypt**
4. Generate certificate untuk domain Anda

### Domain Configuration
1. Update nameserver domain ke Hostinger:
   - `ns1.dns-parking.com`
   - `ns2.dns-parking.com`
2. Atau tambahkan A Record pointing ke IP server

### Performance Optimization
File `.htaccess` sudah dikonfigurasi dengan:
- ✅ Compression (Gzip)
- ✅ Browser caching
- ✅ Security headers
- ✅ Clean URLs
- ✅ HTTPS redirect

## 📂 Struktur File di Server

```
public_html/
├── index.html          # Homepage
├── favicon.png         # Website icon
├── favicon.svg         # SVG icon
├── site.webmanifest   # PWA manifest
├── .htaccess          # Server configuration
├── images/            # Image assets
│   ├── affiliates/    # Partner logos
│   └── ...
└── _astro/            # Compiled CSS/JS
    ├── *.css
    └── *.js
```

## ✅ Checklist Deployment

- [ ] Build project berhasil (`npm run build`)
- [ ] File `.htaccess` sudah ada di dist
- [ ] Upload semua file ke `public_html/`
- [ ] SSL certificate aktif
- [ ] Domain sudah pointing ke Hostinger
- [ ] Website bisa diakses di browser
- [ ] Test di mobile & desktop
- [ ] Check performance di PageSpeed Insights

## 🐛 Troubleshooting

### Website tidak muncul
1. Cek apakah `index.html` ada di root `public_html/`
2. Cek DNS propagation di [whatsmydns.net](https://whatsmydns.net)
3. Clear browser cache

### Gambar tidak muncul
1. Cek path gambar di folder `images/`
2. Pastikan case-sensitive path benar
3. Cek file permissions di File Manager

### CSS/JS tidak load
1. Cek folder `_astro/` sudah terupload
2. Clear CDN cache di hPanel
3. Hard refresh browser (Ctrl+F5)

## 📞 Support

Jika ada masalah:
1. **Hostinger Support**: Live chat 24/7
2. **Documentation**: [support.hostinger.com](https://support.hostinger.com)
3. **Community**: [community.hostinger.com](https://community.hostinger.com)

## 🎉 Selamat!

Website Company Profile Anda sekarang sudah live di internet! 🌐

### Next Steps:
- Setup Google Analytics
- Submit sitemap ke Google Search Console
- Test performance & SEO
- Backup berkala

---

**Happy hosting! 🚀**
