
$InputFile = ""


$OutputDir = "C:\git\cristie-music.github.io\vid\twins"



# Создаем папку, если она не существует
if (-Not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
}

Write-Host "Начинаю адаптацию видео для Web " -ForegroundColor Cyan

# -c:v libx264: Используем лучший кодек для веба
# -crf 18: Постоянное качество (Constant Rate Factor). 18 — это визуально неотличимо от оригинала.
# -preset slow: Тратим больше времени процессора, чтобы файл получился качественнее и меньше весил.
# -c:a aac -b:a 192k: Сжимаем аудио в отличный формат AAC с высоким битрейтом.
# -force_key_frames "expr:gte(t,n_forced*4)": Принудительно ставим "разрезы" каждые 4 секунды.
# -hls_time 4: Длина чанка — строго 4 секунды.
ffmpeg -i $InputFile -c:v libx264 -crf 18 -preset slow -c:a aac -b:a 192k -force_key_frames "expr:gte(t,n_forced*4)" -hls_time 4 -hls_list_size 0 -f hls "$OutputDir\index.m3u8"

Write-Host "Готово! Плейлист и чанки сохранены в $OutputDir" -ForegroundColor Green