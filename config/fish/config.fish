set -U fish_greeting

function wl
    set input $argv[1]
    
    if test -z "$input"
        set img (find ~/wl/ -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)
    else if test -f ~/wl/$input
        set img ~/wl/$input
    else if test -f "$input"
        set img "$input"
    else
        echo "Image '$input' not found!"
        return 1
    end

    if test -n "$img"
        echo "Applying: $img"
        
        if not test -f "$img"
            echo "Ошибка: файл обоев не найден по пути: $img"
            return 1
        end

        awww img "$img"
        matugen image "$img" -m dark --type scheme-tonal-spot
        
        niri msg action load-config-file
        pkill waybar; waybar &; disown
        
        echo "Theme updated successfully!"
    end
end
