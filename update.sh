echo "bspwm"
cp -r $HOME/.config/bspwm/ .
echo "sxhkd"
cp -r $HOME/.config/sxhkd/ .
echo "polybar"
cp -r $HOME/.config/polybar/ .
echo "nvim"
cp -r $HOME/.config/nvim/init.vim ./nvim/
echo "visimp"
cp -r $HOME/.config/nvim/init.lua ./visimp/
echo "fonts"
cp -r $HOME/.fonts .
echo "picom"
cp -r $HOME/.config/picom/ .
echo "kitty"
cp -r $HOME/.config/kitty/*.conf ./kitty/
echo "rofi"
cp -r $HOME/.config/rofi/my_themes ./rofi/my_themes
cp $HOME/.config/rofi/launcher.sh ./rofi/
cp $HOME/.config/rofi/powermenu.sh ./rofi/

