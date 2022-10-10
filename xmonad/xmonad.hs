import Data.Monoid
import Data.Maybe (maybeToList)
import Control.Monad (join, when)
import System.Exit

import XMonad

import XMonad.Util.SpawnOnce
import XMonad.Util.Cursor

import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Spacing (Border (Border), Spacing, spacingRaw)
import XMonad.Layout.BinarySpacePartition

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- ovrDefaultTerm = "alacritty"
ovrDefaultTerm = "kitty" -- let's try it out! :)

ovrClickJustFocuses :: Bool
ovrClickJustFocuses = True

ovrFollowMouseFocus :: Bool
ovrFollowMouseFocus = True

ovrBorderWidth = 3

ovrWorkspaces = ["一", "二", "三", "四", "五", "六", "七", "八", "九"]

ovrFocusedColor = "#8031ca"
ovrNormalColor  = "#4a25aa"

ovrModMask = mod4Mask

rofiShowRun = spawn "rofi -show run"
rofiShowShutdown = spawn "rofi -show menu -modi 'menu:rofi-power-menu --choices=shutdown/hibernate/reboot'"
networkManager = spawn "networkmanager_dmenu &"
lockScreen = spawn "betterlockscreen -l --blur 0.5 --dim 60"
screenshot = spawn "flameshot gui &"


ovrKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ 
      ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), rofiShowRun)
    , ((modm,               xK_n     ), networkManager)
    , ((modm .|. shiftMask, xK_p     ), rofiShowShutdown)
    , ((modm .|. shiftMask, xK_q     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_l     ), lockScreen)
    , ((modm .|. shiftMask, xK_n     ), refresh)
    , ((controlMask,        xK_Print ), screenshot)
    , ((modm,               xK_r     ), sendMessage $ Rotate)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp)
    , ((modm,               xK_m     ), windows W.focusMaster)
    , ((modm,               xK_v     ), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask .|. controlMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --restart")
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

ovrMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
createSpacing :: Integer -> l a -> ModifiedLayout Spacing l a
createSpacing i = spacingRaw True (Border 0 i 0 i) True (Border i 0 i 0) True

ovrLayout = avoidStruts (createSpacing 15 $ Tall 1 (12/100) (1/2) ||| emptyBSP ||| Full)

-- Essentially just managing
-- e.g. "start MPlayer" -> "as floating"
-- ovrManageHook = mempty
--  composeAll
--    [ className =? "MPlayer"        --> doFloat
--    , className =? "Gimp"           --> doFloat
--    , resource  =? "desktop_window" --> doIgnore
--    , resource  =? "kdesktop"       --> doIgnore ]

ovrEventHook = mempty

ovrLogHook :: X ()
ovrLogHook = mempty

ovrStartupHook :: X ()
ovrStartupHook = do
    spawnOnce "eww daemon"
    spawnOnce "picom"
    spawnOnce "dunst"
    spawnOnce "eww open-many main-bar"
    setDefaultCursor xC_left_ptr
    
defaults = def {
        terminal           = ovrDefaultTerm,
        focusFollowsMouse  = ovrFollowMouseFocus,
        clickJustFocuses   = ovrClickJustFocuses,
        borderWidth        = ovrBorderWidth,
        modMask            = ovrModMask,
        workspaces         = ovrWorkspaces,
        normalBorderColor  = ovrNormalColor,
        focusedBorderColor = ovrFocusedColor,

        keys               = ovrKeys,
        mouseBindings      = ovrMouseBindings,

        layoutHook         = ovrLayout,
--      manageHook         = ovrManageHook,
        handleEventHook    = ovrEventHook,
        logHook            = ovrLogHook,
        startupHook        = ovrStartupHook
}

help :: String
help = unlines ["Help:"]

main :: IO ()
main = do
    xmonad $ docks $ ewmh $ ewmhFullscreen $ defaults

