import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program
myTerminal = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse = False

-- Click doesn't just focus a window, but actually passes the click through
myClickJustFocuses = False

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#007acc"

-- Key bindings. Mod = Alt
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Launch a terminal. Mod + Shift + Enter
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- Launch dmenu. Mod + p
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- Mute, volume down, & volume up. F6, F7, & F8
    , ((0,                  xK_F6    ), spawn "amixer set Master toggle")
    , ((0,                  xK_F7    ), spawn "amixer set Master playback 6553.6-")
    , ((0,                  xK_F8    ), spawn "amixer set Master playback 6553.6+")

    -- Close focused window. Mod + Shift + c
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Move focus to the next window. Mod + j
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window. Mod + k
    , ((modm,               xK_k     ), windows W.focusUp)

    -- Move focus to the master window. Mod + m
    , ((modm,               xK_m     ), windows W.focusMaster)

    -- Make current window master. Mod + Enter
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap current window with next window. Mod + Shift + j
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)

    -- Swap current window with previous window. Mod + Shift + k
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)

    -- Shrink the master area. Mod + h
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area. Mod + l
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Increment the number of windows in the master area. Mod + ,
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area. Mod + .
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad. Mod + Shift + q
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad. Mod + q
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    ]
    ++

    -- Switch to workspace. Mod + 2 (or 3, 4, etc)
    -- Move window to workspace. Mod + Shift + 2
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Layouts

-- Set gaps
mySpacing = spacingRaw False            -- False = gaps even on single window
                       (Border 5 5 5 5) -- Screen gaps. Top bot right left
                       True             -- Enable screen gap
                       (Border 5 5 5 5) -- Window gaps
                       True             -- Enable window gaps

myLayout = mySpacing $ avoidStruts $ tiled
  where
     -- Partitions the screen into two panes: master and stack
     tiled   = Tall nmaster delta ratio

     -- Number of windows in the master pane
     nmaster = 1

     -- Proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Startup hook. Start picom, set wallpaper, and start xmobar
myStartupHook = do
  spawnOnce "picom"
  spawnOnce "~/.fehbg"
  spawnOnce "xmobar"

-- Main function. Start xmonad with all the options defined in this file.
main = do
  xmonad $ docks defaults

-- Final configuration. Use defaults for anything not set in this file.
defaults = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        layoutHook         = myLayout,
        startupHook        = myStartupHook
    }

