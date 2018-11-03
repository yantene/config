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
myTerminal = "WINIT_HIDPI_FACTOR=1.0 alacritty"

--自動起動
myStartupHook = do
  spawnOnce "dunst &"
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
  ("M-d", spawn ("rofi -run-command \"zsh -i -c '{cmd}'\"" ++
                 " -color-window \"#222, #222, #bbb\"" ++
                 " -color-normal \"#222, #bbb, #222, #057, #bbb\"" ++
                 " -color-active \"#222, #bbb, #222, #076, #bbb\"" ++
                 " -color-urgent \"#222, #bbb, #222, #704, #bbb\"" ++
                 " -show run")),

  --lock
  ("M-S-l", spawn "slock"),

  --`xmodmap -pke | grep XF86`でキーの名前が取れるっぽい

  --音量調整
  ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
  ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
  ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%"),

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
