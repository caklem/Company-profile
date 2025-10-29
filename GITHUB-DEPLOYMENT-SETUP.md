# 🚀 Setup GitHub Actions Deployment ke Hostinger

Panduan lengkap untuk setup deployment otomatis via GitHub Actions menggunakan SSH key.

## 📋 Prerequisites

1. ✅ Repository GitHub sudah ada
2. ✅ SSH public key sudah di-setup di Hostinger
3. ✅ SSH private key tersedia (untuk GitHub Secrets)

## 🔑 Setup SSH Key di GitHub Secrets

### Langkah 1: Siapkan SSH Private Key

Anda perlu memiliki **SSH Private Key** yang berpasangan dengan public key yang sudah diberikan ke Hostinger.

Jika belum punya private key:
1. Cek di folder `~/.ssh/` di komputer Anda
2. Atau generate baru dengan:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "github-deploy"
   ```

### Langkah 2: Tambahkan ke GitHub Secrets

1. **Buka repository GitHub Anda**
2. **Settings** → **Secrets and variables** → **Actions**
3. **New repository secret**
4. **Name**: `HOSTINGER_SSH_PRIVATE_KEY`
5. **Secret**: Paste **seluruh isi** private key Anda (termasuk `-----BEGIN OPENSSH PRIVATE KEY-----` dan `-----END OPENSSH PRIVATE KEY-----`)
6. **Add secret**

### Cara Copy Private Key (Windows):

```powershell
# Buka file private key dengan notepad
notepad ~/.ssh/id_rsa

# Copy seluruh isinya (Ctrl+A, Ctrl+C)
# Paste ke GitHub Secret
```

## 🔧 Konfigurasi Repository

### 1. Pastikan Branch Default

Workflow akan trigger pada push ke branch `main` atau `master`. Pastikan branch default Anda sesuai.

### 2. File Workflow

File `.github/workflows/deploy.yml` sudah dibuat otomatis dengan konfigurasi:
- ✅ Build otomatis saat push
- ✅ Deploy via SSH menggunakan rsync
- ✅ Clean deployment (hapus file lama)

## 🎯 Cara Menggunakan

### Deployment Otomatis

1. **Push perubahan ke GitHub:**
   ```bash
   git add .
   git commit -m "Update: Tambah layanan Psikotes dan Merek"
   git push origin main
   ```

2. **GitHub Actions akan otomatis:**
   - ✅ Build project
   - ✅ Deploy ke Hostinger via SSH
   - ✅ Update website langsung

3. **Cek status di GitHub:**
   - Buka tab **Actions** di repository
   - Lihat progress deployment

### Deployment Manual (Manual Trigger)

Jika ingin deploy tanpa push:

1. Buka tab **Actions** di GitHub
2. Pilih workflow **Deploy to Hostinger**
3. Klik **Run workflow**
4. Pilih branch → **Run workflow**

## 📁 Struktur Deployment

File yang akan di-deploy:
```
dist/
├── index.html
├── favicon.png
├── favicon.svg
├── site.webmanifest
├── images/
│   └── affiliates/
└── _astro/
    └── *.css
```

Target location di server:
```
/domains/berkahcakrasolusindo.com/public_html/
```

## 🔍 Verifikasi SSH Connection

Sebelum deploy, test koneksi SSH:

```bash
ssh u230709022@id-dci-web1364.main-hosting.eu
# atau
ssh u230709022@145.79.14.23
```

Jika berhasil, berarti SSH key sudah benar.

## 🐛 Troubleshooting

### Error: Permission denied (publickey)

**Solusi:**
1. Pastikan SSH private key sudah benar di GitHub Secrets
2. Pastikan public key sudah di-upload ke Hostinger
3. Pastikan format private key lengkap (termasuk header/footer)

### Error: rsync command not found

**Solusi:**
Workflow sudah menggunakan `rsync` yang tersedia di Ubuntu runner. Jika masih error, cek:
- Pastikan SSH connection berhasil
- Cek permission folder di server

### Error: Connection timeout

**Solusi:**
1. Cek apakah IP/Hostname benar
2. Cek firewall Hostinger
3. Pastikan SSH port (22) tidak di-block

### Deployment berhasil tapi website tidak update

**Solusi:**
1. Clear browser cache (Ctrl + F5)
2. Clear CDN cache di hPanel Hostinger
3. Tunggu beberapa menit untuk propagation

## ✅ Checklist Setup

- [ ] SSH public key sudah di-setup di Hostinger
- [ ] SSH private key sudah ditambahkan ke GitHub Secrets sebagai `HOSTINGER_SSH_PRIVATE_KEY`
- [ ] File `.github/workflows/deploy.yml` sudah ada
- [ ] Test SSH connection manual berhasil
- [ ] Push pertama ke branch main/master untuk trigger workflow

## 🎉 Setup Selesai!

Setelah semua step selesai, setiap kali Anda push ke GitHub, website akan otomatis ter-update di Hostinger!

### Next Steps:
1. ✅ Push perubahan pertama untuk trigger deployment
2. ✅ Monitor di tab Actions untuk melihat log
3. ✅ Verifikasi website setelah deployment selesai

---

**Happy deploying! 🚀**

