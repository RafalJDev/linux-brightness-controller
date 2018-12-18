# linux-brightness-controller
Bash script to control brightness on ubuntu. 

Features:
  * It automagically find name of your display
  * Limit the max (1.0) and min (0.1) level of brightness
  * Changes yellowish level of your display (decrease blue bligh, better for your eyes)

Example usage: 

    bash brightness_controller 1 u

  * 1st parameter - number of monitor to change brightness on (e.g. my monitor names are DP-1, DP-2)
  * 2nd parameter:
  
        u - brightness up by 0.10
      
        d - brightness down by 0.07 
      
  * 3nd parameter: yellow level `from 0.0 to 1.0` 
  
By moving script to **/usr/local/bin** and **chmod +x brightness_controller** on it,
u can assign it to **shortcut** in settings:
  I have 4 shortcuts:
    - 1st monitor brightness up/down **ctrl+shift 7/1** (numpad)
    - 2nd monitor brightness up/down **ctrl+shift 9/3** (numpad)


# TODO 
 * <s>gamma in **xrandr** (leave unchanged)</s> DONE
 * change brightness depending on program (probably new script) eg. 1.0 brightness for **Intellij IDEA**, 0.5 brightness for **Chrome**
   so works when changing program with **alt+tab**
   
   
