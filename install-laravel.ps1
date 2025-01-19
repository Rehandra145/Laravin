function Show-Banner { 
   Write-Host @"


.____                                    .___         
|    |    _____   _______ _____   ___  __|   |  ____  
|    |    \__  \  \_  __ \\__  \  \  \/ /|   | /    \ 
|    |___  / __ \_ |  | \/ / __ \_ \   / |   ||   |  \
|_______ \(____  / |__|   (____  /  \_/  |___||___|  /
        \/     \/              \/                  \/ 
                                          by handera
"@ -ForegroundColor Red
   Write-Host "Laravel Project Installer" -ForegroundColor Red
   Write-Host "---------------------------" -ForegroundColor Red
}

# Main execution
Clear-Host
Show-Banner

# Menampilkan opsi kepada pengguna
Write-Host "`nPilih versi Laravel untuk diinstall:" -ForegroundColor Red
Write-Host "1. Laravel 10"
Write-Host "2. Laravel 11"
$version_choice = Read-Host "`nMasukkan pilihan (1/2)"

# Menentukan versi berdasarkan input pengguna
switch ($version_choice) {
   "1" { $version = "10" }
   "2" { $version = "11" }
   default {
       Write-Host "ERROR: Pilihan tidak valid!" -ForegroundColor Red
       exit 1
   }
}

# Fungsi untuk memvalidasi nama aplikasi
function Validate-ProjectName {
   param ([string]$input_name)
   if ($input_name -match "\s") {
       return $false
   }
   return $true
}

# Meminta nama aplikasi
do {
   $app_name = Read-Host "`nMasukkan nama aplikasi (tanpa spasi)"
   if (-not (Validate-ProjectName $app_name)) {
       Write-Host "ERROR: Nama aplikasi tidak boleh mengandung spasi!" -ForegroundColor Red
   }
} while (-not (Validate-ProjectName $app_name))

# Menjalankan perintah instalasi Laravel
Write-Host "`nMenginstall Laravel v$version untuk aplikasi '$app_name'..." -ForegroundColor Yellow
Start-Process "composer" -ArgumentList "create-project laravel/laravel:^$version $app_name" -NoNewWindow -Wait

# Menyelesaikan proses
Write-Host "`nInstalasi selesai! Aplikasi '$app_name' telah dibuat." -ForegroundColor Green
cd $app_name

# Membuka folder aplikasi dengan Visual Studio Code
Write-Host "`nMembuka VS Code..." -ForegroundColor Yellow
Start-Process "code" -ArgumentList "."

# Menjalankan php artisan serve dan membuka browser
Write-Host "`nMemulai Laravel server..." -ForegroundColor Yellow
Start-Process "php" "artisan serve" -NoNewWindow
Start-Sleep -Seconds 3
Start-Process "chrome.exe" "http://127.0.0.1:8000/"

Write-Host "`nSelesai! Selamat coding!" -ForegroundColor Green