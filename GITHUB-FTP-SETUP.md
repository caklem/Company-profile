# 🔧 Setup Deployment via FTP (Lebih Mudah!)

Metode alternatif menggunakan FTP yang lebih sederhana daripada SSH.

## ⚠️ Mengapa FTP Lebih Mudah?

- ✅ Tidak perlu SSH key pair (public/private key)
- ✅ Hanya butuh password FTP
- ✅ Setup lebih cepat
- ✅ Tidak perlu upload public key ke server

## 📋 Setup GitHub Secret untuk FTP

### Langkah 1: Dapatkan FTP Password

**Dari hPanel Hostinger:**
1. Login ke https://hostinger.com/hpanel
2. Buka **FTP Accounts** atau **File Manager**
3. Cari username: `u230709022`
4. Lihat/reset password FTP

### Langkah 2: Tambahkan ke GitHub Secrets

1. **Buka repository GitHub:**
   - https://github.com/caklem/Company-profile/settings/secrets/actions

2. **Buat Secret Baru:**
   - Klik **New repository secret**

3. **Isi Form:**
   - **Name**: `HOSTINGER_FTP_PASSWORD`
   - **Secret**: Paste password FTP Anda
   - **Add secret**

## 🔄 Mengganti Workflow

Ada 2 pilihan workflow:

### Pilihan 1: Gunakan FTP (Sederhana)
- File: `.github/workflows/deploy-ftp.yml`
- Menggunakan password FTP
- Lebih mudah di-setup

### Pilihan 2: Tetap Gunakan SSH (Lanjutan)
- File: `.github/workflows/deploy.yml`
- Butuh SSH key pair
- Lebih secure

## 🎯 Cara Aktifkan Workflow FTP

### Opsi A: Disable SSH, Enable FTP

1. Rename file workflow:
   ```bash
   # Disable SSH workflow
   mv .github/workflows/deploy.yml .github/workflows/deploy.yml.backup
   
   # Enable FTP workflow
   mv .github/workflows/deploy-ftp.yml .github/workflows/deploy-ftp.yml.active
   ```

2. Atau langsung gunakan:
   - Workflow FTP akan otomatis aktif jika `deploy-ftp.yml` ada di folder `.github/workflows/`

### Opsi B: Gunakan Keduanya (Manual Trigger)

- SSH workflow: `.github/workflows/deploy.yml`
- FTP workflow: `.github/workflows/deploy-ftp.yml`

Kedua workflow akan berjalan, tapi Anda bisa pilih mana yang lebih stabil.

## ✅ Test Deployment FTP

1. **Pastikan secret sudah di-setup:**
   - `HOSTINGER_FTP_PASSWORD` sudah ada di GitHub Secrets

2. **Trigger workflow:**
   - Buka tab **Actions**
   - Pilih workflow **Deploy to Hostinger (FTP)**
   - Klik **Run workflow**

3. **Monitor progress:**
   - Akan melakukan build
   - Upload via FTP
   - Verifikasi selesai

## 🐛 Troubleshooting

### Error: Authentication failed

**Solusi:**
- Cek password FTP di GitHub Secrets
- Pastikan password benar (case-sensitive)
- Reset password di hPanel jika perlu

### Error: Connection timeout

**Solusi:**
- Cek IP server: `145.79.14.23`
- Pastikan FTP port (21) tidak di-block
- Cek firewall Hostinger

### Error: Directory not found

**Solusi:**
- Pastikan path: `/domains/berkahcakrasolusindo.com/public_html/`
- Cek di hPanel apakah path benar
- Tambahkan trailing slash `/` di akhir path

## 📊 Perbandingan SSH vs FTP

| Fitur | SSH | FTP |
|-------|-----|-----|
| Security | ✅ Lebih secure | ⚠️ Kurang secure |
| Setup | ❌ Lebih kompleks | ✅ Lebih mudah |
| Key Management | ❌ Perlu key pair | ✅ Hanya password |
| Speed | ✅ Lebih cepat | ⚠️ Sedikit lebih lambat |
| Recomendation | Production | Development/Testing |

## 🎯 Rekomendasi

**Untuk saat ini, gunakan FTP workflow:**
- ✅ Setup lebih mudah
- ✅ Tidak perlu SSH key
- ✅ Cukup aman untuk deployment website statik

**Nanti bisa upgrade ke SSH jika:**
- ✅ Butuh security lebih tinggi
- ✅ Ingin otomatisasi lebih kompleks
- ✅ Sudah familiar dengan SSH

---

**Setup FTP Secret sekarang dan workflow akan langsung berjalan!** 🚀

