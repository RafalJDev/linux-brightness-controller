# linux-brightness-controller
Bash script to control brightness on ubuntu. 
Example usage: 
**bash brightness_controller 1 u **

  * 1st parameter - number of monitor (names of my monitors are DP-1, DP-2)
  * 2nd parameter:
      u - brightness up by 0.10
      d - brightness down 0.10
  
By moving script to **/usr/local/bin** and **chmod +x brightness_controller** on it,
u can assign it to **shorcut** in settings:
  I have 4 shorcuts:
    - 1st monitor birghtness up/down **ctrl+shift 7/1** (numpad)
    - 2nd monitor birghtness up/down **ctrl+shift 9/3** (numpad)


# TODO 
 * <s>gamma in **xrandr** (leave unchanged)</s> DONE
 * change brightness depending on program (probably new script) eg. 1.0 brightness for **Intellij IDEA**, 0.5 brightness for **Chrome**
   so works when changing program with **alt+tab**
