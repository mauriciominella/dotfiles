# saves a clipboard image to an output stream. Usage: clipimg > ~/Pictures/myimage.png
clipimg(){
   xclip -selection clipboard -t image/png -o
}

