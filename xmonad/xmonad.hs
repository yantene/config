import System.IO
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare
import qualified XMonad.StackSet as W

--ターミナル
myTerminal = "termite"

--自動起動
myStartupHook = do
  spawnOnce "pulseaudio --start"
  spawnOnce "synclient TouchpadOff=1"
  spawnOnce "syndaemon -i 0.2 -d"
  spawnOnce "dunst &"
  spawnOnce "touchegg &"
  spawnOnce "timidity -iA &"
  spawnOnce "fcitx-autostart"
  setWMName "LG3D" -- Swing グレー化対策

--ウィンドウ調整
myLayoutHook = avoidStruts $ layoutHook desktopConfig
myManageHook = composeAll [
  manageDocks <+> manageHook desktopConfig,
  className =? "dunst" --> doF W.focusDown <+> doF copyToAll
 ]

--modキー
myModMask = mod4Mask

--フルスクリーンの設定
--myHandleEventHook = fullscreenEventHook
myHandleEventHook = handleEventHook desktopConfig <+> docksEventHook

--XMobar
myLogHook h = dynamicLogWithPP xmobarPP {
  ppOutput = hPutStrLn h
}

--Workspaces
myWorkspaces = [[x] | x <- "123456789"]

--キーバインド設定
myKeys = [
  --rofi
  --("M-d", spawn "rofi -show run"),
  ("M-d", spawn "rofi -run-command \"zsh -c -l -i '{cmd}'\" -show run"),

  --lock
  ("M-S-l", spawn "dm-tool lock"),

  --`xmodmap -pke | grep XF86`でキーの名前が取れるっぽい

  --音量調整
  ("<XF86AudioMute>", spawn "amixer sset Master off"),
  ("<XF86AudioLowerVolume>", spawn "amixer sset Master on 10%-"),
  ("<XF86AudioRaiseVolume>", spawn "amixer sset Master on 10%+"),

  --輝度調整
  ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 2"),
  ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 2"),

  --デュアルスクリーン
  ("<XF86Display>", spawn "dscreen toggle"),

  --ワークスペースを転がす
  ("M-f", moveTo Next NonEmptyWS),
  ("M-s", moveTo Prev NonEmptyWS)
 ]

--main
main = do
  myStatusBar <- spawnPipe "xmobar"
  xmonad $ ewmh desktopConfig {
    handleEventHook = myHandleEventHook,
    layoutHook = myLayoutHook,
    logHook = myLogHook myStatusBar,
    manageHook = myManageHook,
    workspaces = myWorkspaces,
    modMask = myModMask,
    startupHook = myStartupHook,
    terminal = myTerminal
  } `additionalKeysP` myKeys
