import Data.Monoid
import System.Exit

import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Layout.Gaps
import XMonad.Layout.Fullscreen
import XMonad.Layout.BinarySpacePartition

import XMonad.Hooks.EwmhDesktops ( ewmh )

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

ovrDefaultTerm = "alacritty"
-- ovrDefaultTerm = "kitty" -- soon! :D

ovrClickJustFocuses :: Bool
ovrClickJustFocuses = True
ovrFollowMouseFocus :: Bool
ovrFollowMouseFocus = True
ovrBorderWidth      = 3

ovrWorkspaces = ["一", "二", "三", "四", "五", "六", "七", "八", "九"]

ovrFocusedColor = "#8031A7"
ovrNormalColor  = "#4A25AA"

ovrModMask = mod4Mask

-- ewwClose :: String
-- ewwClose = spawn "exec eww close-all"

rofiShowRun = spawn "rofi -show run"
rofiShowShutdown = spawn "rofi -show menu -modi 'menu:rofi-power-menu --choices=shutdown/hibernate/reboot'"
networkManager = spawn "networkmanager_dmenu"


ovrKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ 
      ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), rofiShowRun)
    , ((modm,               xK_n     ), networkManager)
    , ((modm .|. shiftMask, xK_p     ), rofiShowShutdown)
    , ((modm .|. shiftMask, xK_q     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_f     ), withFocused $ \win -> do 
        isFullscreen <- (M.member win . W.floating) `fmap` gets windowset
        if isFullscreen 
        then sendMessage $ RemoveFullscreen win
        else sendMessage $ AddFullscreen win)
    , ((modm .|. shiftMask, xK_n     ), refresh)
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
ovrLayout = gaps [(U,6), (R,10), (D,6), (L,10)] $ Tall 1 (12/100) (1/2) ||| emptyBSP ||| Full

-- Essentially just managing
-- e.g. "start MPlayer" -> "as floating"
-- ovrManageHook = mempty
--  composeAll
--    [ className =? "MPlayer"        --> doFloat
--    , className =? "Gimp"           --> doFloat
--    , resource  =? "desktop_window" --> doIgnore
--    , resource  =? "kdesktop"       --> doIgnore ]

ovrEventHook = mempty

ovrLogHook = return ()

ovrStartupHook :: X ()
ovrStartupHook = do
    spawnOnce "exec eww daemon"
    spawnOnce "picom --experimental-backends"
    spawnOnce "dunst"
    
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
    xmonad $ ewmh defaults

