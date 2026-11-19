# Kebudayaan Ngawi — WARBULA

Ditulis oleh Bagas Junianto. Wadah flipbook statis untuk menjelajahi kebudayaan Ngawi.

## Memindahkan ke GitHub sendiri atau teman

1. Ekstrak ZIP ini terlebih dahulu.
2. Pada akun GitHub tujuan, buat repositori publik, misalnya `warbula`.
3. Unggah ISI folder hasil ekstrak ke akar repositori. Pastikan `index.html` langsung berada di akar, bukan di dalam folder tambahan. Pertahankan folder `assets`.
4. Buka Settings > Pages > Build and deployment.
5. Pilih Deploy from a branch, branch `main`, folder `/ (root)`, lalu Save.
6. Tunggu proses penerbitan. Buka tautan yang ditampilkan GitHub Pages.

Tidak perlu Node.js, npm, API key, login siswa, database, domain berbayar, atau ChatGPT untuk menjalankan situs hasil ekspor. Semua jalur aset relatif sehingga dapat digunakan pada alamat proyek GitHub Pages.

Saat berpindah akun, unggah seluruh isi ZIP ke repositori akun teman. Penanda baca tersimpan di browser dan tidak otomatis ikut berpindah alamat situs.

## Mengembangkan isi

- `content.js`: semua 32 halaman dan daftar bab. Edit judul, teks, catatan, dan status di sini.
- `app.js`: renderer dan perilaku pembaca buku.
- `style.css`: tampilan, warna, ukuran tulisan, dan tata letak responsif.
- `assets/`: sampul dan dua logo dari pengguna. Tambahkan foto berizin di sini.
- `index.html`: kerangka halaman dan metadata.

Jenis halaman: cover, title, goals, contents, article, route, chapter, activity, closing.
Bab yang belum berisi materi diberi label Dalam penyusunan. Indeks jelajah halaman 8 bukan peta geografis. Video dan kuis belum diaktifkan; saat ini berupa ruang penyiapan konten.

Jika mengubah jumlah halaman, sesuaikan max pada input pageSlider di index.html dan label/nomor halaman pada daftar bab content.js. Pada jumlah halaman ganjil, tampilan desktop akan memiliki satu halaman kosong terakhir.

Untuk memeriksa secara lokal, buka index.html pada browser modern atau gunakan server statis lokal.

## Memperbarui tombol ekspor

Paket ZIP di situs adalah snapshot saat pengembangan ini. Setelah isi diubah, buat ulang ZIP seluruh berkas situs (kecuali ZIP lama itu sendiri), letakkan sebagai assets/warbula-github-pages.zip. Alternatifnya, gunakan Code > Download ZIP dari GitHub untuk versi sumber terbaru.

## Sumber dan aset

Teks sejarah awal: https://ngawikab.go.id/sejarah/
Ilustrasi sampul dibuat dengan bantuan AI, bersifat konseptual, bukan foto objek sejarah. Logo Kabupaten Ngawi dan STKIP Modern Ngawi disediakan oleh pengguna; tidak menyiratkan pengesahan lembaga. Validasi naskah, foto, video, dan atribusi sebelum uji coba penelitian.

Animasi: StPageFlip 2.0.7. Sertakan assets/vendor/page-flip.browser.js dan LICENSE-StPageFlip.txt saat mengunggah. Library dimuat lokal dengan jalur relatif; tidak memerlukan CDN atau proses build.
