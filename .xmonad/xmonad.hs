import System.IO
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.WorkspaceCompare
import XMonad.Util.Run

--ターミナル
myTerminal = "urxvt"

--Swingグレイ対策
myStartupHook = setWMName "LG3D"

--ウィンドウ調整
myLayoutHook = avoidStruts $ layoutHook defaultConfig
myManageHook = composeAll [
  manageDocks <+> manageHook defaultConfig,
  className =? "Xfce4-notifyd" --> doF W.focusDown <+> doF copyToAll
 ]

--modキー
myModMask = mod4Mask

--フルスクリーンの設定
myHandleEventHook = fullscreenEventHook

--XMobar
myLogHook h = dynamicLogWithPP xmobarPP {
  ppOutput = hPutStrLn h
}

--キーバインド設定
myKeys = [
  --dmenu
  ("M-d", spawn "dmenu_run -b -fn \"Sans-12\""),

  --`xmodmap -pke | grep XF86`でキーの名前が取れるっぽい

  --音量調整
  ("<XF86AudioMute>", spawn "amixer sset Master off"),
  ("<XF86AudioLowerVolume>", spawn "amixer sset Master on 10%-"),
  ("<XF86AudioRaiseVolume>", spawn "amixer sset Master on 10%+"),

  --輝度調整
  ("<XF86MonBrightnessDown>",
    spawn "xbacklight -dec 2; [ \"$(echo \"`xbacklight -get` == 0\" | bc)\" -eq 1 ] && xbacklight -set 2"),
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
  xmonad $ defaultConfig {
    terminal = myTerminal,
    startupHook = myStartupHook,
    modMask = myModMask,
    handleEventHook = myHandleEventHook,
    layoutHook = myLayoutHook,
    manageHook = myManageHook,
    logHook = myLogHook myStatusBar
  } `additionalKeysP` myKeys
