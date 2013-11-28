import System.IO
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.WorkspaceCompare
import XMonad.Util.Run

--ターミナル
myTerminal = "terminator"

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
  ("M-p", spawn "dmenu_run -b -fn \"Sans-12\""),

  --音量調整
  ("<XF86AudioMute>", spawn "amixer sset Master off"),
  ("<XF86AudioLowerVolume>", spawn "amixer sset Master on 10%-"),
  ("<XF86AudioRaiseVolume>", spawn "amixer sset Master on 10%+"),

  --ワークスペースを転がす
  ("M-d", moveTo Next NonEmptyWS),
  ("M-a", moveTo Prev NonEmptyWS)
 ]

--main
main = do
  myStatusBar <- spawnPipe "xmobar"
  xmonad $ defaultConfig {
    terminal = myTerminal,
    modMask = myModMask,
    handleEventHook = myHandleEventHook,
    layoutHook = myLayoutHook,
    manageHook = myManageHook,
    logHook = myLogHook myStatusBar
  } `additionalKeysP` myKeys
